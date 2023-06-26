#!/usr/bin/env sh

sink="@DEFAULT_SINK@"
source="@DEFAULT_SOURCE@"
notification_id="/tmp/volume-ui.nid"
notification_lock="/tmp/volume-ui.nid.lock"
notification_lock_fd=99

step="5"

set -e

usage() {
	echo "Usage:"
	echo "  ./audio.sh setup-ui"
	echo "  ./audio.sh toggle-output-mute"
	echo "  ./audio.sh toggle-mic-mute"
	echo "  ./audio.sh volume raise|lower"
	echo "  ./audio.sh system-volume raise|lower"
	exit 1
}

if [ "$#" = 0 ]; then
	usage
fi

setupUi() {
	true
}

toggleOutputMute() {
	pactl set-sink-mute "$sink" toggle
	if [ "$(pamixer --get-mute)" = "true" ]; then
		notifyVolumeChange "0"
	else
		notifyVolumeChange "$(pamixer --get-volume)"
	fi
}

toggleMicMute() {
		pactl set-source-mute "$source" toggle
}

changeVolumePulseaudio() {
	volume="$(wpctl get-volume @DEFAULT_SINK@ | cut -d' ' -f2)"
	if [ "$volume" = "0.00" ] && [ "$plusminus" = "-" ]; then
		new_volume="0"
	else
		# compute new volume, round to five
		new_volume="$(echo "scale=0; (($volume*100)$plusminus$step+1)/5*5" | bc)"
	fi
	wpctl set-volume @DEFAULT_SINK@ "$new_volume%"
}

changeVolumePlayerctl() {
	if [ "$1" = "0" ] && [ "$plusminus" = "-" ]; then
		new_volume="0"
	else
		# compute new volume, round to five
		new_volume="$(echo "scale=0; ($1$plusminus$step+1)/5*5" | bc)"
	fi
	if ! playerctl volume "$(echo "scale=2; $new_volume/100" | bc)"; then
		changeVolumePulseaudio
		return
	fi
	metadata="$(playerctl metadata)"
	title=$(getTitle "$metadata")
	image_path=$(getImage "$metadata")
	notifyVolumeChange "$new_volume" "$title" "$image_path"
}

getTitle() {
	title=$(echo "$1" | grep 'xesam:title' | awk -F '[[:space:]][[:space:]]+' '{print $NF}')
	artist=$(echo "$1" | grep 'xesam:artist' | awk -F '[[:space:]][[:space:]]+' '{print $NF}')
	if [ -n "$title" ] && [ -n "$artist" ]; then
		echo "$artist - $title"
	fi
}

getImage() {
	url=$(echo "$1" | grep 'mpris:artUrl' | awk -F '[[:space:]][[:space:]]+' '{print $NF}')
	if [ -z "$url" ]; then
		return
	fi
	name="${url##*/}"
	path="/tmp/volume-ui/$name"
	if [ -e "$path" ]; then
		echo "$path"
	else
		mkdir "/tmp/volume-ui"
		curl -Lo "$path" "$url" || return
		echo "$path"
	fi
}

unlock() {
	flock -u $notification_lock_fd
	flock -xn $notification_lock_fd && rm -f $notification_lock
}

notifyVolumeChange() {
		eval "exec $notification_lock_fd>\"$notification_lock\""
		trap unlock EXIT
		flock -x $notification_lock_fd

		if [ -n "$2" ] && [ -n "$3" ]; then
			icon="$3"
		elif [ "$1" -eq "0" ]; then
			icon="audio-volume-muted";
		elif [ "$1" -lt "30" ]; then
			icon="audio-volume-low";
		elif [ "$1" -lt "70" ]; then
			icon="audio-volume-medium"
		else
			icon="audio-volume-high"
		fi
		nid="$(cat "$notification_id")"
		if [ -n "$2" ]; then
			nid=$(notify-send --category volume --icon "$icon" --print-id --replace-id "${nid:-0}" "$2" "Volume: $1%")
		else
			nid=$(notify-send --category volume --icon "$icon" --print-id --replace-id "${nid:-0}" "$1%")
		fi
		echo "$nid" > "$notification_id"
}

setPlusMinus() {
	case "$2" in
		raise) plusminus="+" ;;
		lower) plusminus="-" ;;
		*) usage
	esac
}

changeSystemVolume() {
	setPlusMinus "$@"
	changeVolumePulseaudio
}

changeVolume() {
	setPlusMinus "$@"

	music_status=$(playerctl status || true)
	if [ "$music_status" = "Playing" ]; then
		raw_volume=$(playerctl volume 2> /dev/null || true)
		if [ -n "$raw_volume" ]; then
			music_volume=$(echo "scale=0; ($raw_volume * 100)/1" | bc)
			if [ "$2" = "lower" ] || [ "$music_volume" != "100" ]; then
				if changeVolumePlayerctl "$music_volume"; then
					return
				fi
			fi
		fi
	fi
	changeVolumePulseaudio
}

case "$1" in
	setup-ui) setupUi ;;
	toggle-output-mute) toggleOutputMute ;;
	toggle-mic-mute) toggleMicMute ;;
	volume) changeVolume "$@" ;;
	system-volume) changeSystemVolume "$@" ;;
	*) usage ;;
esac


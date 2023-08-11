#!/usr/bin/env sh

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
	echo "  ./audio.sh play"
	echo "  ./audio.sh pause"
	echo "  ./audio.sh play-pause"
	echo "  ./audio.sh next"
	echo "  ./audio.sh prev"
	exit 1
}

if [ "$#" = 0 ]; then
	usage
fi

playerctl() {
	command playerctl --ignore-player "chromium" "$@"
}

setupUi() {
	true
}

toggleOutputMute() {
	wpctl set-mute @DEFAULT_SINK@ toggle
}

toggleMicMute() {
	wpctl set-mute @DEFAULT_SOURCE@ toggle
}

changeVolumePulseaudio() {
	volume="$(wpctl get-volume @DEFAULT_SINK@ | cut -d' ' -f2)"
	if [ "$volume" = "0.00" ] && [ "$plusminus" = "-" ]; then
		new_volume="0"
	else
		# compute new volume, round to step
		new_volume="$(echo "scale=0; (($volume*100)$plusminus$step+1)/$step*$step" | bc)"
	fi
	wpctl set-volume @DEFAULT_SINK@ "$new_volume%"
}

changeVolumePlayerctl() {
	if [ "$1" = "0" ] && [ "$plusminus" = "-" ]; then
		new_volume="0"
	else
		# compute new volume, round to step
		new_volume="$(echo "scale=0; ($1$plusminus$step+1)/$step*$step" | bc)"
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
	title=$(echo "$1" | grep 'xesam:title' | awk -F '[[:space:]]{4,}' '{print $NF}')
	artist=$(echo "$1" | grep 'xesam:artist' | awk -F '[[:space:]]{4,}' '{print $NF}')
	title=${title#"$artist - "}
	if [ -n "$title" ] && [ -n "$artist" ]; then
		echo "$artist - $title"
	fi
}

getImage() {
	url=$(echo "$1" | grep 'mpris:artUrl' | awk -F '[[:space:]]{4,}' '{print $NF}')
	if [ -z "$url" ]; then
		return
	fi
	name="${url##*/}"
	path="/tmp/volume-ui/$name"
	if [ -e "$path" ]; then
		echo "$path"
	else
		mkdir -p "/tmp/volume-ui"
		curl -Lo "$path" "$url" || return
		echo "$path"
	fi
}

unlock() {
	flock -u $notification_lock_fd
	flock -xn $notification_lock_fd && rm -f $notification_lock
}

notifyVolumeChange() {
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
		if [ -n "$2" ]; then
			notify "$2" "Volume: $1%" "$icon"
		else
			notify "$2" "$1%" "$icon"
		fi
}

notify() {
		eval "exec $notification_lock_fd>\"$notification_lock\""
		trap unlock EXIT
		flock -x $notification_lock_fd

		nid="$(cat "$notification_id" || true)"
		notify-send --category music --icon "$3" --print-id --replace-id "${nid:-0}" "$1" "$2" > "$notification_id"
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

play() {
	playerctl play
	metadata="$(playerctl metadata)"
	title=$(getTitle "$metadata")
	image_path=$(getImage "$metadata")
	notify "$title" "" "$image_path"
}

playPause() {
	playerctl play-pause
	sleep .15
	music_status=$(playerctl status || true)
	if [ "$music_status" = "Playing" ]; then
		metadata="$(playerctl metadata)"
		title=$(getTitle "$metadata")
		image_path=$(getImage "$metadata")
		notify "$title" "" "$image_path"
	fi
}

next() {
	playerctl next
	sleep .25
	metadata="$(playerctl metadata)"
	title=$(getTitle "$metadata")
	image_path=$(getImage "$metadata")
	notify "$title" "" "$image_path"
}

previous() {
	playerctl previous
	sleep .25
	metadata="$(playerctl metadata)"
	title=$(getTitle "$metadata")
	image_path=$(getImage "$metadata")
	notify "$title" "" "$image_path"
}

case "$1" in
	setup-ui) setupUi ;;
	toggle-output-mute) toggleOutputMute ;;
	toggle-mic-mute) toggleMicMute ;;
	volume) changeVolume "$@" ;;
	system-volume) changeSystemVolume "$@" ;;
	play) play ;;
	pause) playerctl pause ;;
	play-pause) playPause ;;
	next) next ;;
	previous) previous ;;
	*) usage ;;
esac


#!/usr/bin/env sh

sink="@DEFAULT_SINK@"
source="@DEFAULT_SOURCE@"
ui_pipe="$SWAYSOCK.wob"

playerctl_step="0.05"
pulseaudio_step="5"

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
    if [ ! -e "$ui_pipe" ]; then
      mkfifo "$ui_pipe"
    fi
    if ! pgrep wob; then
      tail -f "$ui_pipe" | wob --height 40 --background-color \#0f1419ff --border-color \#999999ff --bar-color \#bbbbbbff --offset 0 --padding 4 --border 2
    fi
}

toggleOutputMute() {
    pactl set-sink-mute "$sink" toggle
    if [ -e "$ui_pipe" ]; then
      ( pamixer --get-mute && echo 0 > "$ui_pipe" ) || pamixer --get-volume > "$ui_pipe"
    fi
}

toggleMicMute() {
    pactl set-source-mute "$source" toggle
}

changeVolumePulseaudio() {
  pactl set-sink-volume "$sink" "$plusminus$pulseaudio_step%"
  if [ -e "$ui_pipe" ]; then
    pamixer --get-volume > "$ui_pipe"
  fi
}

changeVolumePlayerctl() {
  playerctl volume "$playerctl_step$plusminus"
  if [ -e "$ui_pipe" ]; then
    if [ "$1" = "0" ] && [ "$plusminus" = "-" ]; then
      echo "scale=0; 0" | bc > "$ui_pipe"
    else
      echo "scale=0; $1 + ((0$plusminus$playerctl_step) * 100)/1" | bc > "$ui_pipe"
    fi
  fi
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
    raw_volume=$(playerctl volume)
    # shellcheck disable=SC2181 # only run playerctl volume once
    if [ "$?" = "0" ]; then
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


#!/bin/bash

set -e

if [[ "$1" = "timeout" ]]; then
  num_monitors="$(swaymsg -t get_outputs | jq -r 'length')"

  brightnessctl --save
  if [[ "$num_monitors" -eq 1 ]]; then
    brightnessctl set 5%
  else
    systemd-inhibit \
      --what=sleep \
      --who=screen-timeout \
      --why='Non locking screen blanking' \
      --mode=block \
      sleep 30 &
    swaymsg output '*' power off
  fi
elif [[ "$1" = "restore" ]]; then
  brightnessctl --restore
  swaymsg output '*' power on
fi

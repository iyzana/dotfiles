#!/bin/env bash

set -e
set -o pipefail

min_t=4000
max_t=6500
min_b=5
max_b=80

# min_t->min_b, max_t->max_b
brightness=$(( ($1 - min_t) * (max_b - min_b) / (max_t - min_t) + min_b ))

# only use ddc when necessary
ddc_cache="/tmp/ddc-brightness"
if [[ -e "$ddc_cache" ]]; then
  current_brightness=$(<"$ddc_cache")
  if [[ "$brightness" == "$current_brightness" ]]; then
    echo "insignificant brightness change"
    exit 0
  fi
fi
echo "$brightness" > "$ddc_cache"

# wait until we're not fullscreen anymore
pidfile="/tmp/ddc-brightness.pid"
if [[ -e "$pidfile" ]]; then
  echo "killing current script"
  kill "$(<$pidfile)" || true
fi
echo $$ >"$pidfile"
while wlrctl toplevel find state:fullscreen state:active; do
  echo "waiting for user to exit fullscreen"
  sleep 5s
done
rm "$pidfile"

echo "setting brightness to $brightness"

ddcutil -d 1 setvcp 10 "$brightness"
ddcutil -d 2 setvcp 10 "$brightness"

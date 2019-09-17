#!/bin/bash

ALERTED=false

while true; do
  STATUS=$(upower -i "$(upower -e | grep BAT)")

  if [[ "$ALERTED" == false ]]; then
    if echo "$STATUS" | grep -q 'discharging'; then
      PERCENT=$(echo "$STATUS" | grep 'percentage: '| grep -Eo '[0-9]+')
      if [[ "$PERCENT" -le 8 ]]; then
        REMAINING=$(echo "$STATUS" | grep 'time to empty' | awk '{ print $4,$5 }')
        notify-send -a battery -u critical "battery low" "~$REMAINING remaining"
        ALERTED=true
      fi
    fi
  else
    if echo "$STATUS" | grep -q ' charging'; then
      ALERTED=false
    fi
  fi

  sleep 1m
done

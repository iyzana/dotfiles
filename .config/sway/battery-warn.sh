#!/bin/bash

ALERTED=false

while true; do
  STATUS=$(upower -i "$(upower -e | grep BAT)")

  if [[ "$ALERTED" == false ]]; then
    if echo "$STATUS" | grep -q 'state:\s*discharging'; then
      PERCENT=$(echo "$STATUS" | grep 'percentage: '| grep -Eo '[0-9]+')
      REMAINING=$(echo "$STATUS" | grep 'time to empty' | awk '{ print $4,$5 }')
      REMAINING_MIN=$(units -t -- "$REMAINING" "minutes")
      ACTUAL_REMAINING=$(echo "scale=1; $REMAINING_MIN / $PERCENT * ($PERCENT - 5)" | bc)

      if (( $(echo "$ACTUAL_REMAINING <= 15.0" | bc -l) )); then
        swaymsg fullscreen disable
        notify-send -a battery -u critical "battery low" "at $PERCENT%, ~$ACTUAL_REMAINING minutes remaining"
        ALERTED=true
      fi
    fi
  else
    if echo "$STATUS" | grep -q 'state:\s*charging'; then
      ALERTED=false
    fi
  fi

  sleep 1m
done

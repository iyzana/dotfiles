#!/bin/bash

BATTERY_DEVICE=$(upower -e | grep BAT | head -n 1)

while true; do
  STATUS=$(upower -i "$BATTERY_DEVICE")
  if echo "$STATUS" | grep -q 'state:\s*discharging'; then
    PERCENT=$(echo "$STATUS" | grep 'percentage: '| grep -Eo '[0-9]+')
    if [[ "$PERCENT" -ne "100" ]]; then
      REMAINING=$(echo "$STATUS" | grep 'time to empty' | awk '{ print $4,$5 }')
      REMAINING_MIN=$(units -t -- "$REMAINING" "minutes")
      # reduce time, because os shuts down earlier
      ACTUAL_REMAINING=$(echo "scale=1; $REMAINING_MIN / $PERCENT * ($PERCENT - 3)" | bc)

      if (( $(echo "$ACTUAL_REMAINING <= 15.0" | bc -l) )) || [[ -n "$NOTIFICATION_ID" ]]; then
        NOTIFICATION_ID=$(\
          notify-send \
            --app-name battery \
            --urgency critical \
            --replace-id="${NOTIFICATION_ID:-0}" \
            --print-id \
            "battery low" \
            "~$ACTUAL_REMAINING minutes remaining"
        )
      fi
    fi
  fi

  if echo "$STATUS" | grep -q 'state:\s*\(charging\|fully-charged\)'; then
    notify-send --urgency critical --replace-id="$NOTIFICATION_ID" --expire-time=1 "battery low"
    unset NOTIFICATION_ID
  fi

  if [[ -z "$NOTIFICATION_ID" ]]; then
    sleep 1m
  else
    sleep 5s
  fi
done

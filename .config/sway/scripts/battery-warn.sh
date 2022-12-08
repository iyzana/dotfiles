#!/bin/bash

ALERTED=false
NOTIFICATION_ID=0

while true; do
  if [[ "$ALERTED" == false ]]; then
    sleep 1m
    STATUS=$(upower -i "$(upower -e | grep BAT)")
    if echo "$STATUS" | grep -q 'state:\s*discharging'; then
      PERCENT=$(echo "$STATUS" | grep 'percentage: '| grep -Eo '[0-9]+')
      if [[ "$PERCENT" -ne "100" ]]; then
        REMAINING=$(echo "$STATUS" | grep 'time to empty' | awk '{ print $4,$5 }')
        REMAINING_MIN=$(units -t -- "$REMAINING" "minutes")
        # reduce time, because os shuts down earlier
        ACTUAL_REMAINING=$(echo "scale=1; $REMAINING_MIN / $PERCENT * ($PERCENT - 3)" | bc)

        if (( $(echo "$ACTUAL_REMAINING <= 15.0" | bc -l) )); then
          NOTIFICATION_ID=$(\
            notify-send \
              --app-name battery \
              --urgency critical \
              --print-id \
              "battery low" \
              "~$ACTUAL_REMAINING minutes remaining"
          )
          ALERTED=true
        fi
      fi
    fi
  else
    sleep 2s
    STATUS=$(upower -i "$(upower -e | grep BAT)")
    if echo "$STATUS" | grep -q 'state:\s*\(charging\|fully-charged\)'; then
      notify-send --urgency critical --replace-id="$NOTIFICATION_ID" --expire-time=1 "battery low"
      ALERTED=false
    fi
  fi
done

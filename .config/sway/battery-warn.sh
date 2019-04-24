#!/bin/bash

ALERTED=false

while [ true ]; do
    STATUS=`upower -i $(upower -e | grep BAT)`

    if [[ "$ALERTED" = false ]]; then
        if [[ -n `echo "$STATUS" | grep discharging` ]]; then
            PERCENT=`echo "$STATUS" | grep percent | grep -Eo '[0-9]+'`
            if [[ "$PERCENT" -le 5 ]]; then
                REMAINING=`echo "$STATUS" | grep 'time to empty' | awk '{ print $4,$5 }'`
                notify-send -a battery -u critical "battery low" "~$REMAINING remaining";
                ALERTED=true
            fi
        fi
    fi

    if [[ -n `echo "$STATUS" | grep ' charging'` ]]; then
        ALERTED=false
    fi

    sleep 1m
done

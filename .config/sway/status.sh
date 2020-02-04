while true; do
    battery=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
    battery_pct=$(echo "$battery" | grep percent | awk '{ print $2 }')
    if echo "$battery" | grep 'state:\s*charging' > /dev/null; then
        charging="+"
    else
        charging=""
    fi
    date=$(date +'%a, %Y-%m-%d %H:%M:%S')

    echo "$battery_pct$charging - $date"
    sleep 1
done

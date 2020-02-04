while true; do
    battery=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
    battery_pct=$(echo "$battery" | grep percent | awk '{ print $2 }' | tr -d '%')
    charging=""
    if echo "$battery" | grep 'state:\s*charging' > /dev/null; then
        charging="🗲"
    fi
    date=$(date +'%a, %Y-%m-%d %H:%M:%S')

    echo "$date   $battery_pct％$charging"
    sleep 1
done

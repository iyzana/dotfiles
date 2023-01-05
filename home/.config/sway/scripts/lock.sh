#!/bin/sh

if pgrep swaylock; then
    exit
fi

swayidle \
    timeout 5 'swaymsg "output * power off"' \
    resume 'swaymsg "output * power on"' &

while ! swaylock; do
    :
done

kill %%

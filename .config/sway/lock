#!/bin/sh

if pgrep swaylock; then
    exit
fi

swayidle \
    timeout 5 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &

swaylock

kill %%

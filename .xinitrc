# load keymap
setxkbmap -model pc104 -layout de -variant nodeadkeys -option compose:lctrl-altgr
xmodmap ~/.Xmodmap

# enable numlock
numlockx &

# disable turning off screen
xset -dpms
xset s off

# set dpi
xrandr --dpi 120

# set background
# ~/.fehbg &
hsetroot -solid "#1c1c1c"

# configure graphic tablet
xsetwacom set "Wacom Intuos BT S Pen stylus" MapToOutput "HEAD-0"

# update env
systemctl --user import-environment DISPLAY XAUTHORITY
if which dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# start i3
echo "starting at $(date)" >> ~/.local/share/i3/logfile
exec i3 -V -d all > ~/.local/share/i3/logfile

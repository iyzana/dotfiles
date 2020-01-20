# load keymap
setxkbmap -model pc104 -layout de -variant nodeadkeys -option compose:menu
xmodmap ~/.Xmodmap

# enable numlock
numlockx &

# disable turning off screen
xset -dpms
xset s off

# set background
~/.fehbg &

# start i3
echo "starting at $(date)" >> ~/.local/share/i3/logfile
exec i3 -V -d all > ~/.local/share/i3/logfile

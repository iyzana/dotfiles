# set languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_MESSAGES=C
export LC_TIME=en_DK.UTF-8

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

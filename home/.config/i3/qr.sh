#!/bin/env bash

file="/tmp/qr-$(date).png"
qrencode "$(xclip -selection clipboard -out)" -o "$file" \
    || convert -background black -fill white -pointsize 24 -font Roboto label:'Too large' "$file"
eog -n "$file"
rm "$file"

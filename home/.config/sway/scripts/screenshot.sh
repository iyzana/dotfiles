#!/bin/sh

file=$(mktemp)
grim - > "$file"
region=$(slurp -f '%wx%h+%x+%y')
convert -crop "$region" "$file" - | wl-copy
rm "$file"


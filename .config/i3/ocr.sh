#!/bin/env bash

targets=$(xclip -selection clipboard -out -target TARGETS)
if echo "$targets" | grep 'image/png'; then
    image_file="/tmp/ocr-image-$(date --iso-8601=seconds)"
    text_file="/tmp/ocr-text-$(date --iso-8601=seconds)"
    xclip -selection clipboard -out -target 'image/png' > "$image_file"
    languages=$(
        find /usr/share/tessdata -maxdepth 1 -type f -name '*.traineddata' -print0 | xargs --null --replace=_ --max-args=1 basename _ .traineddata
    )
    lang=$(echo "$languages" | rofi -dmenu -p "language")
    tesseract -l "$lang" "$image_file" "$text_file"
    xclip -selection clipboard < "$text_file.txt"
    rm "$image_file" "$text_file.txt"
    notify-send 'ocr' "$lang text copied to clipboard"
else
    notify-send 'ocr' 'unsupported clipboard format'
fi

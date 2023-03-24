#!/bin/env bash

targets=$(wl-paste -l)
if echo "$targets" | grep 'image/png'; then
    languages=$(
        find /usr/share/tessdata \
            -maxdepth 1 \
            -type f \
            -name '*.traineddata' \
            -print0 \
            | xargs \
            --null \
            --replace=_ \
            --max-args=1 \
            basename _ .traineddata
    )
    lang=$(echo "$languages" | rofi -dmenu -p "language")
    wl-paste \
        | tesseract stdin stdout -l "$lang"  \
        | wl-copy
    notify-send 'ocr' "$lang text copied to clipboard"
else
    notify-send 'ocr' 'unsupported clipboard format'
fi

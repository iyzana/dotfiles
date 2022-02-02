#!/bin/env bash

targets=$(xclip -selection clipboard -out -target TARGETS)
if echo "$targets" | grep 'image/png'; then
    filename="screenshot-$(date +'%Y-%m-%dT%H%M%S').png"
    xclip -selection clipboard -out -target 'image/png' \
        | curl \
            --form "file=@-;filename=$filename" \
            --form 'keep_for=86400' \
            --form "password=$DATATRASH_PASSWORD" \
            https://trash.randomerror.de/upload \
        | tr --delete '\n' \
        | xclip -selection clipboard
    notify-send 'datatrash' 'upload complete'
elif echo "$targets" | grep 'text/uri-list'; then
    notify-send 'datatrash' 'unsupported clipboard format'
elif echo "$targets" | grep 'UTF8_STRING'; then
    xclip -selection clipboard -out -target 'UTF8_STRING' \
        | curl \
            --form "text=@-" \
            --form 'keep_for=86400' \
            --form "password=$DATATRASH_PASSWORD" \
            https://trash.randomerror.de/upload \
        | cut -f1-4 -d/ \
        | tr --delete '\n' \
        | xclip -selection clipboard
    notify-send 'datatrash' 'upload complete'
else
    notify-send 'datatrash' 'unsupported clipboard format'
fi

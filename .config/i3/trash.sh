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
    file_uris=$(xclip -selection clipboard -out -target 'text/uri-list')
    if [[ "$(echo "$file_uris" | wc -l)" != 1 ]]; then
        notify-send 'datatrash' 'more than one element selected'
        exit
    fi
    if [[ ! "$file_uris" =~ ^file://.*$ ]]; then
        notify-send 'datatrash' 'selection is not a file'
        exit
    fi
    # strip file://
    file_path=$(echo "$file_uris" | tail --bytes=+8) 
    curl \
        --form "file=@$file_path" \
        --form 'keep_for=86400' \
        --form "password=$DATATRASH_PASSWORD" \
        https://trash.randomerror.de/upload \
        | tr --delete '\n' \
        | xclip -selection clipboard
    notify-send 'datatrash' 'upload complete'
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

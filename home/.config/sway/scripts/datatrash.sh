#!/bin/env bash

KEEP_SECONDS="86400"

targets=$(wl-paste --list-types)
if echo "$targets" | grep 'image/png'; then
    filename="screenshot-$(date +'%Y-%m-%dT%H%M%S').png"
    wl-paste --type 'image/png' \
        | curl \
            --form "file=@-;filename=$filename" \
            --form "keep_for=$KEEP_SECONDS" \
            --form "password=$DATATRASH_PASSWORD" \
            https://trash.randomerror.de/upload \
        | wl-copy --trim-newline
    notify-send 'datatrash' 'upload complete'
elif echo "$targets" | grep 'text/uri-list'; then
    file_uris=$(wl-paste --type 'text/uri-list')
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
        --form "keep_for=$KEEP_SECONDS" \
        --form "password=$DATATRASH_PASSWORD" \
        https://trash.randomerror.de/upload \
        | wl-copy --trim-newline
    notify-send 'datatrash' 'upload complete'
elif echo "$targets" | grep 'UTF8_STRING'; then
    wl-paste --type 'UTF8_STRING' \
        | curl \
            --form "text=@-" \
            --form "keep_for=$KEEP_SECONDS" \
            --form "password=$DATATRASH_PASSWORD" \
            https://trash.randomerror.de/upload \
        | cut -f1-4 -d/ \
        | wl-copy --trim-newline
    notify-send 'datatrash' 'upload complete'
else
    notify-send 'datatrash' 'unsupported clipboard format'
fi

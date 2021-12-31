#!/bin/env bash

xclip -selection clipboard -out -target image/jpg \
    | curl \
        --form "file=@-;filename=screenshot-$(date +'%Y-%m-%dT%H%M%S').jpg" \
        --form 'keep_for=86400' \
        --form "password=$DATATRASH_PASSWORD" \
        https://trash.randomerror.de/upload \
    | tr --delete '\n' \
    | xclip -selection clipboard
notify-send 'datatrash' 'upload complete'


#!/bin/sh


dl() {
    url="$1"
    metadata="$(youtube-dl -j "$url" | jq '{title: .title, id: .id, upload_date: .upload_date, is_live: .is_live, uploader: .uploader, thumbnail: .thumbnails | max_by(.height).url}')"
    title=$(echo "$metadata" | jq -r '.title' | sed 's|/| |g')
    id=$(echo "$metadata" | jq -r '.id')
    upload_date=$(echo "$metadata" | jq -r '.upload_date')
    uploader=$(echo "$metadata" | jq -r '.uploader' | sed 's|/| |g')
    is_live=$(echo "$metadata" | jq -r '.is_live')
    thumburl=$(echo "$metadata" | jq -r '.thumbnail')
    out="$uploader ($upload_date): $title"

    [ -z "$metadata" ] && return 1

    [ ! -e "$out.jpg" ] && curl -o "${out}.jpg" "$thumburl"

    if [ "$is_live" = 'true' ]; then
        [ -e "$out.mkv" ] && echo "$out.mkv exists, exiting" && return 0
        ffmpeg -i $(youtube-dl -g "$url") -c copy "${out}.mkv" # this will hang when the stream ends maybe some ffmpeg option could help
    else
        youtube-dl "$url" -o "$out.%(ext)s" && return 0
    fi

    return 1
}


while ! dl "$1"; do
    sleep 15
done

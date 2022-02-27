#!/bin/bash

function extract() {
    echo -n "$1" | sed 's/\\"/"/g' | cut -c $2- | rev | cut -c $3- | rev
}

function get_title() {
    local class="$1"
    local trim="$2"
    local search="$3"

    local win_id=$(xdotool search $search --classname --limit 1 "$class")

    if [[ -n "$win_id" ]]
    then
        local title=$(xprop -id "$win_id" _NET_WM_NAME 2>/dev/null)
        echo -n "$(extract "$title" 30 $trim)"
    fi
}

echo "%{T3} %{T-} $(playerctl metadata artist 2>/dev/null)" | cut -c -50

    # # Display the Twitch streamer if Twitch is running
    # twitch=$(get_title 'twitch' 11 '--onlyvisible')
    # if [[ -n "$twitch" ]]
    # then
    #     printf "%%{T8}%%{T-}  %s\n" "$twitch"
    #     if [[ -n "$youtube" ]]
    #     then
    #         sleep 3
    #     fi
    # fi

    # Display the YouTube video title if YouTube is playing
    # youtube=$(get_title 'youtube.com' 12)
    # if [[ -n "$youtube" ]]
    # then
    #     printf "%%{T3}%%{T-}  %s\n" "$youtube"
    #     if [[ -n "$twitch" ]]
    #     then
    #         sleep 3
    #     fi
    # fi
    # 
    # if [[ -z "$youtube" && -z "$twitch" ]]
    # then
    #     echo ""
    # fi

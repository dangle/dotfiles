#!/bin/bash

eval $(xdpyinfo | awk '
    /dimensions/{
        gsub("x", " ")

        print "W=" $2
        print "\nH=" $3
    }
')

eval $(xrandr | awk '
    /primary/ {
        gsub("x|+", " ")

        print "  W=" $4
        print "; H=" $5
        print "; X=" $6
        print "; Y=" $7
    }
')

LEFT=$X
RIGHT=$(($X + $W))
TOP=$Y
BOTTOM=$(($Y + $H))

function popup() {
    dzen2 \
        -p 1 \
        -h 400 \
        -w 50 \
        -x $(($RIGHT - 66)) \
        -y $(($TOP + 20)) \
        -bg '#000' \
        -fg '#000'
}

function progress() {
    gdbar \
        -fg '#F55' \
        -bg '#000' \
        -sw 30 \
        -w 80 \
        -h 380 \
        -max 100 \
        -min 0 \
        -s v
}

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

echo "$VOLUME" | progress | popup

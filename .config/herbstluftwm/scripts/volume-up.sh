#!/bin/bash

pactl set-sink-mute @DEFAULT_SINK@ 0

VOLUME=$( pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
VOLUME=$(( VOLUME > 95 ? 95 : $VOLUME))
pactl set-sink-volume @DEFAULT_SINK@ $(( 65535 / 100 * $VOLUME + (65535 / 20) ))

$(dirname "$0")/volume-display.sh

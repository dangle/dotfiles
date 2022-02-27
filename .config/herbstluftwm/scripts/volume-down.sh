#!/bin/bash

pactl set-sink-mute @DEFAULT_SINK@ 0
pactl set-sink-volume @DEFAULT_SINK@ -5%

$(dirname "$0")/volume-display.sh

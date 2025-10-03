#!/usr/bin/env bash

playerctl pause
#wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
qs -c noctalia-shell ipc call lockScreen toggle
niri msg action power-off-monitors

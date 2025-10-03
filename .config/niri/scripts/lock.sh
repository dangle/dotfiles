#!/usr/bin/env bash

playerctl pause
qs -c noctalia-shell ipc call lockScreen toggle
niri msg action power-off-monitors

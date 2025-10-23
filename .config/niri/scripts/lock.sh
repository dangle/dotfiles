#!/usr/bin/env bash

playerctl pause
qs -c noctalia-shell ipc call lockScreen lock
niri msg action power-off-monitors

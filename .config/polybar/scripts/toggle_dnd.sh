#!/bin/bash

if pgrep -f notification-daemon >/dev/null 2>&1
then
    pkill -f notification-daemon
else
    source ~/.config/herbstluftwm/autostart.d/10-notification-daemon
fi

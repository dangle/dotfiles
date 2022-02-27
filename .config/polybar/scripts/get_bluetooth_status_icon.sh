#!/bin/bash

#case $(playerctl status 2>/dev/null) in
#    "Paused")
#        echo %{T3}
#        ;;
#    "Playing")
#        echo %{T3}
#        ;;
#esac


COLOR=FFFFFF

if [[ $(pactl get-default-sink) = bluez* ]]
then
    COLOR=4776A6
fi

echo "%{F#${COLOR}}%{T3}%{T-}%{F-}"

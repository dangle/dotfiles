#!/bin/bash

case $(playerctl status 2>/dev/null) in
    "Paused")
        echo %{T3}
        ;;
    "Playing")
        echo %{T3}
        ;;
esac

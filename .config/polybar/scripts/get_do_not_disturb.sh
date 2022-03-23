#!/bin/bash

if pgrep -f notification-daemon >/dev/null 2>&1
then
    echo '%{T8}%{T-}'
else
    echo '%{T8}%{T-}'
fi


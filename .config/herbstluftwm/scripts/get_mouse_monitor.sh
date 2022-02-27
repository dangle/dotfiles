#!/usr/bin/env bash

IFS=$'\n'

eval $(xdotool getmouselocation --shell --prefix "MOUSE_")

for monitor in $(herbstclient list_monitors)
do
    eval $(awk '{
            print "ID=" $1
            print "W="  $2
            print "H="  $3
            print "X="  $4
            print "Y="  $5
        }' <<< $(
        awk '{
            gsub(/:/,   "",  $1)
            gsub(/x|+/, " ", $2)
            print $1 " " $2
        }' <<< ${monitor}
    ))
    if (( $MOUSE_X >= $X && $MOUSE_X < $X + $W
       && $MOUSE_Y >= $Y && $MOUSE_Y < $Y + $H ))
    then
        echo $ID
        break
    fi
done

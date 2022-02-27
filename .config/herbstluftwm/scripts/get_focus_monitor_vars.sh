#!/bin/bash

herbstclient list_monitors | awk -F '[:+x\" ]' '/\[FOCUS\]/{
    print "ID="      $1
    print "WIDTH="   $3
    print "HEIGHT="  $4
    print "XOFFSET=" $5
    print "YOFFSET=" $6
    print "TAG="     $10
}'

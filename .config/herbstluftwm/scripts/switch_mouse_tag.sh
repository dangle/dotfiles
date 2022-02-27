#!/bin/bash

DIRECTION=${1:-next}
USE=$(echo ${DIRECTION:0:4} | tr '[:lower:]' '[:upper:]')

herbstclient focus_monitor $($(dirname "$0")/get_mouse_monitor.sh)
herbstclient or , substitute ${USE} tags.focus.my_${DIRECTION}_tag use ${USE} \
                , use_index +1 --skip-visible

#!/bin/bash

workspace=${1:-$($(dirname "$0")/get_workspace_name.sh)}

case "$workspace" in
    dev | work)
        logo=
        ;;
    scratch | notes)
        logo=
        ;;
    web)
        logo=
        ;;
    corporate)
        extra=" web"
        logo=
        ;;
    chat | business)
        logo=
        ;;
    windows)
        logo=
        ;;
    vm)
        logo=
        ;;
    gaming)
        logo=
        ;;
    reference)
        logo=
        ;;
esac

printf "%%{F#3C7B8E}%s%s%%{T3}%s%%{T-}   %%{T-}%%{B-}%%{F-}\n" "$workspace" "$extra" "  $logo"

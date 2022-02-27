#!/bin/bash

workspace=${1:-$($(dirname "$0")/get_workspace_name.sh)}

case "$workspace" in
    dev | work)
        logo=
        ;;
    scratch)
        logo=
        ;;
    web)
        logo=
        ;;
    corporate)
        extra=" web"
        logo=
        ;;
    chat)
        logo=
        ;;
    windows)
        logo=
        ;;
    reference)
        logo=
        ;;
esac

printf "%%{F#3C7B8E}%s%s%%{T3}%s%%{T-}   %%{T-}%%{B-}%%{F-}\n" "$workspace" "$extra" "  $logo"

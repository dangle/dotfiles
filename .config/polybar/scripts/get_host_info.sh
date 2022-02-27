#!/bin/bash

case $($(dirname "$0")/get_workspace_name.sh) in
    windows)
        echo "melis%{F#999999}@%{F#59aa49}jubjub %{F#454545} |%{F#999}  %{T3}%{T-}"
        ;;
    *)
        echo "$(id -nu)%{F#999999}@%{F#59aa49}$(hostname) %{F#454545} |%{F#999}  %{T3}%{T-}"
        ;;
esac

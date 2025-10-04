#!/usr/bin/env bash

if [ -z ${1} ]; then
    display=$(niri msg outputs | grep 'Output.*\(.*\)' | awk -F '[()]' '{print $2 ; exit}')
    wallpaper=$(jq -r ".wallpaper.monitors[] | select(.name == \"${display}\").wallpaper" ~/.config/noctalia/settings.json)
else
    wallpaper="${1}"
fi

if [ ! -f "${wallpaper}" ]; then
    exit 1;
fi

colors=( $(matugen image "${wallpaper}" -t scheme-expressive --show-colors | grep "on_\(primary\|tertiary\)_container" | awk '{print $9}') )

if [ ${#colors[@]} -gt 1 ]; then
    primary=${colors[0]}
    tertiary=${colors[1]}

    cat <<EOF > ~/.config/niri/colors.kdl
layout {
    focus-ring {
        active-gradient from="${primary}" to="${tertiary}" angle=45 relative-to="workspace-view"
    }
}
EOF
else
    exit 1
fi

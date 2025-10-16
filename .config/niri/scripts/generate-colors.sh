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

declare -A colors="( $(matugen image "${wallpaper}" -t scheme-expressive --show-colors | grep "\W\(background\|on_background\|primary\|secondary\|tertiary\)\W" | awk '{ print "[\"" $2 "\"]=\"" $9 "\"" }') )"

if [ ${#colors[@]} -gt 1 ]; then
    background=${colors["background"]}
    foreground=${colors["on_background"]}
    primary=${colors["primary"]}
    secondary=${colors["secondary"]}
    tertiary=${colors["tertiary"]}

    cat <<EOF > ~/.config/niri/colors.kdl
layout {
    focus-ring {
        active-gradient from="${primary}99" to="${tertiary}99" angle=45 relative-to="workspace-view"
    }
}
EOF

    cat <<EOF > ~/.config/walker/themes/matugen/colors.css
@define-color window_bg_color ${background}DD;
@define-color accent_bg_color ${primary};
@define-color theme_fg_color ${foreground};
EOF

    jq ".accentColor = \"${primary}\"" ~/Documents/Notes/.obsidian/appearance.json| sponge ~/Documents/Notes/.obsidian/appearance.json
else
    exit 1
fi

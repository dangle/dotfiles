#!/bin/bash

SHUTDOWN=
REBOOT=
SLEEP=
HIBERNATE=
LOCK=
LOGOUT=

case "${@}" in
    ${SHUTDOWN})
        systemctl poweroff >/dev/null
        exit 0
        ;;
    ${REBOOT})
        systemctl reboot >/dev/null
        exit 0
        ;;
    ${SLEEP})
        systemctl suspend
        exit 0
        ;;
    ${HIBERNATE})
        systemctl hibernate
        exit 0
        ;;
    ${LOCK})
        gnome-screensaver-command -a >/dev/null
        exit 0
        ;;
    ${LOGOUT})
        herbstclient quit
        loginctl kill-session self && loginctl terminate-session self
        exit 0
        ;;
esac

echo ${SHUTDOWN}
echo ${REBOOT}
echo ${LOCK}
echo ${SLEEP}
echo ${HIBERNATE}
echo ${LOGOUT}

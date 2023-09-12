#!/bin/bash

SHUTDOWN=
REBOOT=
SLEEP=
HIBERNATE=
LOCK=
LOGOUT=

case "${@}" in
    ${SHUTDOWN})
        #ssh ecco sudo systemctl poweroff
        sudo systemctl poweroff >/dev/null
        exit 0
        ;;
    ${REBOOT})
        #@ssh ecco sudo systemctl reboot
        sudo systemctl poweroff >/dev/null
        exit 0
        ;;
    ${SLEEP})
        sudo systemctl hybrid-sleep
        exit 0
        ;;
    ${HIBERNATE})
        sudo systemctl hibernate
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
echo ${LOGOUT}

#!/usr/bin/env bash

UPPER_MONITOR=dev:/dev/i2c-3
LOWER_MONITOR=dev:/dev/i2c-4
RIGHT_MONITOR=dev:/dev/i2c-5

INPUT_REGISTER=0x60

HDMI1=0x11
HDMI2=0x12
DP=0x0F
USBC=0x1B

raw_lower_input=$(ddccontrol -r ${INPUT_REGISTER} ${LOWER_MONITOR} | awk -F '/' '/+/{ print $2 }')
lower_input=$((${raw_lower_input} - 0x0F00))

raw_upper_input=$(ddccontrol -r ${INPUT_REGISTER} ${UPPER_MONITOR} | awk -F '/' '/+/{ print $2 }')
upper_input=$((${raw_upper_input} - 0x1100))

if (( ${lower_input} == ${HDMI1} && ${upper_input} == ${HDMI1} )); then
    ddccontrol -r ${INPUT_REGISTER} -w ${DP} ${LOWER_MONITOR}
    ddccontrol -r ${INPUT_REGISTER} -w ${DP} ${UPPER_MONITOR}
elif (( ${upper_input} == ${DP} && ${lower_input} == ${DP} )); then
    ddccontrol -r ${INPUT_REGISTER} -w ${HDMI1} ${LOWER_MONITOR}
    ddccontrol -r ${INPUT_REGISTER} -w ${HDMI1} ${UPPER_MONITOR}
fi

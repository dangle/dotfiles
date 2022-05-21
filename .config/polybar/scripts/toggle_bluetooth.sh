#!/bin/bash

if [[ $(pactl get-default-sink) != *QEMU* ]]
then
    pactl set-default-sink alsa_output.usb-QEMU_QEMU_USB_Audio_1-0000_00_02.1_00.0-2-00.analog-stereo
    bluetoothctl disconnect F8:4E:17:8D:1F:F9
else
    bluetoothctl power on
    bluetoothctl connect F8:4E:17:8D:1F:F9
    pactl set-default-sink bluez_sink.F8_4E_17_8D_1F_F9.a2dp_sink
fi

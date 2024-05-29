#!/bin/bash

case $1 in

    0)
	[[ -e /tmp/lightscontrol ]] && [[ "$(cat /tmp/lightscontrol)" == "0" ]] && exit 0
	brightnessctl --save --device='asus::kbd_backlight' set 0
	swaymsg "output * power off"
	echo "0" > /tmp/lightscontrol
	;;
    1)
	[[ -e /tmp/lightscontrol ]] && [[ "$(cat /tmp/lightscontrol)" == "1" ]] && exit 0
	brightnessctl --restore --device='asus::kbd_backlight'
	swaymsg "output * power on"
	echo "1" > /tmp/lightscontrol
	;;
    *)
	echo "Usage: $0 (0|1)"
	;;
esac


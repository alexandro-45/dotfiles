#!/bin/bash

is_locked() {
	pidof swaylock
}

if [[ "$#" -ne 2 ]]; then
	echo "you must provide action and bg"
	exit 1
fi

case $1 in

	m)
		is_locked
		if [[ "$?" -ne 0 ]]; then
			echo "manual: can lock"
			exec swaylock -f -i $2
		else
			echo "manual: already locked"
		fi
		;;
	a)
		is_locked
		if [[ "$?" -ne 0 ]]; then
			echo "auto: can lock"
			chayang && ~/.config/sway/lightscontrol.sh 0 && swaylock -f -i $2
		else
			echo "auto: already locked"
			# check if screen is on and off then
		fi
		;;
	*)
		echo "arg must be m or a"
		;;
esac

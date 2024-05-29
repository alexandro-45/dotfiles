#!/bin/bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

FIRST_WARNING_AT=15
SECOND_WARNING_AT=5

flag_first_warning=0
flag_second_warning=0

bat_level () {
    return $(cat /sys/class/power_supply/BAT0/capacity)
}

bat_level
last_percentage=$?

while true
do
	bat_level
	battery_level=$?
	if [[ $battery_level -lt $last_percentage ]] ; then
		last_percentage=$battery_level
		#notify-send "Battery level: ${battery_level}" --expire-time 2000
		if [[ $battery_level -le $FIRST_WARNING_AT ]] ; then
			if [[ $flag_first_warning -eq 0 ]] ; then
				flag_first_warning=1
				notify-send "Battery is low!" "Battery level is ${battery_level}%"
			fi
		else
			flag_first_warning=0
		fi
		if [[ $battery_level -le $SECOND_WARNING_AT ]] ; then
			if [[ $flag_second_warning -eq 0 ]] ; then
				flag_second_warning=1
				notify-send "Battery is very low!" "Battery level is ${battery_level}%"
				sleep 2
				systemctl hibernate
			fi
		else
			flag_second_warning=0
		fi
	elif [[ $battery_level -gt $last_percentage ]] ; then
		last_percentage=$battery_level
		if [[ $battery_level -gt $FIRST_WARNING_AT ]] ; then
			flag_first_warning=0
		fi
		if [[ $battery_level -gt $SECOND_WARNING_AT ]] ; then
			flag_second_warning=0
		fi
	fi
	sleep 6
done


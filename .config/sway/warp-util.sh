#!/bin/bash

# Usage: warp_util.sh (on|off)

action=$1

if [[ $action == "switch" ]]; then
    result="$(curl https://www.cloudflare.com/cdn-cgi/trace/)"
    if [[ $result == *"warp=on"* ]]; then
	action="off"
    elif [[ $result == *"warp=off"* ]]; then
	action="on"
    else
	notify-send -t 1500 "VPN util" "Can't get status."
	exit 1
    fi
fi

systemctl --no-pager status warp-svc.service
if [[ "$?" != "0" ]]; then
    if [[ "$action" == "off" ]];then
        notify-send -t 1500 "VPN disconnected"
	exit 0
    fi
    foot -T "You should start warp-svc.service" sh -c "echo 'You should start warp-svc.service'; sudo systemctl start warp-svc.service"
    sleep 6
    
    systemctl --no-pager status warp-svc.service
    if [[ "$?" != "0" ]]; then
	notify-send -t 1000 "VPN util" "warp-svc still not running"
        exit 1
    fi
fi



case $action in
    on)
        result="$(warp-cli connect)"
	if [[ $result == "Success" ]]; then
            notify-send -t 1500 "VPN connected"
	else
	    notify-send -t 2000 "VPN util" "WARP returned: $result"
	fi
	;;
    off)
	result="$(warp-cli disconnect)"
	if [[ $result == "Success" ]]; then
	    notify-send -t 1500 "VPN disconnected"
	else
	    notify-send -t 2000 "VPN util" "WARP returned: $result"
	fi
	;;
    *)
	echo "Usage: warp_util.sh (on|off)"
	;;
esac


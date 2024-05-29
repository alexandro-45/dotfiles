#!/bin/bash

action=$1
saveto=$2

echo "action: $action"
echo "saveto: $saveto"

case $action in

	screen)
		echo "screen"
		case $saveto in

			file)
				echo "file"
				grim ~/Pictures/screen-"$(date +%s)".png
				;;

			buffer)
				grim - | wl-copy
				echo "buffer"
				;;
			*)
				echo "Invalid saveto. It should be file or buffer."
				;;

		esac
		;;
	
	area)
		echo "area"
		case $saveto in

			file)
				grim -g "$(slurp)" ~/Pictures/screen-"$(date +%s)".png
				;;

			buffer)
				grim -g "$(slurp)" - | wl-copy
				echo "buffer"
				;;

			*)
				echo "Invalid saveto. It should be file or buffer."
				;;

		esac
		;;
	
	window)
		echo "window"
		case $saveto in

			file)
				echo "file"
				grim -g "$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.visible and .pid) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | sed 's/\"//' | slurp)" ~/Pictures/screen-"$(date +%s)".png
				;;

			buffer)
				echo "buffer"
				grim -g "$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.visible and .pid) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | sed 's/\"//' | slurp)" - | wl-copy
				;;

			*)
				echo "Invalid saveto. It should be file or buffer."
				;;

		esac
		;;
	
	*)
		echo "Invalid action. It should be one of: screen, area, window."
		;;
esac

#!/bin/bash

case $1 in
up) pamixer --allow-boost -i 5 ;;
down) pamixer --allow-boost -d 5 ;;
mute) pamixer -t ;;
esac

vol="$(pamixer --get-volume)"

if [[ $(pamixer --get-mute) == true ]]; then
	icon="🔇"
else
	if [[ "$vol" -gt "70" ]]; then
		icon="🔊"
	elif [[ "$vol" -gt "30" ]]; then
		icon="🔉"
	else
		icon="🔈"
	fi
fi

notify-send -t 1000 -r 6 -h int:value:"$vol" "$icon"
pkill -RTMIN+6 dwmblocks

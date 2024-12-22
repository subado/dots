#!/usr/bin/env sh

step='5'
sink=$(pactl get-default-sink)
is_muted=$(pactl get-sink-mute "$sink")
vol=$(pactl get-sink-volume "$sink" | awk '{print $5}')
vol="${vol%?}"
up="pactl set-sink-volume $sink +$step%";
down="pactl set-sink-volume $sink -$step%";
mute="pactl set-sink-mute $sink toggle"

case $1 in
up) vol="$(($vol+$step))"; eval "$up" & ;;
down) vol="$(($vol-$step))"; eval "$down" & ;;
mute) eval "$mute" & ;;
esac

if  { [ "$is_muted" = "Mute: yes" ] && [ "$1" != "mute" ]; } ||
	  { [ "$is_muted" = "Mute: no" ] && [ "$1" = "mute" ] ;}; then
	icon="🔇"
else
	if [ "$vol" -gt 70 ]; then
		icon="🔊"
	elif [ "$vol" -gt 30 ]; then
		icon="🔉"
	else
		icon="🔈"
	fi
fi

vol="$((vol>0 ? vol : 0))"


notify-send -t 1000 -r 6 "$icon $vol%"
# pkill -RTMIN+6 dwmblocks

#!/bin/bash

case $BUTTON in
	1) pamixer -t
esac

if [[ $(pamixer --get-mute) == true ]]; then
	echo "🔇"
	exit
fi

vol="$(pamixer --get-volume)"

if [[ "$vol" -gt "70" ]]; then
	icon="🔊"
elif [[ "$vol" -gt "30" ]]; then
	icon="🔉"
else
	icon="🔈"
fi

echo "$icon$vol%"

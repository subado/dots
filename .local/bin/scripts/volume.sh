#!/usr/bin/env sh

mixer=$VOLUME_MIXER
case $mixer in
pamixer)
	down="$mixer --allow-boost -d "
	up="$mixer --allow-boost -i "
	;;
pulsemixer)
	down="$mixer --change-volume -"
	up="$mixer --change-volume +"
	;;
*)
	notify-send -t 1000 -r 6 '$VOLUME_MIXER is not set!'
	exit 1
	;;
esac

step='5'
is_muted=$("$mixer" --get-mute)
vol=$("$mixer" --get-volume | awk '{print $1}')

case $1 in
up) eval "$up$step" & ;;
down) eval "$down$step" & ;;
mute) "$mixer" --toggle-mute & ;;
esac

if [ "$is_muted" = 'true' ] || [ "$is_muted" = '1' ]; then
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

notify-send -t 1000 -r 6 -h int:value:"$vol" "$icon"
pkill -RTMIN+6 dwmblocks

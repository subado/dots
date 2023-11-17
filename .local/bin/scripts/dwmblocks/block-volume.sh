#!/usr/bin/env sh

icon="🙊"

mixer=$VOLUME_MIXER
if [ "$mixer" ]; then
	is_muted=$("$mixer" --get-mute)
	vol=$("$mixer" --get-volume | awk '{print $1}')

	case $BUTTON in
	1) "$mixer" --toggle-mute ;;
	2) pavucontrol & ;;
	esac

	if [ "$is_muted" = 'true' ] || [ "$is_muted" = '1' ]; then
		echo "🔇"
		exit
	fi

	if [ "$vol" -gt 70 ]; then
		icon="🔊"
	elif [ "$vol" -gt 30 ]; then
		icon="🔉"
	else
		icon="🔈"
	fi
	vol="$vol%"
fi

echo "$icon$vol"

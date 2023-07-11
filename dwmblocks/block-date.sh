#!/usr/bin/env sh

case $BUTTON in
1) notify-send "$(cal)" ;;
esac

now="$(date '+%b %d (%a) %R')"
icon_calendar="📅"
icon_clock="🕓"

echo "$icon_calendar$now$icon_clock"

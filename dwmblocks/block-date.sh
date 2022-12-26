#!/bin/bash

case $BUTTON in
esac

now="$(date '+%b %d (%a) %R')"
icon_calendar="📅"
icon_clock="🕓"

echo "$icon_calendar$now$icon_clock"

#!/usr/bin/env bash

case $BUTTON in
esac

weather=$(curl --max-time 60 -s wttr.in/Izhevsk?format=%c%t+%m)

echo "$weather"

#!/bin/bash

case $BUTTON in
esac

weather=$(curl --max-time 60 -s wttr.in/Sarapul?format=%c%t+%m)

echo "$weather"

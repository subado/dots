#!/bin/bash

case $BUTTON in
esac

weather=$(curl -s wttr.in/Sarapul?format=%c%t+%m)

echo "$weather"

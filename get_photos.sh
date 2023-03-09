#!/usr/bin/env bash

if [[ $# -eq 2 ]]; then
	cd $1
	echo "Copy files $2 to $1"
	sudo gphoto2 --get-file $2
fi

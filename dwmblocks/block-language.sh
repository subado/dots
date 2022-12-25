#!/bin/bash

case $BUTTON in
	1) xkblayout-state set +1 ;;
esac

icon="🌐"
lang="$(xkblayout-state print %n | cut -c 1-3)"

echo "$icon$lang"

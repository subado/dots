#!/bin/bash

case $BUTTON in
	1) xkblayout-state set +1 ;;
esac

lang="$(xkblayout-state print %n | cut -c -3 | awk '{print toupper($0)}')"

echo "$lang"

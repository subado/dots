#!/usr/bin/env sh

eval sudo wg-quick "$@"
pkill -RTMIN+7 dwmblocks

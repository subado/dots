#!/usr/bin/env bash

xkbcomp $HOME/.config/xkb/my $DISPLAY >/dev/null 2>&1
xcape -t 500 -e "ISO_Level3_Shift=Escape"

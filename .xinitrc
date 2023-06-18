#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

eval xkeyboard-setup.sh
feh --bg-fill "$HOME"/pictures/wallpapers/coder-room.jpg >/dev/null 2>&1
picom -b >/dev/null 2>&1

# merge in defaults and keymaps
if [ -f "$sysresources" ]; then
	xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
	xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

if [ "$(command -v dwm)" ] >/dev/null 2>&1; then
	dwmblocks &
	exec dwm
fi

if [ "$(command -v i3)" ] >/dev/null 2>&1; then
	exec i3
elif [ "$(command -v bspwm)" ] >/dev/null 2>&1; then
	sxhkd &
	exec bspwm
else
	printf "Install a DE/WM\n"
fi

if [ "$(command -v xset)" ] >/dev/null 2>&1; then
	#xset s off 	#Disable screen saver blanking
	#xset s 3600 3600 	#Change blank time to 1 hour
	#xset -dpms 	#Turn off DPMS
	xset s off -dpms #Disable DPMS and prevent screen from blanking
	#xset dpms force off 	#Turn off screen immediately
	#xset dpms force standby 	#Standby screen
	#xset dpms force suspend 	#Suspend screen
fi

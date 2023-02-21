#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


# picom >/dev/null 2>&1
xkbcomp $HOME/.config/xkb/my $DISPLAY >/dev/null 2>&1
xcape -t 500 -e "ISO_Level3_Shift=Escape"
nitrogen --set-scaled $HOME/pictures/wallpapers/coder-room.jpg >/dev/null 2>&1
picom -b >/dev/null 2>&1
#wal -i ~/pictures/wallpapers/breakfast.jpg >/dev/null 2>&1
#python3 ~/scripts/wal2xrdb.py & >/dev/null 2>&1
#python3 ~/scripts/wal2dunstrc.py & >/dev/null 2>&1
#pywalfox update & >/dev/null 2>&1

# feh --bg-scale /$HOME/Pictures/nord.png >/dev/null 2>&1

# rootSize=$(df -h / | awk 'END {print $2}')
# homeSize=$(df -h /home | awk 'END {print $2}')

# Statusbar loop
# while true; do

# 	# xsetroot -name "[ $(df -h / | awk 'END {print $3}')/${rootSize} ][ $(df -h /home | awk 'END {print $3}')/${homeSize} ][ $(cat $HOME/Programs/dwmbar/usedRAM.txt)/${ramSize} ][ enp3s0:$(ifconfig | awk '/addr:19/ {print $2}' | sed 's/addr://g') $(cat /sys/class/net/enp3s0/operstate) ][ $(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p') ][$(date +" %e.%m ][ %T " )]"
# #  enp3s0:$(ifconfig | awk '/addr:19/ {print $2}' | sed 's/addr://g') $(cat /sys/class/net/enp3s0/operstate) |  $(free -h | awk  '/Mem/ {print $3}')/${ramSize} |
# xsetroot -name " $(xbps-query -l | wc -l)    $(xbps-install -un | awk '{print $2}' | wc -l)    $(xkblayout-state print "%n" | cut -c 1-3)   $(date +" %a, %e %B   󱑎 󰥔 %T " )"

#    sleep 1s	# Update time every minute
# done &

# merge in defaults and keymaps

if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ "$(command -v dwm)" >/dev/null 2>&1 ];
then
	# With this line, color emojis are not printed properly.
	# Some of emojis are monocrhome
	dwmblocks & 
	exec dwm
fi

if [ "$(command -v i3)" >/dev/null 2>&1 ];
then
	exec i3;
elif [ "$(command -v bspwm)" >/dev/null 2>&1 ];
then
   sxhkd & exec bspwm
else
	printf "Install a DE/WM\n"
fi

if [ "$(command -v xset)" >/dev/null 2>&1 ];
then
	#xset s off 	#Disable screen saver blanking
	#xset s 3600 3600 	#Change blank time to 1 hour
	#xset -dpms 	#Turn off DPMS
	#xset s off -dpms 	#Disable DPMS and prevent screen from blanking
	#xset dpms force off 	#Turn off screen immediately
	#xset dpms force standby 	#Standby screen
	#xset dpms force suspend 	#Suspend screen
fi

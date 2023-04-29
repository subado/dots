# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Useful commands
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias ll='ls -lah'

# For use feh like image viewer
alias feh='feh --scale-down'

# xbps
alias xu='sudo xbps-install xbps && sudo xbps-install -Suv'
alias xin='sudo xbps-install -S'
alias xr='sudo xbps-remove -Rcon'
alias xl='xbps-query -l'
alias xf='xl | grep'
alias xs='xbps-query -Rs'
alias xd='xbps-query -x'
alias clrk='sudo vkpurge rm all && sudo rm -rf /var/cache/xbps/*'

# Add sudo to commands
alias halt='sudo halt'
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown'
alias config='/usr/bin/git --git-dir=/home/subado/.cfg/.git/ --work-tree=/home/subado'

PS1='[\u@\h \W]\$ '

# neovim for man pages
export EDITOR="nvim"
export VISUAL="$EDITOR"
export MANPAGER='nvim +Man!'

# Set used terminal
export TERMINAL="st"

# Set the root dir for android sdk
export "ANDROID_SDK_ROOT"="$HOME/android-sdk"

# Add local scripts and programs to PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/scripts/dwmblocks"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin"

# Set dirs for my diary and planner shells
export DIARY_DIR="$HOME/notes/diary"
export PLANNER_DIR="$HOME/notes/planner"

# Google test framework output colorful
export GTEST_COLOR=1

# Enable starship
eval "$(starship init bash)"

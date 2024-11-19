#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

# Start basic X services
xsetroot -cursor_name left_ptr &  # Set default cursor
setxkbmap -layout us &            # Set keyboard layout
xset r rate 300 50 &             # Set keyboard repeat rate
xset s off -dpms &               # Disable screen saver

# Load profile
[ -f ~/.profile ] && . ~/.profile

# Start background services
xcompmgr &                      # Simple compositor for transparency
sh ~/.fehbg &                   # Set wallpaper

# Start status bar
slstatus &

# Start window manager
exec dwm

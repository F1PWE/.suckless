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

# Start audio
pulseaudio --start &

# Start background services
xcompmgr &                      # Simple compositor for transparency

# Start status bar
slstatus &

# Set wallpaper after compositor
sh ~/.fehbg &                   # Set wallpaper

# Start window manager with restart loop
while true; do
    dwm >/dev/null 2>&1
done

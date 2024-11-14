#!/usr/bin/zsh

echo "0"
xcompmgr -c &  # Run xcompmgr in the background
echo "1"
slstatus &
echo "2"
sh ~/.fehbg & 
echo "3"
xrandr -s 1920x1080 &

#sh ~/.fehbg &
echo "3"

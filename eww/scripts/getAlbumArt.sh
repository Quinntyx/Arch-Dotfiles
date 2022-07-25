#!/bin/bash
playerctl metadata mpris:artUrl |
   awk '{split($0,a,"//"); print a[2]}' |
   xargs wget -O /tmp/albumart $() &> /dev/null

echo /tmp/albumart


#!/bin/bash
echo "scale=5; $(playerctl position) / $(echo $(playerctl metadata | grep mpris:length | awk '{split($0, a, " "); print a[3]}') / 1000000 | bc)" | bc

#!/bin/bash

bspc subscribe node_state | while read -r _ _ _ node state status; do
   if [[ "$state" == "floating" ]]; then
      case "$status" in
         off) xprop -id "$node" -remove _BSPWM_FLOATING;;
         on) xprop -id "$node" -f _BSPWM_FLOATING 32c -set _BSPWM_FLOATING 1;;
      esac
   fi
done


import pyacman as p 


p.pprint("You will need sxhkd for this. If you didn't get it, rerun install.sh.")

p.pprint("Installing bspwm")
p.install('bspwm')

p.pprint("Installing amixer")
p.install('amixer')

if p.yesno("Install PavuControl (GUI Audio Mixer)? (recommended)"):
    p.install('pavucontrol')


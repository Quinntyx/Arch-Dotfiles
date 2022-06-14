import pyacman as p 
import os


p.pprint("You will need sxhkd for this. If you didn't get it, rerun install.sh.")

p.pprint("Installing bspwm")
p.install('bspwm')

p.pprint("Installing PipeWire")
os.system("pipewire-install.sh")

if p.yesno("Install PavuControl (GUI Audio Mixer)? (recommended)"):
    p.pprint("Installing PavuControl")
    p.install('pavucontrol')

if p.yesno("Install arandr (GUI Monitor Configuration)? (recommended)"):
    p.pprint("Installing arandr")
    p.install('arandr')
    p.eprint("WARNING: You will need to reapply arandr at each restart. It is recommended to Save As from arandr, and reload the config with a command inside of your bspwmrc file.")

p.pprint("Cloning BSPWM configs")
os.system('mkdir ~/.config/bspwm; cp bspwm/bspwmrc ~/.config/bspwm')


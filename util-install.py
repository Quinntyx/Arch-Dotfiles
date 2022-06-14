import pyacman
import termcolor as tc 
import os


def qinst(msg, *pkg):
    if pyacman.yesno(msg):
        pyacman.install(*pkg)
        return True
    return False


qinst('GUI Printer Management?', 'system-config-printer'):
qinst('NVIDIA Proprietary Drivers?', 'nvidia')
qinst('Notification System? (some DEs (Plasma, Gnome) package this)', 'dunst')
if qinst('Optimus Manager?', 'optimus-manager-git'):
    qinst('Optimus Manager Qt Client?', 'optimus-manager-qt-git')

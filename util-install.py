import pyacman
import termcolor as tc 


def qinst(msg, *pkg):
    if pyacman.yesno(msg):
        pyacman.install(*pkg)
        return True
    return False


qinst('GUI Printer Management?', 'print-manager')
qinst('NVIDIA Proprietary Drivers?', 'nvidia')
qinst('Notification System? (some DEs (Plasma, Gnome) package this)', 'dunst')
if qinst('Optimus Manager?', 'optimus-manager-git'):
    qinst('Optimus Manager Qt Client?', 'optimus-manager-qt-git')


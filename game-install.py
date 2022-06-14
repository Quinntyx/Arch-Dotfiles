import termcolor as tc
import os

os.system('sudo echo')

def pprint(value):
    print('   ', tc.colored(value, 'cyan', attrs=['bold']))

def eprint(value):
    print('   ', tc.colored(value, 'red', attrs=['bold']))

def install(*targets):
    os.system(f"yay -S --noconfirm {' '.join(targets)}")
    print()

def yesno(message, default=True, waitfor=True):
    if default:
        end = tc.colored('[Y/n]', 'green')
    else:
        end = tc.colored('[y/N]', 'red')

    print(message, end=' ')
    print(end, end=': ')
    val = input()
    if not val: return default
    if val.lower() in ['y', 'yes']:
        return True
    elif val.lower() in ['n', 'no']:
        return False
    else:
        if waitfor:
            eprint("Invalid, please try again. ")
            return yesno(message, default, waitfor)
    return False


if yesno("Install Steam?"):
    pprint("Installing Steam")
    install('steam')

if yesno("Install Heroic Games Launcher?"):
    pprint("Installing Heroic Games Launcher")
    install('heroic-games-launcher-bin')

if yesno("Install Lutris?"):
    pprint("Installing Lutris")
    install('lutris')
    pprint("Installing gnutls")
    install('gnutls', 'lib32-gnutls')

if yesno("Install An Anime Game?"):
    pprint("Installing An Anime Game!")
    install("an-anime-game-launcher-bin")

if yesno("install DXVK?") :
    pprint("Launching DXVK Install Wizard.")
    os.system("installers/dxvk.sh")

pprint("You have reached the end of the games installer. ")


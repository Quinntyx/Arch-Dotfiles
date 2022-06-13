import termcolor as tc
import os

def pprint(value):
    print('   ', tc.colored(value, 'cyan', attrs=['bold']))

def eprint(value):
    print('   ', tc.colored(value, 'red', attrs=['bold']))

def install(*targets):
    os.system(f"yay -S --noconfirm {' '.join(targets)}")
    print()

def yesno(message, default=True):
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

if yesno("Install An Anime Game?"):
    pprint("Installing An Anime Game!")
    install("an-anime-game-launcher-bin")

pprint("You have reached the end of the games installer. ")


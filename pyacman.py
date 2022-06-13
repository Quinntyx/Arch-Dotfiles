import termcolor as tc
import os


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


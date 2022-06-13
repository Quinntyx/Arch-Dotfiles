alias pinst='sudo pacman -S --noconfirm'
B='\033[1;34m'
alias echo='f() { echo; echo -e "    ${B}$@"; unset -f f; }; f'
echo 'Updating mirrors...'
sudo pacman -Sy

echo 'Installing widely-used packages (mlocate, wget, etc.)'
pinst mlocate wget git base base-devel python3 zsh

echo 'Installing messaging clients'
pinst discord-canary

echo 'Installing Kitty (terminal emulator)'
pinst kitty

echo 'Installing theming apps (skip if you have a DE that packages these, like Plasma, LXQt, XFCE, etc.)'
read -p 'Install? [Y/n] ' response

case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Okay, installing theming'
  pinst lxappearance qt5ct-kde
  ;;
?) echo 'Skipping...';;
esac

  
echo 'Installing polybar'
pinst polybar

echo 'Installing yay (AUR helper)'
pinst yay

echo 'Installing Neovim'
pinst Neovim

echo
echo ' User Apps'
echo '<--------->'

read -p 'Install graphics software? (GIMP, Inkscape) [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst gimp inkscape
  ;;
?) echo 'Skipping...';;
esac

read -p 'Install LibreOffice Suite? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst libreoffice-fresh
  ;;
?) echo 'Skipping...';;
esac

read -p 'Install flameshot? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst flameshot
  ;;
?) echo 'Skipping...';;
esac

read -p 'Install sxhkd (Simple X HotKey Daemon)? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst sxhkd
  echo 'sxhkd installed, to get it to start on system please put it in the .rc file of your choice. '
  read -p 'Start sxhkd? [Y/n] ' response2
  case $response2 in [yY][eE][sS]|[yY]|[jJ]|'')
    sxhkd &> /dev/null & disown
    ;;
  ?) echo 'Not starting sxhkd. To start manually, run `sxhkd &`';;
  esac
  ;;
?) echo 'Skipping...';;
esac

read -p 'Install powerlevel10k? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  yay -S --noconfirm zsh-theme-powerlevel10k-git
  echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
  ;;
?) echo 'Skipping...';;
esac

read -p 'Install NvChad? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing ripgrep (Required for Telescope Searching)'
  pacman -S ripgrep
  echo 'Installing NvChad...'
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  ;;
?) echo 'Skipping...';;
esac

echo You have reached the end of the app install wizard. 
read -p 'Switch to Kitty? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Switching!'
  kitty & disown
  kill -9 $PPID
  ;;
?) ;;
esac






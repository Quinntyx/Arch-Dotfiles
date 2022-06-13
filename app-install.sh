alias pinst='sudo pacman -S --noconfirm'
B='\033[1;34m'
NOCOLOR='\033[0m'
alias fecho='f() { echo -e "    ${B}$@${NOCOLOR}"; unset -f f; }; f'
alias techo='f() { echo; echo -e "    ${B}$@${NOCOLOR}"; unset -f f; }; f'
echo 'Updating mirrors...'
sudo pacman -Sy

techo 'Creating src folder'
cd ~
mkdir src
cd src

techo 'Installing widely-used packages (mlocate, wget, etc.)'
pinst mlocate wget git base base-devel python3 zsh

techo 'Installing Discord Canary'
pinst discord-canary

techo 'Installing Kitty (terminal emulator)'
pinst kitty

techo 'Installing Fira Code'
pinst ttf-fira-code

techo 'Installing MesloLGS NF'
cd /usr/share/fonts 
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf 
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf 
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf 
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf 
cd ~/src
fc-cache -f -v

techo 'Installing theming apps (skip if you have a DE that packages these, like Plasma, LXQt, XFCE, etc.)'
read -p 'Install? [Y/n] ' response

case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Okay, installing theming'
  pinst lxappearance qt5ct-kde
  ;;
?) fecho 'Skipping...';;
esac

  
techo 'Installing polybar'
pinst polybar

techo 'Installing yay (AUR helper)'
pinst yay

techo 'Installing picom'
fecho '1: picom-ibhagwan-git (rounded corners, dual_kawase_blur) [recommended]'
fecho '2: picom-jonaburg-git (ibhagwan + animations)'
fecho '3: picom (main)'
fecho '4: I have a compositor already. (skip)'
read -p 'What version of picom do you want? [1-4] ' response
case $response in 
  1)
    fecho Installing picom-ibhagwan-git
    yay -S --noconfirm picom-ibhagwan-git
    ;;
  2) 
    fecho Installing picom-jonaburg-git
    yay -S --noconfirm picom-jonaburg-git
    ;;
  3)
    fecho Installing picom
    pinst picom
    ;;
  4)
    fecho Skipping...
    ;;
  ?) 
    fecho ERROR: Unrecognized Input
    ;;
esac            

techo 'Installing Neovim'
pinst neovim

echo
techo ' User Apps'
fecho '<--------->'

read -p 'Install graphics software? (GIMP, Inkscape) [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing'
  pinst gimp inkscape
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install LibreOffice Suite? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing'
  pinst libreoffice-fresh
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install flameshot? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing'
  pinst flameshot
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install rofi? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing'
  pinst rofi
  fecho 'rofi installed, to run it do rofi -modes "drun" -show drun or rofi -show run for drun and run, respectively. '
  fecho 'Installing extra rofi themes'
  fecho 'Making ~/.local/share/rofi/themes'
  mkdir ~/.local/share/rofi
  mkdir ~/.local/share/rofi/themes
  fecho '    Archived rofi-themes repo:'
  mkdir rofi-themes
  cd rofi-themes
  git clone https://github.com/davatorium/rofi-themes.git
  cd rofi-themes
  cd User\ Themes 
  sudo cp -r * ~/.local/share/rofi/themes
  cd ~/src/rofi-themes
  fecho "    Murzchnvok's rofi-collection repo:"
  git clone https://github.com/Murzchnvok/rofi-collection
  cd rofi-collection
  cd dracula
  sudo cp dracula.rasi ~/.local/share/rofi/themes
  cd ../gruvbox
  sudo cp gruvbox.rasi ~/.local/share/rofi/themes
  cd ../material
  sudo cp material.rasi ~/.local/share/rofi/themes
  cd ../minimal
  sudo cp minimal.rasi ~/.local/share/rofi/themes
  cd ../murz 
  sudo cp murz.rasi ~/.local/share/rofi/themes
  cd ../nord
  sudo cp nord.rasi ~/.local/share/rofi/themes
  cd ../onedark
  sudo cp onedark.rasi ~/.local/share/rofi/themes
  cd ~/src
  fecho "Launching rofi theme selection wizard. "
  rofi-theme-selector
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install sxhkd (Simple X HotKey Daemon)? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing'
  pinst sxhkd
  fecho 'sxhkd installed, to get it to start on system please put it in the .rc file of your choice. '

  mkdir ~/.config/sxhkd
  sudo cp sxhkd/sxhkdrc ~/.config/sxhkd/

  read -p 'Start sxhkd? [Y/n] ' response2
  case $response2 in [yY][eE][sS]|[yY]|[jJ]|'')
    sxhkd &> /dev/null & disown
    ;;
  ?) fecho 'Not starting sxhkd. To start manually, run `sxhkd &`';;
  esac
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install powerlevel10k? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing'
  yay -S --noconfirm zsh-theme-powerlevel10k-git
  echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install NvChad? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing ripgrep (Required for Telescope Searching)'
  pinst ripgrep
  techo 'Installing NvChad...'
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  ;;
?) fecho 'Skipping...';;
esac

read -p 'Install Powercord? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Installing nodejs, npm'
  pinst nodejs-lts-gallium npm
  techo 'Installing Powercord...'
  git clone https://github.com/powercord-org/powercord 
  cd powercord
  npm i
  sudo npm run plug
  cd ..
  techo 'Restarting Discord Canary'
  killall DiscordCanary 
  discord-canary &> /dev/null & disown
  ;;
?) echo 'Skipping...';;
esac

techo You have reached the end of the app install wizard. 
read -p 'Launch Kitty? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  fecho 'Launching!'
  kitty & disown
  sleep 3;
  # kill -9 $PPID
  ;;
?) ;;
esac






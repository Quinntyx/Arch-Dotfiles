alias pinst='sudo pacman -S --noconfirm'

echo 'Installing widely-used packages (mlocate, wget, etc.)'
pinst mlocate wget git base base-devel python3

echo 'Installing messaging clients'
pinst discord-canary

echo 'Installing Kitty (terminal emulator)'
pinst kitty

echo 'Installing theming apps (skip if you have a DE that packages these, like Plasma, LXQt, XFCE, etc.)'
read -p 'Install? [Y/n] ' response

case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Okay, installing theming'
  pinst lxappearance qt5ct-kde

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

read -p 'Install LibreOffice Suite? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst libreoffice-fresh

read -p 'Install flameshot? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst flameshot

read -p 'Install sxhkd (Simple X HotKey Daemon)? [Y/n] ' response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo 'Installing'
  pinst sxhkd
  read -p 'Start sxhkd? [Y/n] ' response
  case $response in [yY][eE][sS]|[yY]|[jJ]|'')
    sxhkd &> /dev/null & disown




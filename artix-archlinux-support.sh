echo Installing artix-archlinux-support.

sudo pacman -S artix-archlinux-support

echo Updating pacman.conf. 

curl -OL https://github.com/FlareStormGaming/Arch-Dotfiles/pacman/pacman.conf
sudo mv pacman.conf /etc/pacman.conf

sudo pacman -Syu

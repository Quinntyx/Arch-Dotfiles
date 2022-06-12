echo Installing artix-archlinux-support

sudo pacman -S artix-archlinux-support

echo Updating pacman.conf 

sudo mv pacman/pacman.conf /etc/pacman.conf

echo Updating repositories
sudo pacman -Syu

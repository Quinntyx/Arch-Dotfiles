echo Installing artix-archlinux-support

sudo pacman -S --noconfirm artix-archlinux-support

echo Updating pacman.conf 

sudo cp pacman/pacman.conf /etc/pacman.conf

echo Updating repositories
sudo pacman-key --populate archlinux
sudo pacman -Syu

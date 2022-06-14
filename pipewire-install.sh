sudo echo
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
sudo mkdir /etc/pipewire 
sudo cp /usr/share/pipewire/pipewire* /etc/pipewire 
sudo cp conf/pipewire.conf /etc/pipewire/pipewire.conf

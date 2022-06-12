echo 'Installing widely-used packages (mlocate, wget, etc.)'
sudo pacman -S --noconfirm mlocate wget git base base-devel

echo 'Installing messaging clients'
sudo pacman -S --noconfirm discord-canary


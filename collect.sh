echo "Collecting dotfiles from system..."
echo "SXHKD: "
cp -r ~/.config/sxhkd/* sxhkd
echo "    Done. "

echo "Pacman: "
mkdir pacman &> /dev/null
cp /etc/pacman.conf pacman/pacman.conf
echo "    Done. "

echo "Picom: "
mkdir picom &> /dev/null
cp -r ~/.config/picom/* picom
echo "    Done. "

echo "Kitty: "
mkdir kitty &> /dev/null
cp -r ~/.config/kitty/* kitty
echo "    Done. "

echo "BSPWM: "
mkdir bspwm &> /dev/null
cp -r ~/.config/bspwm/* bspwm
echo "    Done. "

echo "Pipewire: "
mkdir pipewire &> /dev/null
cp -r /etc/pipewire/* pipewire
echo "    Done. "

echo "Dunst: "
mkdir dunst &> /dev/null
cp -r ~/.config/dunst/* dunst
echo "    Done. "

echo "Wallpaper: "
mkdir wall &> /dev/null
cp ~/Pictures/TokyoNightWall.png wall
echo "    Done. "

echo "Neovim: "
mkdir nvim &> /dev/null
cp -r ~/.config/nvim/lua/custom/* nvim
echo "    Done. "

echo "EWW: "
mkdir eww &> /dev/null
cp -r ~/.config/eww/* eww
echo "    Done. "

echo "userChrome.css: "
mkdir ffox &> /dev/null
cp ~/.config/mozilla/chrome/userChrome.css ffox
echo "    Done. "

echo "zshrc: "
mkdir zshrc &> /dev/null
cp -r ~/.zshrc ~/.lib zshrc
echo "    Done. "


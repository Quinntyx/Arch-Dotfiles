echo "Collecting dotfiles from system..."
echo "SXHKD: "
cp ~/.config/sxhkd/sxhkdrc sxhkd/sxhkdrc
echo "    Done. "

echo "Pacman: "
cp /etc/pacman.conf pacman/pacman.conf
echo "    Done. "

echo "Picom: "
cp ~/.config/picom/picom.conf picom/picom.conf
echo "    Done. "

echo "Kitty: "
cp ~/.config/kitty/kitty.conf kitty/kitty.conf
echo "    Done. "

echo "BSPWM: "
cp ~/.config/bspwm/bspwmrc bspwm/bspwmrc
echo "    Done. "

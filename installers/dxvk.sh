sudo echo
cd ~/src
rm -rf dxvk dxvk-master
git clone https://github.com/Joshua-Ashton/dxvk.git
cd dxvk
echo "Installing mingw cross-compiler, glslang, meson, and wine"
sudo pacman -S --noconfirm mingw-w64-gcc wine wine-mono winetricks glslang meson
read -p "DXVK Async? (Async will improve performance but can get you banned on multiplayer games, as it isn't as direct a translation and may be perceived as cheats) [Y/n] " response
case $response in [Yy][eE][Ss]|[yY]|[jJ]|'')
  echo "Switching to DXVK Async Branch"
  git checkout async 
  ASYNC=TRUE
  ;;
?) 
  echo "Using DXVK Origin Branch"
  ASYNC=FALSE
  ;;
esac

./package-release.sh master ~/src --no-package

read -p "Install DXVK for Lutris? (recommended) [Y/n] " response
case $response in [yY][eE][sS]|[yY]|[jJ]|'')
  echo "Installing DXVK for Lutris"
  if [[ $ASYNC = TRUE ]]; then
    echo "    Using Async Branch, installing to dxvk-async"
    cp -r ~/src/dxvk-master ~/.local/share/lutris/runtime/dxvk/dxvk-async
    cd ~/.local/share/lutris/runtime/dxvk/dxvk-async/dxvk-master
    cp -r x32 x64 ../ 
    cd ..
    rm -rf dxvk-master
    cd ~/src/dxvk
  else
    echo "    Using Master Branch, installing to dxvk-master"
    cp -r ~/src/dxvk-master ~/.local/share/lutris/runtime/dxvk 
    cd ~/.local/share/lutris/runtime/dxvk/dxvk-master
    rm setup_dxvk.sh
    cd ~/src/dxvk
  fi 
  ;;
?) 
  echo "Okay... To install DXVK for Lutris later, copy ~/src/dxvk-master to lutris's DXVK runtime folder: "
  echo "~/.local/share/lutris/runtime/dxvk/"
  ;;
esac
echo "You have reached the end of the DXVK installer. "


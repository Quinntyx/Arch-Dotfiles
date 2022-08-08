read -p "Are you running Artix (no Systemd)? [y/N]: " response


case $response in [yY][eE][sS]|[yY]|[jJ]|'')
   echo "Okay, installing artix-archlinux-support"
   ./artix-archlinux-support.sh
   ;;
?)
   echo "Skipping artix-archlinux-support"
   ;;
esac

./kitty.sh
./app-install.sh
./config.sh


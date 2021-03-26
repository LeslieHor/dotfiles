#!/usr/bin/env bash

# cd ~/Downloads
# scp -r leslie@octavius:~/projects/dotfiles ./
# cd dotfiles
# ./vm-setup.sh

# To cache sudo password
sudo echo

# Make all required directories
mkdir -p \
      ~/.config \
      ~/bin \
      ~/projects \
      ~/.emacs.d

# Install programs
sudo apt update
sudo apt install -y i3 dzen2 python dunst xterm emacs dunst xfonts-terminus xkbset git stow vim lm-sensors
sudo apt upgrade -y

# Get emacs configuration
git clone https://github.com/LeslieHor/emacs.d.git ~/projects/
ln -s ~/projects/emacs.d/configuration.org ~/.emacs.d/
ln -s ~/projects/emacs.d/settings.org ~/.emacs.d/
ln -s ~/projects/emacs.d/init.el ~/.emacs.d/
ln -s ~/projects/emacs.d/packages/ ~/.emacs.d/
touch ~/projects/.emacs.d/personalsettings.org

# Install dotfiles
mv ~/.bashrc ~/.bashrc.default
stow -Sv vm -t ~

# Disable Gnome Display manager
sudo systemctl disable gdm

# Install virtual box guest utils
sudo apt install -y virtualbox-guest-dkms

echo
echo
echo "+------------------------------------------+"
echo "| Insert Guest Additions CD Image and run. |"
echo "| Once installed. Reboot the machine.      |"
echo "+------------------------------------------+"

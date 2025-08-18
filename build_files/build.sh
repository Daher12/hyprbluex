#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 install -y blueman nautilus xdg-user-dirs-gtk xdg-user-dirs file-roller kitty gnome-text-editor blueman-nautilus tlp zsh zsh-syntax-highlighting brightnessctl ffmpegthumbnailer loupe tuigreet greetd rofi-wayland --setopt=install_weak_deps=False 

## Hyprland
dnf5 -y copr enable solopasha/hyprland 
dnf5 -y install hyprland hyprpaper hypridle hyprlock hyprpolkitagent hyprshot waybar-git  --setopt=install_weak_deps=False
dnf5 -y copr disable solopasha/hyprland 

dnf5 -y copr enable tofik/nwg-shell 
dnf5 -y install nwg-look
dnf5 -y copr disable tofik/nwg-shell 

dnf5 -y copr enable chenxiaolong/sbctl 
dnf5 -y install sbctl
dnf5 -y copr disable chenxiaolong/sbctl 


## Tailscale
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/shells:zsh-users:zsh-autosuggestions/Fedora_Rawhide/shells:zsh-users:zsh-autosuggestions.repo
dnf5 -y install tailscale zsh-autosuggestions clapper

rm /etc/yum.repos.d/tailscale.repo
rm /etc/yum.repos.d/shells:zsh-users:zsh-autosuggestions.repo


## Nix
mkdir -p /nix && \
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix -o /nix/determinate-nix-installer.sh && \
	chmod a+rx /nix/determinate-nix-installer.sh

 curl -L https://github.com/curlpipe/ox/releases/latest/download/ox -o /usr/bin/ox && \
 chmod +x /usr/bin/ox

systemctl enable tlp
systemctl enable tailscaled
systemctl enable greetd


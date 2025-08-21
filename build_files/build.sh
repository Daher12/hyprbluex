#!/bin/bash

set -ouex pipefail

### Install packages

## environment
dnf5 install -y  dbus-tools dbus-daemon xdg-user-dirs xdg-desktop-portal-gtk kitty tlp zsh  --setopt=install_weak_deps=False 

systemctl disable wpa_supplicant

## sound
#dnf5 install -y pavucontrol

# networking
dnf5 install -y blueman bluez-tools iwd --setopt=install_weak_deps=False

## other

dnf5 install -y nautilus gvfs-nfs --setopt=install_weak_deps=False 

## Enable Ublue copr
dnf5 -y copr enable ublue-os/akmods 

## Hyprland
dnf5 -y copr enable solopasha/hyprland 
dnf5 -y install hyprland hyprpaper hypridle hyprlock hyprpolkitagent hyprshot uwsm newt --setopt=install_weak_deps=False
dnf5 -y copr disable solopasha/hyprland 

dnf5 -y copr enable tofik/nwg-shell 
dnf5 -y install nwg-look --setopt=install_weak_deps=False
dnf5 -y copr disable tofik/nwg-shell 

dnf5 -y copr enable chenxiaolong/sbctl 
dnf5 -y install sbctl
dnf5 -y copr disable chenxiaolong/sbctl 


## Tailscale
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/shells:zsh-users:zsh-autosuggestions/Fedora_Rawhide/shells:zsh-users:zsh-autosuggestions.repo
dnf5 -y install zsh-autosuggestions zsh-syntax-highlighting
dnf5 -y install tailscale 

rm /etc/yum.repos.d/tailscale.repo
rm /etc/yum.repos.d/shells:zsh-users:zsh-autosuggestions.repo

dnf5 -y copr disable ublue-os/akmods

## Nix
mkdir -p /nix && \
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix -o /nix/determinate-nix-installer.sh && \
	chmod a+rx /nix/determinate-nix-installer.sh

## Ox
curl -L https://github.com/curlpipe/ox/releases/latest/download/ox -o /usr/bin/ox && \
chmod +x /usr/bin/ox

curl -L https://github.com/Daher12/dots/blob/main/iwd.conf -o /etc/NetworkManager/conf.d/iwd.conf

systemctl enable tlp
systemctl enable tailscaled


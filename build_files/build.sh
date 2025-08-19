#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 install -y blueman  xorg-x11-server-Xwayland polkit dbus-tools dbus-daemon pavucontrol qt6-qtwayland qt5-qtwayland blueman-utils nm-applet nautilus xdg-desktop-portal-gtk xdg-user-dirs kitty tlp zsh zsh-syntax-highlighting brightnessctl rofi-wayland --setopt=install_weak_deps=False 

## environment
dnf5 install -y xorg-x11-server-Xwayland polkit dbus-tools dbus-daemon qt6-qtwayland qt5-qtwayland xdg-desktop-portal-gtk xdg-user-dirs kitty tlp zsh zsh-syntax-highlighting --setopt=install_weak_deps=False 

## sound
dnf5 install -y wireplumber pipewire pipewire-pulseaudio alsa-firmware pavucontrol pipewire-libs-extra

# networking
dnf5 install -y blueman bluez-tools bluez network-manager-applet iwd 

## other

dnf5 install -y ffmpeg ffmpeg-libs libfdk-aac  gstreamer1-plugins-bad gstreamer1-plugins-ugly 


## Enable Ublue copr
dnf5 -y copr enable ublue-os/akmods 
dnf5 -y copr enable ublue-os/packages
dnf5 -y install ublue-os-udev-rules ublue-os-update-services ublue-os-signing ublue-os-just ublue-os-luks
dnf5 -y copr disable  ublue-os/packages

## Hyprland
dnf5 -y copr enable solopasha/hyprland 
dnf5 -y install hyprland hyprpaper hypridle hyprlock hyprpolkitagent hyprshot  --setopt=install_weak_deps=False
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
dnf5 -y install tailscale zsh-autosuggestions greetd

rm /etc/yum.repos.d/tailscale.repo
rm /etc/yum.repos.d/shells:zsh-users:zsh-autosuggestions.repo

dnf5 -y copr disable ublue-os/akmods

## Nix
mkdir -p /nix && \
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix -o /nix/determinate-nix-installer.sh && \
	chmod a+rx /nix/determinate-nix-installer.sh

 curl -L https://github.com/curlpipe/ox/releases/latest/download/ox -o /usr/bin/ox && \
 chmod +x /usr/bin/ox

systemctl enable tlp
systemctl enable tailscaled
systemctl enable greetd


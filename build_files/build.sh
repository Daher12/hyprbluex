#!/bin/bash

set -ouex pipefail

### Install packages

## environment
dnf5 install -y util-linux-user dbus-daemon xdg-user-dirs kitty tlp zsh  --setopt=install_weak_deps=False 

# networking
dnf5 install -y blueman iwd --setopt=install_weak_deps=False

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

dnf5 -y copr enable monkeygold/nautilus-open-any-terminal
dnf5 -y install nautilus-open-any-terminal
dnf5 -y copr disable monkeygold/nautilus-open-any-terminal

## Tailscale
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y install zsh-syntax-highlighting tailscale

rm /etc/yum.repos.d/tailscale.repo
rm /etc/yum.repos.d/shells:zsh-users:zsh-autosuggestions.repo

dnf5 -y copr disable ublue-os/akmods

## Nix
mkdir -p /nix

## Ox
curl -L https://github.com/curlpipe/ox/releases/latest/download/ox -o /usr/bin/ox && \
chmod +x /usr/bin/ox

## Impala
curl -L https://github.com/pythops/impala/releases/latest/download/impala-x86_64-unknown-linux-gnu  -o /usr/bin/impala && \
chmod +x /usr/bin/impala

curl -L https://raw.githubusercontent.com/Daher12/dots/refs/heads/main/iwd.conf -o /etc/NetworkManager/conf.d/iwd.conf

systemctl disable wpa_supplicant
systemctl enable tlp
systemctl enable tailscaled


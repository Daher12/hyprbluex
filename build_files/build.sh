#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 -y copr enable ublue-os/akmods 
dnf5 -y copr enable solopasha/hyprland 
dnf5 -y copr enable tofik/nwg-shell 
dnf5 -y copr enable chenxiaolong/sbctl
dnf5 -y copr enable monkeygold/nautilus-open-any-terminal
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

dnf5 install -y dbus-daemon qt6-wayland xdg-user-dirs kitty tlp libappstream-glib fish blueman iwd nautilus hyprland hyprpaper hypridle hyprlock hyprpolkitagent hyprshot uwsm newt nwg-look nwg-displays sbctl nautilus-open-any-terminal tailscale --setopt=install_weak_deps=False

#ls /etc/yum.repos.d/
#dnf5 -y copr disable solopasha/hyprland 
#dnf5 -y copr disable tofik/nwg-shell 
#dnf5 -y copr disable chenxiaolong/sbctl 
#dnf5 -y copr disable monkeygold/nautilus-open-any-terminal
rm /etc/yum.repos.d/tailscale.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:chenxiaolong:sbctl.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:monkeygold:nautilus-open-any-terminal.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:solopasha:hyprland.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:tofik:nwg-shell.repo /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:ublue-os:akmods.repo


#dnf5 -y copr disable ublue-os/akmods

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


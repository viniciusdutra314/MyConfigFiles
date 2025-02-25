#!/bin/bash
#update ppa 
sudo apt install -y ca-certificates curl wget gpg

#gh
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null 

# Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

#vscode
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

#install apps from ppa 
sudo apt update 
sudo apt install -y gh apt-transport-https code docker-ce docker-ce-cli  \
containerd.io docker-buildx-plugin docker-compose-plugin 

# docker without sudo
if ! getent group docker > /dev/null; then
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
else
    echo "Docker group already exists."
fi

#miscellaneous
sudo apt install -y wget git cmake make vim valgrind  gparted htop btop python3-pip \
tree cloc speedtest-cli ffmpeg distrobox neofetch gnome-shell-pomodoro flameshot

wget https://github.com/bayasdev/envycontrol/releases/download/v3.5.1/python3-envycontrol_3.5.1-1_all.deb
sudo apt install -y ./python3-envycontrol_3.5.1-1_all.deb

## Terminal

sudo apt-get install -y tilix tmux
sudo apt remove -y --purge gnome-terminal

##flatpak 
sudo apt install flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

awk '{print "flatpak install -y "$1" "$2}' ./flatpak_apps.txt > /tmp/flatpak_install.sh
sudo chmod +x /tmp/flatpak_install.sh
/tmp/flatpak_install.sh

sudo apt upgrade -y





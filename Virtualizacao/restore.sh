#!bin/bash

apt install figlet -y

echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
echo "Definindo Storage"

zfs create -o quota=100G rpool/VM-software
zfs create -o quota=20G rpool/VM-pfsense
zfs create -o quota=60G rpool/VM-windowsserver
zfs create -o quota=80G rpool/LXC-monitoramento
zfs create -o quota=500G rpool/LXC-samba

zfs destroy rpool /var/lib/vz
zfs create -o quota=25G /var/lib/vz

echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
echo "Corrigindo Mirror/Reposiórios"

echo "deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware" > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list

apt update -y

echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"

echo "auto lo" > /etc/network/interfaces
echo "iface lo inet loopback" >> /etc/network/interfaces

echo "# Interface Física para WAN" >> /etc/network/interfaces
echo "iface nic0 inet manual" >> /etc/network/interfaces

echo "# Interface Virtual para WAN" >> /etc/network/interfaces
echo "auto vmbr0" >> /etc/network/interfaces
echo "iface vmbr0 inet static" >> /etc/network/interfaces
echo "	address 192.168.0.223/24" >> /etc/network/interfaces
echo "	gateway 192.168.0.1" >> /etc/network/interfaces
echo "	bridge-ports nic0" >> /etc/network/interfaces
echo "	bridge-stp off" >> /etc/network/interfaces
echo "	bridge-fd 0" >> /etc/network/interfaces

echo "# Interface Física para LAN" >> /etc/network/interfaces
echo "iface nic1 inet manual" >> /etc/network/interfaces

echo "# Interface Virtual para LAN" >> /etc/network/interfaces
echo "auto vmbr1" >> /etc/network/interfaces
echo "iface vmbr1 inet static" >> /etc/network/interfaces
echo "	address 192.168.1.0/28" >> /etc/network/interfaces
echo "	bridge-ports nic1" >> /etc/network/interfaces
echo "	bridge-stp off" >> /etc/network/interfaces
echo "	bridge-fd 0" >> /etc/network/interfaces

systemctl restart networking.service

figlet Execucao Concluida

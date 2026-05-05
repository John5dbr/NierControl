#!bin/bash

echo "Baixando Tailscale"
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --ssh
echo "=================="

echo "Atribuindo computador à VPN"
echo "Acessar site do Tailscale com conta da Nier:Control"
sudo tailscale up
echo "=================="

echo "Baixando SSH"
apt install openssh-server openssh-client curl figlet -y
echo "=================="
curl ascii.live/knot
figlet Execução Concluída
echo "Exemplo de comando para acesso remoto: sudo ssh Usuario@Ip-Do-Servidor"





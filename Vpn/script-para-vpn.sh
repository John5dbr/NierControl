#!bin/bash

echo "Baixando SSH"
apt install openssh-server openssh-client curl wget gpg figlet -y
echo "=================="

echo "Baixando Tailscale"
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up --ssh
echo "=================="

echo "Atribuindo computador à VPN"
echo "Acessar site do Tailscale com conta da Nier:Control"
tailscale up
echo "=================="

figlet Execucao Concluida
echo "Exemplo de comando para acesso remoto: sudo ssh Usuario@Ip-Do-Servidor"





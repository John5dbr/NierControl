#!/bin/bash

email="";
name="";

sudo apt install git figlet -y

read -p "Email do usuário no GitHub: " email
git config --global user.email "$email"

read -p "Nome do usuário no GitHub: " name
git config --global user.name "$name"

rm -rf ~/Script-NierControl
git clone https://github.com/John5dbr/NierControl.git ~/Script-NierControl
cd Script-NierControl

echo "Insira seu nome de usuário do GitHub e seu token de acesso registrado"
git push --set-upstream origin main

figlet "Execucao Concluida"

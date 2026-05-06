#!/bin/bash

email="";
name="";

sudo apt install git figlet -y
mkdir Script-NierControl && cd Script-NierControl

git init


read -p "Email do usuário no GitHub: " email
git config --global user.email "$email"

read -p "Nome do usuário no GitHub: " name
git config --global user.name "$name"

git pull https://github.com/John5dbr/NierControl.git

figlet Execucao Concluida

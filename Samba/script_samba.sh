#!/bin/bash

echo "--- INICIANDO INSTALAÇÃO MANUAL (NO PELO) ---"

# 1. Instalação dos pacotes
apt update
apt install samba samba-common-bin quota quotatool -y

# 2. Criação das Pastas e Grupos
groupadd diretoria
groupadd rh
groupadd producao
groupadd financeiro
groupadd compras
groupadd marketing
groupadd publico

mkdir -p /srv/samba/diretoria
mkdir -p /srv/samba/rh
mkdir -p /srv/samba/producao
mkdir -p /srv/samba/financeiro
mkdir -p /srv/samba/compras
mkdir -p /srv/samba/marketing
mkdir -p /srv/samba/publico

chown root:diretoria /srv/samba/diretoria
chown root:rh /srv/samba/rh
chown root:producao /srv/samba/producao
chown root:financeiro /srv/samba/financeiro
chown root:compras /srv/samba/compras
chown root:marketing /srv/samba/marketing
chown root:publico /srv/samba/publico

chmod 2770 /srv/samba/diretoria
chmod 2770 /srv/samba/rh
chmod 2770 /srv/samba/producao
chmod 2770 /srv/samba/financeiro
chmod 2770 /srv/samba/compras
chmod 2770 /srv/samba/marketing
chmod 777 /srv/samba/publico

echo "--- CADASTRANDO USUÁRIOS UM POR UM ---"

# --- DIRETORIA (5GB) ---
useradd -m -g diretoria -s /bin/false diretor1
(echo "senai101"; echo "senai101") | smbpasswd -a -s diretor1
quotatool -u diretor1 -b -q 5000M -l 5000M /

useradd -m -g diretoria -s /bin/false diretor2
(echo "senai101"; echo "senai101") | smbpasswd -a -s diretor2
quotatool -u diretor2 -b -q 5000M -l 5000M /

# --- RH ---
useradd -m -g rh -s /bin/false rh_analista1
(echo "senai101"; echo "senai101") | smbpasswd -a -s rh_analista1
quotatool -u rh_analista1 -b -q 2000M -l 2000M /

useradd -m -g rh -s /bin/false rh_analista2
(echo "senai101"; echo "senai101") | smbpasswd -a -s rh_analista2
quotatool -u rh_analista2 -b -q 2000M -l 2000M /

useradd -m -g rh -s /bin/false rh_assistente1
(echo "senai101"; echo "senai101") | smbpasswd -a -s rh_assistente1
quotatool -u rh_assistente1 -b -q 1000M -l 1000M /

useradd -m -g rh -s /bin/false rh_assistente2
(echo "senai101"; echo "senai101") | smbpasswd -a -s rh_assistente2
quotatool -u rh_assistente2 -b -q 1000M -l 1000M /

useradd -m -g rh -s /bin/false rh_assistente3
(echo "senai101"; echo "senai101") | smbpasswd -a -s rh_assistente3
quotatool -u rh_assistente3 -b -q 1000M -l 1000M /

# --- PRODUÇÃO (Coordenador, Supervisor, Líderes e 16 Operadores) ---
useradd -m -g producao -s /bin/false prod_coordenador
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_coordenador
quotatool -u prod_coordenador -b -q 2000M -l 2000M /

useradd -m -g producao -s /bin/false prod_supervisor
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_supervisor
quotatool -u prod_supervisor -b -q 2000M -l 2000M /

useradd -m -g producao -s /bin/false prod_lider1
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_lider1
quotatool -u prod_lider1 -b -q 1000M -l 1000M /

useradd -m -g producao -s /bin/false prod_l1_op1
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op1
quotatool -u prod_l1_op1 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op2
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op2
quotatool -u prod_l1_op2 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op3
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op3
quotatool -u prod_l1_op3 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op4
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op4
quotatool -u prod_l1_op4 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op5
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op5
quotatool -u prod_l1_op5 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op6
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op6
quotatool -u prod_l1_op6 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op7
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op7
quotatool -u prod_l1_op7 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l1_op8
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l1_op8
quotatool -u prod_l1_op8 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_lider2
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_lider2
quotatool -u prod_lider2 -b -q 1000M -l 1000M /

useradd -m -g producao -s /bin/false prod_l2_op1
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op1
quotatool -u prod_l2_op1 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op2
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op2
quotatool -u prod_l2_op2 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op3
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op3
quotatool -u prod_l2_op3 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op4
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op4
quotatool -u prod_l2_op4 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op5
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op5
quotatool -u prod_l2_op5 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op6
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op6
quotatool -u prod_l2_op6 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op7
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op7
quotatool -u prod_l2_op7 -b -q 500M -l 500M /

useradd -m -g producao -s /bin/false prod_l2_op8
(echo "senai101"; echo "senai101") | smbpasswd -a -s prod_l2_op8
quotatool -u prod_l2_op8 -b -q 500M -l 500M /

# --- FINANCEIRO ---
useradd -m -g financeiro -s /bin/false fin_analista
(echo "senai101"; echo "senai101") | smbpasswd -a -s fin_analista
quotatool -u fin_analista -b -q 3000M -l 3000M /

useradd -m -g financeiro -s /bin/false fin_assistente1
(echo "senai101"; echo "senai101") | smbpasswd -a -s fin_assistente1
quotatool -u fin_assistente1 -b -q 1000M -l 1000M /

useradd -m -g financeiro -s /bin/false fin_assistente2
(echo "senai101"; echo "senai101") | smbpasswd -a -s fin_assistente2
quotatool -u fin_assistente2 -b -q 1000M -l 1000M /

useradd -m -g financeiro -s /bin/false fin_assistente3
(echo "senai101"; echo "senai101") | smbpasswd -a -s fin_assistente3
quotatool -u fin_assistente3 -b -q 1000M -l 1000M /

# --- COMPRAS ---
useradd -m -g compras -s /bin/false com_analista
(echo "senai101"; echo "senai101") | smbpasswd -a -s com_analista
quotatool -u com_analista -b -q 2000M -l 2000M /

useradd -m -g compras -s /bin/false com_assistente
(echo "senai101"; echo "senai101") | smbpasswd -a -s com_assistente
quotatool -u com_assistente -b -q 1000M -l 1000M /

# --- MARKETING ---
useradd -m -g marketing -s /bin/false mkt_gerente
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_gerente
quotatool -u mkt_gerente -b -q 5000M -l 5000M /

useradd -m -g marketing -s /bin/false mkt_analista1
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_analista1
quotatool -u mkt_analista1 -b -q 2000M -l 2000M /

useradd -m -g marketing -s /bin/false mkt_analista2
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_analista2
quotatool -u mkt_analista2 -b -q 2000M -l 2000M /

useradd -m -g marketing -s /bin/false mkt_social_manager
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_social_manager
quotatool -u mkt_social_manager -b -q 2000M -l 2000M /

useradd -m -g marketing -s /bin/false mkt_designer1
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_designer1
quotatool -u mkt_designer1 -b -q 10000M -l 10000M /

useradd -m -g marketing -s /bin/false mkt_designer2
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_designer2
quotatool -u mkt_designer2 -b -q 10000M -l 10000M /

useradd -m -g marketing -s /bin/false mkt_pesquisador
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_pesquisador
quotatool -u mkt_pesquisador -b -q 2000M -l 2000M /

useradd -m -g marketing -s /bin/false mkt_copywriter1
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_copywriter1
quotatool -u mkt_copywriter1 -b -q 2000M -l 2000M /

useradd -m -g marketing -s /bin/false mkt_copywriter2
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_copywriter2
quotatool -u mkt_copywriter2 -b -q 2000M -l 2000M /

useradd -m -g marketing -s /bin/false mkt_copywriter3
(echo "senai101"; echo "senai101") | smbpasswd -a -s mkt_copywriter3
quotatool -u mkt_copywriter3 -b -q 2000M -l 2000M /

echo "--- CONFIGURANDO SMB.CONF ---"

cat <<EOF > /etc/samba/smb.conf
[global]
    workgroup = WORKGROUP
    security = user
    map to guest = bad user
    delete veto files = yes

[Publico]
    path = /srv/samba/publico
    writable = yes
    guest ok = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/

[Diretoria]
    path = /srv/samba/diretoria
    valid users = @diretoria
    writable = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/

[RH]
    path = /srv/samba/rh
    valid users = @rh
    writable = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/

[Producao]
    path = /srv/samba/producao
    valid users = @producao
    writable = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/

[Financeiro]
    path = /srv/samba/financeiro
    valid users = @financeiro
    writable = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/

[Compras]
    path = /srv/samba/compras
    valid users = @compras
    writable = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/

[Marketing]
    path = /srv/samba/marketing
    valid users = @marketing
    writable = yes
    veto files = /.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/
EOF

# 5. Reiniciar serviços
systemctl restart smbd nmbd

echo "--- FINALIZADO COM SUCESSO! ---"
echo "--- Autor: Victor Gabriel ---"
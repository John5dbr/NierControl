echo "Inicializando instalação e configuração do serviço SAMBA"

# 1. Garante permissões e caminhos dos comandos
chmod +x setup_samba_final.sh
export PATH=$PATH:/usr/sbin:/sbin:/usr/bin:/bin

if [[ $EUID -ne 0 ]]; then
   echo "Erro: Rode como root (sudo bash setup_samba_final.sh)"
   exit 1
fi


echo "--- INSTALANDO SAMBA E CONFIGURANDO AS COTAS ---"
apt update && apt install samba samba-common-bin quota quotatool -y

# Ativa cotas no disco
mount -o remount,usrquota,grpquota / 2>/dev/null
quotacheck -avugm 2>/dev/null
quotaon -avug 2>/dev/null

# Variáveis
BASE_DIR="/srv/samba"
PASS="senai101"
VETO="/.bat/.exe/.mp3/.zip/.iso/.rar/.msi/.vbs/"

# Função para criar Usuário + Samba + Cota
add_u() {
    local nome=$1
    local grupo=$2
    local cota=$3
    if ! id "$nome" &>/dev/null; then
        useradd -m -g "$grupo" -s /bin/false "$nome"
        (echo "$PASS"; echo "$PASS") | smbpasswd -a -s "$nome"
        quotatool -u "$nome" -b -q "${cota}M" -l "${cota}M" / 2>/dev/null
        echo "Criado: $nome ($cota MB)"
    fi
}

echo "--- CRIANDO GRUPOS E PASTAS ---"
for d in diretoria rh producao financeiro compras marketing publico; do
    groupadd -f "$d"
    mkdir -p "$BASE_DIR/$d"
    chown root:"$d" "$BASE_DIR/$d"
    chmod 2770 "$BASE_DIR/$d"
done
chmod 777 "$BASE_DIR/publico"

echo "--- CADASTRANDO OS USUÁRIOS ---"

# Diretoria (2) - 5GB
for i in 1 2; do add_u "diretor$i" "diretoria" 5000; done

# RH (5) - Analista 2GB, Assistente 1GB
for i in 1 2; do add_u "rh_analista$i" "rh" 2000; done
for i in 1 2 3; do add_u "rh_assistente$i" "rh" 1000; done

# Produção (20) - Coord/Super 2GB, Líder 1GB, Op 500MB
add_u "prod_coordenador" "producao" 2000
add_u "prod_supervisor" "producao" 2000
for l in 1 2; do
    add_u "prod_lider$l" "producao" 1000
    for o in 1 2 3 4 5 6 7 8; do
        add_u "prod_lider${l}_op${o}" "producao" 500
    done
done

# Financeiro (4) - Analista 3GB, Assistente 1GB
add_u "fin_analista" "financeiro" 3000
for i in 1 2 3; do add_u "fin_assistente$i" "financeiro" 1000; done

# Compras (2) - Analista 2GB, Assistente 1GB
add_u "com_analista" "compras" 2000
add_u "com_assistente" "compras" 1000

# Marketing (12) - Gerente 5GB, Designer 10GB, Outros 2GB
add_u "mkt_gerente" "marketing" 5000
for i in 1 2; do add_u "mkt_analista$i" "marketing" 2000; done
add_u "mkt_social_manager" "marketing" 2000
for i in 1 2; do add_u "mkt_designer$i" "marketing" 10000; done
add_u "mkt_pesquisador" "marketing" 2000
for i in 1 2 3; do add_u "mkt_copywriter$i" "marketing" 2000; done

echo "--- CONFIGURANDO SMB.CONF ---"
cat <<EOF > /etc/samba/smb.conf
[global]
   workgroup = WORKGROUP
   security = user
   map to guest = bad user
   delete veto files = yes

[Publico]
   path = $BASE_DIR/publico
   writable = yes
   guest ok = yes
   veto files = $VETO

[Diretoria]
   path = $BASE_DIR/diretoria
   valid users = @diretoria
   writable = yes
   veto files = $VETO

[RH]
   path = $BASE_DIR/rh
   valid users = @rh
   writable = yes
   veto files = $VETO

[Producao]
   path = $BASE_DIR/producao
   valid users = @producao
   writable = yes
   veto files = $VETO

[Financeiro]
   path = $BASE_DIR/financeiro
   valid users = @financeiro
   writable = yes
   veto files = $VETO

[Compras]
   path = $BASE_DIR/compras
   valid users = @compras
   writable = yes
   veto files = $VETO

[Marketing]
   path = $BASE_DIR/marketing
   valid users = @marketing
   writable = yes
   veto files = $VETO
EOF

systemctl restart smbd nmbd
echo "--- FINALIZADO COM SUCESSO PEDRINHO! ---"
echo "--- Feito: Victor Gabriel ---"
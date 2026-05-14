#!/bin/bash
# ==============================================================================
# Script de Instalação Automatizada: Zabbix 7.0 LTS + Grafana no Debian 12
# Integração Automática via Provisioning + Correção de Locales
# ==============================================================================

# Encerrar o script em caso de qualquer erro
set -e

# ================= VARIÁVEIS =================
DB_ROOT_PASS="RootDBPass@2024"       # Senha de root do MariaDB (Mude se desejar)
DB_ZABBIX_USER="zabbix"              # Usuário do banco de dados do Zabbix
DB_ZABBIX_PASS="ZabbixPass@2024"     # Senha do banco de dados do Zabbix
ZABBIX_ADMIN_USER="Admin"            # Usuário Padrão do Frontend do Zabbix
ZABBIX_ADMIN_PASS="zabbix"           # Senha Padrão do Frontend do Zabbix
# =============================================

echo "[1/11] Verificando privilégios de root..."
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute este script como root (sudo)."
  exit 1
fi

echo "[2/11] Atualizando o sistema e instalando dependências base..."
apt-get update && apt-get upgrade -y
apt-get install -y wget curl gnupg2 software-properties-common apt-transport-https vim sudo locales

echo "[3/11] Gerando Locales (Corrigindo erro de interface do Zabbix)..."
# Ativa e gera os idiomas Inglês (EUA) e Português (Brasil)
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales

echo "[4/11] Instalando e configurando o MariaDB (Banco de Dados)..."
apt-get install -y mariadb-server
systemctl start mariadb
systemctl enable mariadb

# Configurando o banco de dados do Zabbix
mysql -uroot -e "CREATE DATABASE zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -uroot -e "CREATE USER '${DB_ZABBIX_USER}'@'localhost' IDENTIFIED BY '${DB_ZABBIX_PASS}';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON zabbix.* TO '${DB_ZABBIX_USER}'@'localhost';"
mysql -uroot -e "SET GLOBAL log_bin_trust_function_creators = 1;"
mysql -uroot -e "FLUSH PRIVILEGES;"

echo "[5/11] Adicionando repositório oficial do Zabbix 7.0..."
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-2+debian12_all.deb
dpkg -i zabbix-release_7.0-2+debian12_all.deb
apt-get update

echo "[6/11] Instalando pacotes do Zabbix Server, Frontend, Agent e Apache..."
apt-get install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

echo "[7/11] Importando esquema e dados iniciais do Zabbix (Isso pode demorar alguns minutos)..."
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -u${DB_ZABBIX_USER} -p${DB_ZABBIX_PASS} zabbix
# Desativar a opção de log_bin_trust_function_creators após importação
mysql -uroot -e "SET GLOBAL log_bin_trust_function_creators = 0;"

echo "[8/11] Configurando o Zabbix Server e o Frontend Automático..."
# Configura a senha do banco no zabbix_server.conf
sed -i "s/# DBPassword=/DBPassword=${DB_ZABBIX_PASS}/g" /etc/zabbix/zabbix_server.conf

# Cria o arquivo de configuração do PHP (Bypass no Wizard de instalação Web)
cat <<EOF > /etc/zabbix/web/zabbix.conf.php
<?php
// Zabbix GUI configuration file.
global \$DB, \$HISTORY;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = 'localhost';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = 'zabbix';
\$DB['USER']     = '${DB_ZABBIX_USER}';
\$DB['PASSWORD'] = '${DB_ZABBIX_PASS}';
\$DB['SCHEMA']   = '';
\$DB['ENCRYPTION'] = false;
\$DB['KEY_FILE'] = '';
\$DB['CERT_FILE'] = '';
\$DB['CA_FILE'] = '';
\$DB['VERIFY_HOST'] = false;
\$DB['CIPHER_LIST'] = '';
\$DB['DOUBLE_IEEE754'] = true;

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = 'Zabbix Server Local';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
EOF
chown www-data:www-data /etc/zabbix/web/zabbix.conf.php

systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

echo "[9/11] Instalando o Grafana..."
mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list
apt-get update
apt-get install -y grafana
systemctl start grafana-server
systemctl enable grafana-server

echo "[10/11] Instalando o Plugin do Zabbix no Grafana..."
grafana-cli plugins install alexanderzobnin-zabbix-app

echo "[11/11] Provisionando a integração automática (Zabbix Data Source) no Grafana..."
# O plugin do Zabbix precisa de permissão de App. Isso configura a origem de dados
cat <<EOF > /etc/grafana/provisioning/datasources/zabbix.yaml
apiVersion: 1
datasources:
  - name: Zabbix
    type: alexanderzobnin-zabbix-datasource
    access: proxy
    url: http://localhost/zabbix/api_jsonrpc.php
    jsonData:
      username: ${ZABBIX_ADMIN_USER}
      trends: true
    secureJsonData:
      password: ${ZABBIX_ADMIN_PASS}
    version: 1
EOF
chown -R grafana:grafana /etc/grafana/provisioning/datasources/

# Reiniciar o Grafana para aplicar o plugin e o provisionamento
systemctl restart grafana-server

echo "========================================================================="
echo " Instalação e Integração Concluídas com Sucesso!"
echo "========================================================================="
echo ""
IP=$(hostname -I | awk '{print $1}')
echo "➜ ACESSO AO ZABBIX:"
echo "    URL: http://${IP}/zabbix"
echo "    Usuário: ${ZABBIX_ADMIN_USER}"
echo "    Senha: ${ZABBIX_ADMIN_PASS}"
echo ""
echo "➜ ACESSO AO GRAFANA:"
echo "    URL: http://${IP}:3000"
echo "    Usuário: admin"
echo "    Senha: admin"
echo "========================================================================="

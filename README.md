# Documentação da Infraestrutura de TI - Projeto Startup

Este repositório armazena a estrutura e a documentação dos serviços implantados e gerenciados para a infraestrutura de TI da startup, conforme os requisitos do projeto [cite: RequisitosDoProjeto.pdf].

Abaixo está a descrição e o escopo de responsabilidade de cada diretório:

## Diretórios

### `Aplicacao` (Pedro)
* **Foco:** Plataformas e aplicativos da empresa.
* **Responsabilidade:** Armazenamento de scripts, arquivos de configuração e código-fonte relacionados ao desenvolvimento de software, automação de processos internos e integrações de sistemas da startup [cite: RequisitosDoProjeto.pdf].

### `Backup` (Victor)
* **Foco:** Políticas de proteção de dados.
* **Responsabilidade:** Gerenciamento dos arquivos de configuração e políticas do Bacula para a realização de backups Full, Diferencial e Incremental dos servidores internos (Zabbix, Samba e Syslog) [cite: RequisitosDoProjeto.pdf].

### `Monitoramento` (Gabriel)
* **Foco:** Observabilidade, Logs e Suporte.
* **Responsabilidade:** Contém as configurações do Zabbix, dashboards do Grafana, gerenciamento de chamados no GLPI, inventário de ativos e auditoria de acesso à internet [cite: RequisitosDoProjeto.pdf].

### `Pfsense` (Matheus)
* **Foco:** Segurança de Perímetro e Rede.
* **Responsabilidade:** Configurações do firewall pfSense, incluindo regras de NAT para acesso à internet, LAN, segmentação de rede, além da implementação de blacklist para bloqueio de sites e políticas de segurança de borda [cite: RequisitosDoProjeto.pdf].

### `Samba` (Indiano)
* **Foco:** Compartilhamento de Arquivos e Controle de Acesso.
* **Responsabilidade:** Definição das pastas departamentais (Diretoria, RH, Produção, Financeiro, Compras, Marketing), controle de permissões, cotas de espaço em disco e bloqueio de extensões prejudiciais (como *.exe, *.mp3, *.iso) [cite: RequisitosDoProjeto.pdf].

### `Storage` (Felipe e Ben 10)
* **Foco:** Armazenamento e Alta Disponibilidade.
* **Responsabilidade:** Configuração do sistema de storage que comporta os volumes do Bacula, implementando redundância via RAID para garantir a segurança e a disponibilidade dos dados da empresa [cite: RequisitosDoProjeto.pdf].

### `Vpn` (Pedro)
* **Foco:** Acesso Remoto Seguro.
* **Responsabilidade:** Arquivos de configuração e chaves para a autenticação de usuários via VPN, integrados ao Active Directory ou base de usuários do SAMBA para acesso seguro aos recursos da rede corporativa [cite: RequisitosDoProjeto.pdf].

---
*Desenvolvido para simular e garantir a estabilidade da infraestrutura e dos dados da empresa [...].*
#!/bin/bash
# Substitui a porta do Nginx dinamicamente antes de iniciar o serviço

# Atualiza o arquivo de configuração do Nginx com a porta correta
sed -i "s/listen 127.0.0.1:80;/listen 0.0.0.0:${PORT};/" /etc/nginx/sites-available/azuracast.conf || true

# Remove link duplicado se existir
rm -f /etc/nginx/sites-enabled/default.vhost || true

# Inicia o AzuraCast normalmente
exec /usr/local/bin/my_init

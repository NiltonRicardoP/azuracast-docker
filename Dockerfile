FROM ghcr.io/azuracast/azuracast:stable

# Variáveis de ambiente essenciais para modo standalone + SQLite
ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=true \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000 \
    MARIADB_ROOT_PASSWORD=azura_root_pass

# Remove configurações e arquivos de MySQL
RUN rm -rf /etc/mysql /var/lib/mysql || true

# Recria o arquivo de configuração do nginx
RUN mkdir -p /etc/nginx/sites-available && \
    cat <<EOF > /etc/nginx/sites-available/azuracast.conf
server {
    listen 0.0.0.0:10000;
    root /var/azuracast/www;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include fastcgi_params;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

# Ativa o virtual host do nginx e remove o padrão
RUN ln -sf /etc/nginx/sites-available/azuracast.conf /etc/nginx/sites-enabled/azuracast.conf && \
    rm -f /etc/nginx/sites-enabled/default.vhost || true

# Expõe a porta que o Render vai detectar
EXPOSE 10000

# Comando de inicialização padrão
CMD ["/usr/local/bin/my_init"]

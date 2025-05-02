FROM ghcr.io/azuracast/azuracast:stable

# Configurações principais do AzuraCast
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

# Corrige Nginx para escutar na porta dinâmica esperada pela Render
RUN mkdir -p /etc/nginx/sites-available && \
    echo "server {
    listen 0.0.0.0:\${PORT};
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
}" > /etc/nginx/sites-available/azuracast.conf

# Ativa esse virtual host
RUN ln -sf /etc/nginx/sites-available/azuracast.conf /etc/nginx/sites-enabled/azuracast.conf

# Remove virtual host padrão duplicado
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Evita problemas com MariaDB desnecessário se for SQLite
RUN rm -f /etc/mysql/conf.d/network.cnf || true

# Expõe a porta que será usada (Render respeita o EXPOSE para fins de debug)
EXPOSE 10000

# Comando padrão de inicialização
CMD ["/usr/local/bin/my_init"]

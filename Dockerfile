FROM ghcr.io/azuracast/azuracast:stable

# Variáveis de ambiente essenciais
ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=true \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    MARIADB_ROOT_PASSWORD=azura_root_pass \
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000

# Recria a configuração do Nginx para escutar na porta correta da Railway
RUN mkdir -p /etc/nginx/sites-available && \
    echo 'server {
        listen 0.0.0.0:10000;
        server_name localhost;

        root /var/azuracast/www;
        index index.php index.html;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
            include fastcgi_params;
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }' > /etc/nginx/sites-available/azuracast.conf

# Ativa a configuração do Nginx criada
RUN ln -sf /etc/nginx/sites-available/azuracast.conf /etc/nginx/sites-enabled/azuracast.conf

# Remove virtual host padrão
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Evita erro com MySQL
RUN rm -f /etc/mysql/conf.d/network.cnf || true

EXPOSE 10000

CMD ["/usr/local/bin/my_init"]

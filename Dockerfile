FROM ghcr.io/azuracast/azuracast:stable

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

# Corrige Nginx para escutar na porta $PORT
RUN mkdir -p /etc/nginx/sites-available && \
    echo "server {\n\
        listen 0.0.0.0:${PORT};\n\
        server_name localhost;\n\
        root /var/azuracast/www;\n\
        index index.php index.html;\n\
        location / {\n\
            try_files \$uri \$uri/ /index.php?\$query_string;\n\
        }\n\
        location ~ \.php\$ {\n\
            include fastcgi_params;\n\
            fastcgi_pass 127.0.0.1:9000;\n\
            fastcgi_index index.php;\n\
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;\n\
        }\n\
    }" > /etc/nginx/sites-available/azuracast.conf

RUN ln -sf /etc/nginx/sites-available/azuracast.conf /etc/nginx/sites-enabled/azuracast.conf
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true
RUN rm -f /etc/mysql/conf.d/network.cnf || true

EXPOSE 10000

CMD ["/usr/local/bin/my_init"]

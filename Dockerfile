FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    DB_IS_SQLITE=false \
    MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_USER=azuracast \
    MYSQL_PASSWORD=azuracast \
    MYSQL_DATABASE=azuracast \
    MARIADB_ROOT_PASSWORD=azura_root_pass \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000 \
    SUPERVISOR_HTTP=false

# Remover virtual host padrão duplicado
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Desativa script interno que recria o default.vhost
RUN echo "#!/bin/bash\nexit 0" > /etc/my_init.d/05_nginx_conf.sh && chmod +x /etc/my_init.d/05_nginx_conf.sh

# Remove config de painel HTTP do supervisord
RUN rm -f /etc/supervisor/conf.d/supervisord-http.conf || true

# Expõe a porta usada pelo Railway ou Render
EXPOSE 10000

CMD ["/usr/local/bin/my_init"]

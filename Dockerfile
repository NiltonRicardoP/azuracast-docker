FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
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
    AZURACAST_HTTP_PORT=10000

# Remove o virtual host default (evita erro de link simbólico duplicado)
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Expor porta esperada pelo Railway
EXPOSE 10000

# Comando de inicialização
CMD ["/usr/local/bin/my_init"]

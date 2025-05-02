FROM ghcr.io/azuracast/azuracast:stable

# Define variáveis de ambiente obrigatórias para MariaDB
ENV PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000 \
    INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=false \
    MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_DATABASE=azuracast \
    MYSQL_USER=azuracast \
    MYSQL_PASSWORD=azuracast \
    MARIADB_ROOT_PASSWORD=azura_root_pass \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis

EXPOSE 10000

CMD ["/usr/local/bin/my_init"]

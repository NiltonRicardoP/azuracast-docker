FROM ghcr.io/azuracast/azuracast:stable

# Força modo Docker com SQLite e desativa MariaDB
ENV AZURACAST_DC_MODE=true \
    INIT_REPO=false \
    MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_USER=azuracast \
    MYSQL_PASSWORD=azuracast \
    MYSQL_DATABASE=azuracast \
    AZURACAST_USE_SQLITE=true \
    MYSQL_DISABLE=true \
    SUPERVISOR_HTTP=false \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    REDIS_HOST=localhost

EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]

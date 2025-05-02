FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_USE_SQLITE=true \
    SUPERVISOR_HTTP=false \
    MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
    REDIS_HOST=localhost \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    WEB_PORT=80 \
    MYSQL_DISABLE=true \
    MYSQL_HOST=disabled \
    MYSQL_PORT=3306 \
    MYSQL_USER=disabled \
    MYSQL_PASSWORD=disabled \
    MYSQL_DATABASE=azuracast

EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]

FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
    REDIS_HOST=localhost \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_USER=azuracast \
    MYSQL_PASSWORD=azuracast \
    MYSQL_DATABASE=azuracast \
    WEB_PORT=${PORT:-10000}

# Remove link conflitante do nginx
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

EXPOSE 10000

CMD fuser -k ${PORT:-10000}/tcp || true && /usr/local/bin/my_init

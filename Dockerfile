FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    SUPERVISOR_HTTP=false \
    MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
    REDIS_HOST=localhost \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    WEB_PORT=80 \
    MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_USER=azuracast \
    MYSQL_PASSWORD=azuracast \
    MYSQL_DATABASE=azuracast

# Garante que o Nginx escute fora do localhost
RUN sed -i 's/listen 127.0.0.1:80;/listen 0.0.0.0:80;/g' /etc/nginx/sites-available/azuracast.conf || true

EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]

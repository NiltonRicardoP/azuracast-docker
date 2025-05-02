FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_USE_SQLITE=true \
    MYSQL_DISABLE=true \
    SUPERVISOR_HTTP=false \
    MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
    MYSQL_HOST=disabled \
    MYSQL_DATABASE=azuracast \
    MYSQL_USER=disabled \
    MYSQL_PASSWORD=disabled \
    REDIS_HOST=localhost \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    WEB_PORT=80 \
    NGINX_LISTEN=0.0.0.0

# Substitui a configuração padrão do Nginx
COPY nginx_custom.conf /etc/nginx/sites-enabled/default

EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]

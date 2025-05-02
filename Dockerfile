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
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000

# Corrige Nginx para escutar na porta correta da Render
RUN sed -i 's/listen 127.0.0.1:80;/listen 0.0.0.0:10000;/g' /etc/nginx/sites-available/azuracast.conf || true

# Remove link simbólico duplicado que causa erro
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Exponha a porta que o Render espera
EXPOSE 10000

CMD ["/usr/local/bin/my_init"]

FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
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

# Corrige nginx para escutar em todas as interfaces
RUN sed -i 's/listen 127.0.0.1:80;/listen 0.0.0.0:80;/g' /etc/nginx/sites-available/azuracast.conf || true

# Corrige MariaDB para escutar em TCP/IP (localhost:3306)
RUN echo -e "[mysqld]\nbind-address=127.0.0.1\nport=3306\n" >> /etc/mysql/my.cnf

# Evita erro de symlink duplicado no NGINX
RUN rm -f /etc/nginx/sites-enabled/default.vhost

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]

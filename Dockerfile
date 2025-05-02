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

# Corrige o nginx para aceitar conexões externas
RUN sed -i 's/listen 127.0.0.1:80;/listen 0.0.0.0:80;/g' /etc/nginx/sites-available/azuracast.conf || true

# Garante que o MariaDB escute na porta TCP (3306)
RUN sed -i 's/^port\s*=.*/port=3306/' /etc/mysql/my.cnf || true

# Opcional: executa como o usuário correto para evitar erros de permissão no Render
# USER azuracast

EXPOSE 80

CMD ["/usr/local/bin/my_init"]

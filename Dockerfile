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
    MYSQL_DATABASE=azuracast

# Garante que o AzuraCast escute na porta correta da Render
ENV PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000

# Corrige Nginx para escutar na porta do Render (0.0.0.0:$PORT)
RUN sed -i 's/listen 127.0.0.1:80;/listen 0.0.0.0:${PORT};/g' /etc/nginx/sites-available/azuracast.conf || true

# Corrige conflitos de link simbólico duplicado
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Evita que o MySQL configure porta errada
RUN echo -e "[mysqld]\nport=3306\nbind-address=127.0.0.1" > /etc/mysql/conf.d/network.cnf

# Expõe a porta correta
EXPOSE 10000

# Executa normalmente
CMD ["/usr/local/bin/my_init"]

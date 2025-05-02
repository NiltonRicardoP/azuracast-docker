FROM ghcr.io/azuracast/azuracast:stable

ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=true \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000

# Corrige Nginx para escutar na porta correta do Render
RUN sed -i 's/listen 127.0.0.1:80;/listen 0.0.0.0:${PORT};/g' /etc/nginx/sites-available/azuracast.conf || true

# Remove virtual host padrão duplicado (impede erro de link)
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Evita tentar usar MySQL
RUN rm -f /etc/mysql/conf.d/network.cnf || true

EXPOSE 10000

CMD ["/usr/local/bin/my_init"]

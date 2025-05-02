FROM ghcr.io/azuracast/azuracast:stable

ENV PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000 \
    INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=true \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis

# Expor a porta esperada
EXPOSE 10000

# Comando de inicialização
CMD ["/usr/local/bin/my_init"]

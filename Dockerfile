FROM ghcr.io/azuracast/azuracast:stable

ENV PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000 \
    INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=true \
    CACHE_DRIVER=file \
    SESSION_DRIVER=file

# Expõe a porta correta para o Railway detectar
EXPOSE 10000

# Railway precisa que o processo principal rode em primeiro plano
# my_init executa supervisord, mas Railway precisa da porta escutada imediatamente.
CMD ["/usr/local/bin/my_init", "--foreground"]

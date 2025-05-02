FROM ghcr.io/azuracast/azuracast:stable

# Configurações de ambiente (todas as envs necessárias)
ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=false \
    MYSQL_HOST=localhost \
    MYSQL_PORT=3306 \
    MYSQL_USER=azuracast \
    MYSQL_PASSWORD=azuracast \
    MYSQL_DATABASE=azuracast \
    MARIADB_ROOT_PASSWORD=azura_root_pass \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000

# Expor a porta que o Railway usará
EXPOSE 10000

# Comando padrão de inicialização
CMD ["/usr/local/bin/my_init"]

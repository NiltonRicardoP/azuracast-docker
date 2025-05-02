FROM ghcr.io/azuracast/azuracast:stable

# Variáveis de ambiente para forçar uso de SQLite e desativar MariaDB
ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_USE_SQLITE=true \
    SUPERVISOR_HTTP=false \
    MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
    DATABASE_URL=sqlite:///var/azuracast/db.sqlite \
    REDIS_HOST=localhost \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    WEB_PORT=80 \
    MYSQL_DISABLE=true \
    MYSQL_HOST=disabled \
    MYSQL_PORT=3306 \
    MYSQL_USER=disabled \
    MYSQL_PASSWORD=disabled \
    MYSQL_DATABASE=azuracast

# Expõe a porta para a Render detectar o serviço HTTP
EXPOSE 80

# Comando padrão do AzuraCast
CMD ["/usr/local/bin/docker-entrypoint.sh"]

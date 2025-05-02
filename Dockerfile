# Usa a imagem oficial do AzuraCast com suporte a SQLite
FROM ghcr.io/azuracast/azuracast:stable

# Define variáveis para desativar o MariaDB e ativar SQLite
ENV INIT_REPO=false \
    AZURACAST_USE_SQLITE=true \
    MYSQL_DISABLE=true \
    MYSQL_HOST=disabled \
    MYSQL_PORT=3306 \
    MYSQL_USER=disabled \
    MYSQL_PASSWORD=disabled \
    MYSQL_DATABASE=azuracast \
    SUPERVISOR_HTTP=false \
    AZURACAST_DC_MODE=true

# Expõe a porta padrão do AzuraCast (HTTP)
EXPOSE 80

# Comando padrão que inicializa o AzuraCast
CMD ["/usr/local/bin/docker-entrypoint.sh"]

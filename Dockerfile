FROM ghcr.io/azuracast/azuracast:stable

# Define o diretório padrão
WORKDIR /var/azuracast

# Usa SQLite como banco
ENV AZURACAST_USE_SQLITE=true
ENV SUPERVISOR_HTTP=false
ENV INIT_REPO=false

# Porta padrão
EXPOSE 80

CMD ["/usr/local/bin/docker-entrypoint.sh"]

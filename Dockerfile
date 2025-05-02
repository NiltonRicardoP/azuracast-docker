FROM ghcr.io/azuracast/azuracast:stable

# Variáveis de ambiente
ENV INIT_REPO=false \
    AZURACAST_DC_MODE=true \
    AZURACAST_STANDALONE=true \
    SUPERVISOR_HTTP=false \
    DB_IS_SQLITE=true \
    CACHE_DRIVER=redis \
    SESSION_DRIVER=redis \
    PORT=10000 \
    WEB_PORT=10000 \
    AZURACAST_HTTP_PORT=10000 \
    MARIADB_ROOT_PASSWORD=azura_root_pass

# Garante que a pasta exista antes de gerar o config do Nginx
RUN mkdir -p /etc/nginx/sites-available

# Cria manualmente a config do Nginx com porta dinâmica
RUN bash -c 'echo "server {\n\
    listen 0.0.0.0:${PORT};\n\
    root /var/azuracast/www;\n\
    index index.php index.html;\n\
    location / {\n\
        try_files \$uri \$uri/ /index.php?\$query_string;\n\
    }\n\
    location ~ \.php$ {\n\
        include fastcgi_params;\n\
        fastcgi_pass 127.0.0.1:9000;\n\
        fastcgi_index index.php;\n\
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;\n\
    }\n\
}" > /etc/nginx/sites-available/azuracast.conf'

# Ativa o novo virtual host
RUN ln -sf /etc/nginx/sites-available/azuracast.conf /etc/nginx/sites-enabled/azuracast.conf

# Remove host default para evitar conflito
RUN rm -f /etc/nginx/sites-enabled/default.vhost || true

# Remove configuração de MySQL que não será usada
RUN rm -f /etc/mysql/conf.d/network.cnf || true

# Expõe a porta esperada
EXPOSE 10000

# Comando padrão de inicialização
CMD ["/usr/local/bin/my_init"]

FROM postgres

COPY create.sh /docker-entrypoint-initdb.d/create.sh
RUN chmod +x /docker-entrypoint-initdb.d/create.sh


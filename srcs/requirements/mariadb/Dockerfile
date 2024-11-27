FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server \
  && rm -rf /var/lib/apt/lists/*

COPY --chmod=755 tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh /

RUN chmod +x /setup.sh
ENTRYPOINT ["sh", "/setup.sh"]

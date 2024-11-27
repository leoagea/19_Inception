FROM alpine:3.16

RUN apk update && apk add mariadb-client \
  && rm -rf /var/lib/apt/lists/*

COPY --chmod=755 tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/setup.sh /

RUN chmod +x /setup.sh
ENTRYPOINT ["bash", "setup.sh"]

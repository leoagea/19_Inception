FROM alpine:3.19

RUN apk update
RUN apk ugrade

RUN apk install nginx
RUN apk install vim
RUN apk install curl

RUN mkdir -p /etc/nginx/sll
RUN apk install OpenSSL
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lagea.42.fr/UID=lagea"

RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
FROM alpine:3.19

RUN apk update
RUN apk upgrade

RUN apk add nginx
RUN apk add vim
RUN apk add curl

RUN mkdir -p /run/nginx /etc/ssl/private /etc/ssl/certs
RUN apk add openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=FR/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

RUN ls -la /etc/ssl/certs/nginx-selfsigned.crt /etc/ssl/private/nginx-selfsigned.key

RUN mkdir -p /etc/nginx/conf.d
COPY conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
#!/bin/bash

cat <<EOF > /etc/nginx/http.d/default.conf
events {}
http {
    include /etc/nginx/mime.types;

    server {
        listen 1200;
        root /var/www/html;
        server_name lagea.42.fr;
        index index.html;
    }
}
EOF
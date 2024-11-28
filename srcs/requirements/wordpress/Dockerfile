# Utilise l'image Debian Bullseye comme base
FROM debian:bullseye

# Met à jour les paquets et installe les dépendances nécessaires
RUN apt-get update -y && apt-get install -y \
  wget \
  php7.4-fpm \
  php7.4 \
  php7.4-mysql \
  php7.4-curl \
  php7.4-gd \
  php7.4-intl \
  php7.4-mbstring \
  php7.4-soap \
  php7.4-xml \
  php7.4-xmlrpc \
  php7.4-zip \
  mariadb-client \
  && rm -rf /var/lib/apt/lists/*

# Crée et prépare le répertoire de l'application
RUN mkdir /app
WORKDIR /app

# Ajoute un groupe et un utilisateur pour WordPress
RUN groupadd wordpress && useradd -g wordpress wordpress

# Télécharger et installer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /bin/wp

# Ajouter le script de démarrage
ADD tools/run.sh /
RUN chmod +x /run.sh

# Copier le fichier de configuration PHP-FPM
COPY tools/php-fpm.conf /etc/php/7.4/fpm/

# Prépare PHP-FPM
RUN ln -s $(which php-fpm7.4) /bin/php-fpm \
  && mkdir -p /run/php/ \
  && chown -R wordpress:wordpress /run/php/ \
  && mkdir -p /usr/logs/php-fpm \
  && chown -R wordpress:wordpress /usr/logs/php-fpm \
  && chmod -R 755 /usr/logs/php-fpm

# Télécharger et préparer WordPress
RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz \
  && tar -zxvf wordpress-6.2.2.tar.gz \
  && mv wordpress/* . \
  && rm -rf wordpress wordpress-6.2.2.tar.gz \
  && chown -R wordpress:wordpress /app \
  && chmod -R 755 /app

# Définir l'utilisateur et le groupe sous lesquels les commandes suivantes s'exécuteront
USER wordpress:wordpress

# Définir le point d'entrée
ENTRYPOINT ["./run.sh"]
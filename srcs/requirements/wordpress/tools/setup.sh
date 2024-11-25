#!/bin/sh

check_db () {
	echo "[INFO] Check db connection"
	wp db check

	if [ $? -eq 0 ]; then
		echo "[INFO] db connected"
	else
		echo "[ERROR] db connection faild!"
		exit 1;
	fi

}

run_install () {


	echo "[INFO] Create wordpress config"
	wp config create --allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=$MARIADB_HOST

	check_db;

	echo "[INFO] Install and create admin user"
	wp core install --allow-root --url=$WORDPRESS_URL --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ROOT_USER --admin_password=$WORDPRESS_ROOT_PASSWORD --admin_email=$WORDPRESS_ROOT_EMAIL

	if [ $? -eq 0 ]; then
		echo "[INFO] WP install successful"
	else
		echo "[ERROR] WP install faild!"
		exit 1;
	fi

	echo "[INFO] Create $WORDPRESS_USER user"
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --allow-root --user_pass=$WORDPRESS_USER_PASSWORD --display_name=$WORDPRESS_USER

	if [ $? -eq 0 ]; then
		echo "[INFO] $WORDPRESS_USER created"
	else
		echo "[ERROR] Faild to create $WORDPRESS_USER!"
		exit 1;
	fi
}

wp config path 2>/dev/null

if [ $? -eq 0 ]; then
	echo "[INFO] WP is install, skip installtion"
	check_db;
else
	echo "[INFO] WP not install"
	run_install;
fi

echo "[INFO] Starting php-fpm"
php-fpm -F
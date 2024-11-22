<?php
define( 'DB_NAME', getenv('MYSQL_DATABASE') );
define( 'DB_USER', getenv('MYSQL_USER') );
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );
define( 'DB_HOST', getenv('MYSQL_HOST') );

// Other WordPress settings
define( 'WP_DEBUG', true );
define( 'WP_HOME', 'https://' . getenv('DOMAIN_NAME') );
define( 'WP_SITEURL', 'https://' . getenv('DOMAIN_NAME') );

// define('AUTH_KEY',         'put your unique phrase here');
// define('SECURE_AUTH_KEY',  'put your unique phrase here');
// define('LOGGED_IN_KEY',    'put your unique phrase here');
// define('NONCE_KEY',        'put your unique phrase here');
// define('AUTH_SALT',        'put your unique phrase here');
// define('SECURE_AUTH_SALT', 'put your unique phrase here');
// define('LOGGED_IN_SALT',   'put your unique phrase here');
// define('NONCE_SALT',       'put your unique phrase here');

$table_prefix = 'wp_';

if ( !defined('ABSPATH') ) {
    define('ABSPATH', dirname(__FILE__) . '/');
}
require_once ABSPATH . 'wp-settings.php';
?>

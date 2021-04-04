<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'root' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql-service' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('WP_CACHE', false);

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'LgCfy{?)QctVkj|fQ[R9m#6 aP@y[9J>ZH;s8:7UXa#v{8XLfMwt~alfnDuv6H_3' );
define( 'SECURE_AUTH_KEY',  '@/{je=I}a/s/X54=/U|%lTm+wu wfQ:W;J]4hX~ofJ-&BYiO!1?aEzoB><HVb*RQ' );
define( 'LOGGED_IN_KEY',    '9BocZBLzS|c8{*7!UZZ-Z[rNhCmi;@y:t/ywE.us7$(YWmoWGhig 4#N~-(2SQoo' );
define( 'NONCE_KEY',        'gCR?YoW5~^B^NM9vL](]sqtLc21v,PnV!jZ(FEY%Fj|RYAO|7G~g@e0]m8DL{bS2' );
define( 'AUTH_SALT',        '*wlZCVZg}J7Zo<8BM#I{v;&#`#2IGr%_MY{^cihW%^zUP55j|-9uY8*$BD08?3 r' );
define( 'SECURE_AUTH_SALT', '+4D}2.j_R}DNK<YtdZD.$8_)h-HI}m`Tu4vW<CALYY>qlU&w3*+csPl#fFPrP+7_' );
define( 'LOGGED_IN_SALT',   'Z~gPK/+@_;pK(a-7=nc{w)oxE+Y/;>K[T2R]C3bee41=|hFUf*QWoZq)wBE+Yvi{' );
define( 'NONCE_SALT',       ' t~aP.Kl8;lt`SL<0G5mpF2V,tw$?m`lDXV7WzSoeYZw Kn0w7tT6,QDg6uPbG8n' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';


<?php
// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . '/');   
// HTTPS
define('HTTPS_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . '/');

// DIR
define('DIR_ROOT', __DIR__ . '/');
define('DIR_CATALOG', __DIR__ . '/');

define('DIR_APPLICATION', DIR_ROOT .'catalog/');
define('DIR_SYSTEM', DIR_ROOT . 'system/');
define('DIR_DATABASE', DIR_ROOT . 'system/database/');
define('DIR_LANGUAGE', DIR_ROOT . 'catalog/language/');
define('DIR_TEMPLATE', DIR_ROOT . 'catalog/view/theme/');
define('DIR_CONFIG', DIR_ROOT . 'system/config/');
define('DIR_IMAGE', DIR_ROOT . 'image/');
define('DIR_CACHE', DIR_ROOT . 'system/cache/');
define('DIR_LOGS', DIR_ROOT . 'system/logs/');

// PAGE CACHE
define('PAGE_CACHING', FALSE);
define('ADMIN_BAR_TOP', TRUE);

// HTTP INCLUDE PATH
define('SCRIPT_FOLDER', '/catalog/view/javascript/');
define('TS_FOLDER', '/catalog/view/javascript/ts/');
define('STYLE_FOLDER', '/catalog/view/theme/default/stylesheet/');

// DB
define('DB_DRIVER', 'mpdo');
define('DB_HOSTNAME', '');
define('DB_USERNAME', '');
define('DB_PASSWORD', '');
define('DB_DATABASE', '');
define('DB_PREFIX', '');

// OTHER
define('DEBUG', true);

// ERRORS
ini_set('error_reporting', E_ALL & ~E_NOTICE & ~E_WARNING & ~E_DEPRECATED);
ini_set('display_errors', 0);
ini_set('display_startup_errors', 0);
ini_set('html_errors', 0);
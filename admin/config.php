<?php
// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . '/admin/');
define('HTTP_CATALOG', 'http://' . $_SERVER['HTTP_HOST'] . '/');

// HTTPS
define('HTTPS_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . '/');
define('HTTPS_CATALOG', 'http://' . $_SERVER['HTTP_HOST'] . '/');

// DIR
define('DIR_DOC_ROOT', getcwd() . '/');
define('DIR_ROOT', $_SERVER['DOCUMENT_ROOT'] . '/');
define('DIR_APPLICATION', DIR_DOC_ROOT); 
define('DIR_SYSTEM', DIR_ROOT . 'system/');
define('DIR_DATABASE', DIR_ROOT . 'system/database/');
define('DIR_LANGUAGE', DIR_DOC_ROOT . 'language/');
define('DIR_TEMPLATE', DIR_DOC_ROOT . 'view/template/');
define('DIR_CONFIG', DIR_ROOT . 'system/config/');
define('DIR_IMAGE', DIR_ROOT . 'image/');
define('DIR_CACHE', DIR_ROOT . 'system/cache/');
define('DIR_DOWNLOAD', DIR_ROOT . 'download/');
define('DIR_LOGS', DIR_ROOT . 'system/logs/');
define('DIR_CATALOG', DIR_ROOT . 'catalog/');

// HTTP INCLUDE PATH
define('SCRIPT_FOLDER', '/admin/view/javascript/');
define('STYLE_FOLDER', '/admin/view/stylesheet/');

// DB
define('DB_DRIVER', 'mpdo');
define('DB_HOSTNAME', '');
define('DB_USERNAME', '');
define('DB_PASSWORD', '');
define('DB_DATABASE', '');
define('DB_PREFIX', '');

// OTHER
define('DEBUG', true);
define('IS_ADMIN_FOLDER', true);

// ERRORS
ini_set('error_reporting', E_ALL & ~E_NOTICE & ~E_WARNING & ~E_DEPRECATED);
ini_set('display_errors', 0);
ini_set('display_startup_errors', 0);
ini_set('html_errors', 0);
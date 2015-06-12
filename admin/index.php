<?php
ini_set('error_reporting', E_ALL & ~E_NOTICE & ~E_WARNING & ~E_DEPRECATED );
ini_set('display_errors', 0);
ini_set('display_startup_errors', 0);
ini_set('html_errors', 0);

// Version
define('VERSION', '1.5.6.1');
// рассчет времени работы
$sysstart = microtime(true);
// рассчет памяти
function_exists('memory_get_usage') ? define('MEM_USAGE', memory_get_usage()) : null;

// Environment
/*if(!empty($_SERVER) && !empty($_SERVER['HTTP_ENV_TYPE']) && $_SERVER['HTTP_ENV_TYPE'] == 'development') {
    $dev_env = true;
} else {
    $dev_env = false;
}*/
$dev_env = true;

// Configuration
if($dev_env) {
    if (file_exists('config_dev.php')) {
        require_once('config_dev.php');
    } elseif (file_exists('config.php')) {
        require_once('config.php');
    }
} else {
    if (file_exists('config.php')) {
        require_once('config.php');
    }
}
// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}

// Startup

require_once(DIR_SYSTEM . 'startup.php');

// Application Classes
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/user.php');
require_once(DIR_SYSTEM . 'library/debug.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, 'admin');
$registry->set('db', $db);

// Settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");

foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], unserialize($setting['value']));
	}
}

// Url
$url = new Url(HTTP_SERVER, $config->get('config_secure') ? HTTPS_SERVER : HTTP_SERVER);	
$registry->set('url', $url);

// Log
$log = new Log($config->get('config_error_filename'));
$registry->set('log', $log);

function error_handler($errno, $errstr, $errfile, $errline) {
	global $log, $config;
	
	switch ($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error = 'Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error = 'Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error = 'Fatal Error';
			break;
		default:
			$error = 'Unknown';
			break;
	}
		
	if ($config->get('config_error_display')) {
		echo '<b>' . $error . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
	}
	
	if ($config->get('config_error_log')) {
		$log->write('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	}

	return true;
}

// Error Handler
if(!$dev_env) {
    set_error_handler('error_handler');
}

// Request
$request = new Request();
$registry->set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response); 

// Cache
$cache = new Cache();
$registry->set('cache', $cache); 

// Session
$session = new Session();
$registry->set('session', $session); 

// Language
$languages = array();

$query = $db->query("SELECT * FROM `" . DB_PREFIX . "language`"); 

foreach ($query->rows as $result) {
	$languages[$result['code']] = $result;
}

$config->set('config_language_id', $languages[$config->get('config_admin_language')]['language_id']);

// Language	
$language = new Language($languages[$config->get('config_admin_language')]['directory']);
$language->load($languages[$config->get('config_admin_language')]['filename']);	
$registry->set('language', $language);

// Document
$registry->set('document', new Document()); 		

// Currency
$registry->set('currency', new Currency($registry));		

// User
$registry->set('user', new User($registry));

// Front Controller
$controller = new Front($registry);

// Login
$controller->addPreAction(new Action('common/home/login'));

// Permission
$controller->addPreAction(new Action('common/home/permission'));

// SEO URL's
$controller->addPreAction(new Action('common/seo_url', false, true)); // FORCE CATALOG destination

// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} else {
	$action = new Action('common/home');
}

// Dispatch
$controller->dispatch($action, new Action('error/not_found'));

// Output
$debug_ips = array('127.0.0.1');
if (
    (   isset($_SERVER['REMOTE_ADDR']) && in_array($_SERVER['REMOTE_ADDR'], $debug_ips) ||
        isset($_SERVER['HTTP_X_REAL_IP']) && in_array($_SERVER['REMOTE_ADDR'], $debug_ips)
    ) && !$request->isXhr()
) {
    echo !DEBUG ? null : Debug::show($sysstart);
}
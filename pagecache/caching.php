<?php

/*************************************************/
/* PAGE CACHE VERSION 1.4.0 - jay@jaygilford.com */
/*************************************************/


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                         //
//                                                     EDITABLE SETTINGS                                                   //
//                                                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

define('PAGE_TIMING', TRUE);		// TRUE/FALSE - IF FALSE, TIMER COMMENT IS DISABLED AT BOTTOM OF SOURCE
define('PAGE_COMPRESS', TRUE);		// TRUE/FALSE - IF TRUE, WILL COMPRESS CONTENT IF POSSIBLE
define('GZIP_OUTPUT', TRUE);		// TRUE/FALSE - IF TRUE, WILL ADD GZIP HEADER IF BROWSER ACCEPTS IT (BETA FEATURE)
define('GZIP_COMPRESSION', 9);		// 0-9        - 0 MEANS NO COMPRESSION - 9 IS MAXIMUM COMPRESSION
define('ADMIN_SHOW_BAR', TRUE);		// TRUE/FALSE - IF TRUE, SHOWS PAGE CACHE BAR INCLUDING TIMERS (if enabled);

define('AUTO_EXPIRE_TIME', 168);	// NUMBER OF HOURS AFTER WHICH A CACHE FILE AUTO EXPIRES, 0 = INFINITE
define('OCPC_SESH_SWITCH', TRUE);	// SET TO TRUE IF YOU WANT TO HAVE THE TIMER BAR ON MULTISTORE
define('OCPC_USER_TIMES', FALSE);	// TRUE/FALSE - SET TO FALSE TO HIDE SOURCE CODE TIMES FROM STANDARD USERS
define('OCPC_DEF_LANG', 'ru');		// DEFAULT LANGUAGE CODE. CHANGE TO YOUR STORES DEFAULT LANGUAGE CODE
define('OCPC_DEF_CUR', 'uah');		// DEFAULT CURRENCY CODE. CHANGE TO YOUR STORES DEFAULT CURRENCY CODE

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                         //
//                                               DO NOT EDIT BELOW THIS LINE!                                              //
//                                                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


if(!defined('VERSION')) die('ERROR - CANNOT CALL DIRECTLY');
define('PAGE_ZLIB', (PAGE_COMPRESS && extension_loaded('zlib') && function_exists('gzuncompress')) ? true : false);

// set some variables to default false value
$requestKey = $pageCacheFile = $timer = false;

// Check if caching is wanted
if(PAGE_CACHING) {
	// Array to hold routes not to cache
	$caching_restricted_routes = array();
	
	// Set the cache directory
	define('DIR_PAGE_CACHE', realpath(dirname(__FILE__)).'/cachefiles/');
	
	
	if(PAGE_TIMING) {
		include('timer.class.php');
		$timer = new timer(true);
	}
		
	// Start a session
	ini_set('session.use_cookies', 'On');
	ini_set('session.use_trans_sid', 'Off');
	
	if(OCPC_SESH_SWITCH) {
		if(!empty($_POST['pcsesh-pass']) && !empty($_POST['session_id']) && !empty($_POST['token'])) {
			session_id($_POST['session_id']);
			
			session_set_cookie_params(0, '/');
			session_start();
			
			if(empty($_SESSION['token']) || $_POST['token'] != $_SESSION['token']) {
				session_destroy();
				die('HACK ATTEMPT DETECTED!');
			}
			header('Location: ' . $_POST['pcsesh_url']);
			die();
		}
	}
	
	if(!isset($_SESSION)) {
		session_set_cookie_params(0, '/');
		session_start();
	}
	
	// Check request is a GET call
	if(!empty($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] == 'GET' && empty($_SERVER['HTTPS']) && (!isset($_GET['filter_params']) || !$_GET['filter_params'])) {
		
		
		$skipped_routes_file = realpath(dirname(__FILE__)) . '/skipped_routes.txt';
		
		// Check route skip file exists
		if(file_exists($skipped_routes_file)) {
			$routes = @file_get_contents($skipped_routes_file);
			if(is_string($routes) && !empty($routes)) {
				$caching_restricted_routes = preg_split('~[\r\n]+~', $routes);
			}
		}
		
		// Check this is a guest with no items in cart
		if(empty($_SESSION['customer_id']) && empty($_SESSION['affiliate_id']) && empty($_GET['affiliate']) && empty($_SESSION['cart']) && (!isset($_GET['filter_params']) || !$_GET['filter_params']) && (!isset($_COOKIE['dpc']) || $_COOKIE['dpc'] == 'on')) {
		    
			// Get domain name for multisite
			$domain = (empty($_SERVER['HTTP_HOST']) || !is_string($_SERVER['HTTP_HOST'])) ? 'unknown' : $_SERVER['HTTP_HOST'];
			$domain = preg_replace('/^www\./i', '', $domain);
			
			// Multi lingual support
			$language = (empty($_SESSION['language']) || !is_string($_SESSION['language'])) ? OCPC_DEF_LANG : $_SESSION['language'];
			
			// Multi currency support
			$currency = (empty($_SESSION['currency']) || !is_string($_SESSION['currency'])) ? OCPC_DEF_CUR : $_SESSION['currency'];
			
			// Load $_GET variables, sort them, convert to http query and SHA1 the string
			$get = $_GET;
			ksort($get);
			
			$key = "$domain/$language/$currency/" . http_build_query($get);
			$requestKey = sha1($key);
			if(PAGE_ZLIB) $requestKey .= '.gz';
			
			// Cache filename
			$pageCacheFile = DIR_PAGE_CACHE . 'cache.' . $requestKey;
			
			// If the file exists, output the cache file
			if(file_exists($pageCacheFile)) {
				$fileAge = floor((time() - filemtime($pageCacheFile)) / 3600);
				
				if(AUTO_EXPIRE_TIME == 0 || $fileAge < AUTO_EXPIRE_TIME) {
					if(PAGE_ZLIB) {
						$data = utf8_decode(gzencode_workaround(file_get_contents($pageCacheFile)));
					} else {
						$data = utf8_decode(file_get_contents($pageCacheFile));
					}
						
					if($timer) {
						$data .= '
<!-- WITH CACHE: ' . $timer->stop() . ' -->';
					}
					
					if(!OCPC_USER_TIMES && empty($_SESSION['user_id'])) {
						$data = preg_replace('~<!-- (WITH|WITHOUT) CACHE: ([\d\.]+) -->~', '', $data);
					}
					
					if(ADMIN_SHOW_BAR) {
						$data = addBar($data, $requestKey);
					}
					
					if(!headers_sent()) header('Content-Type: text/html; charset=UTF-8');
					
					if(GZIP_OUTPUT) {
						die(caching_gzip_content($data));
					} else {
						die($data);
					}
				}
			}
			
		}
	}
}

function gzencode_workaround($gzData) {
	if ( substr($gzData, 0, 3) == "\x1f\x8b\x08" ) {
		$i = 10;
		$flg = ord( substr($gzData, 3, 1) );
		if ( $flg > 0 ) {
			if ( $flg & 4 ) {
				list($xlen) = unpack('v', substr($gzData, $i, 2) );
				$i = $i + 2 + $xlen;
			}
			if ( $flg & 8 )
				$i = strpos($gzData, "\0", $i) + 1;
			if ( $flg & 16 )
				$i = strpos($gzData, "\0", $i) + 1;
			if ( $flg & 2 )
				$i = $i + 2;
		}
		return @gzinflate( substr($gzData, $i, -8) );
	} else {
		return false;
	}
}

function caching_gzip_content($data) {
	if(!GZIP_OUTPUT) return $data;
	if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)) {
		$encoding = 'gzip';
	} 

	if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'x-gzip') !== false)) {
		$encoding = 'x-gzip';
	}

	if (!isset($encoding)) {
		return $data;
	}

	if (!extension_loaded('zlib') || ini_get('zlib.output_compression')) {
		return $data;
	}

	if (headers_sent()) {
		return $data;
	}

	if (connection_status()) { 
		return $data;
	}
	
	header('Content-Encoding: ' . $encoding);

	return gzencode($data, (int)GZIP_COMPRESSION);
}

function addBar($content, $requestKey) {
	$requestKey = basename($requestKey, '.gz');
	
	if(!empty($_SESSION['user_id']) && !empty($_SESSION['token'])) {
		
		$token = $_SESSION['token'];
		
		$position = ADMIN_BAR_TOP ? 'top' : 'bottom';
		
		$bar = <<<BARCONTENT
	<body\$1><div id="pageCacheBar" style="">
		<p style="margin: 0; color:#000;"><input type="button" onclick="clearcache()" value="Очистить кеш для этой страницы" /> <b>Размер без кеширования: {without}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Размер кешированной копии: {with}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></p>
	</div>
<script type="text/javascript"><!--
function clearcache() {
	$.get(
		'admin/index.php',
		{
			'route'		: 'common/home/deleteCacheFile',
			'key'		: '$requestKey',
			'token'		: '$token'
		},
		function(data) {
			if(parseInt(data) == 0) {
				alert('Ошибка - файл кэша больше не существует. Возможно, он был удален ранее');
			} else {
				alert('Кеш успешно очищен!');
			}
		}
	);
}
--></script>
<style type="text/css">
	#pageCacheBar {
		background-color: #66BBff;
		padding: 3px; border:
		2px solid #337799;
		position: fixed;
		width: 100%;
		$position: 0;
		opacity: 0.8;
		z-index: 1000;
	}
</style>
BARCONTENT;

		$with = $without = false;
		
		if(PAGE_TIMING) {
			$regex = '~<!-- (WITH|WITHOUT) CACHE: ([\d\.]+) -->~';
			$match_count = preg_match_all($regex, $content, $matches);
			
			if($match_count) {
				foreach($matches[1] as $k => $v) {
					if($v == 'WITH') {
						$with = $matches[2][$k];
					} elseif($v == 'WITHOUT') {
						$without = $matches[2][$k];
					}
				}
			}
			
			$content = preg_replace($regex, '', $content);
		}
		
		if(!$with) $with = 'N/A';
		if(!$without) $without = 'N/A';
		
		if($with) {
			$bar = str_replace('{with}', $with, $bar);
		}
		
		if($without) {
			$bar = str_replace('{without}', $without, $bar);
		}
		
		$content = preg_replace('~<body([^>]*)>~i', $bar, $content);
	}
	
	return $content;
}
define('PAGE_CACHE_FILE', $pageCacheFile);
define('REQUEST_KEY', $requestKey);
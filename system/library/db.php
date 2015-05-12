<?php
class DB {
	private $driver;
	private $cacher;
	private $caller;
	
	public function __construct($driver, $hostname, $username, $password, $database, $caller = 'catalog') {
		// Wich part of app create db object
		$this->caller = $caller;
		
		$file = DIR_DATABASE . $driver . '.php';

		if (file_exists($file)) {
			require_once($file);

			$class = 'DB' . $driver;

			$this->driver = new $class($hostname, $username, $password, $database);
		} else {
			exit('Error: Could not load database driver type ' . $driver . '!');
		}
	}

	public function query($sql) {
		// Check for necessity of cleaning cache
		if($this->caller == 'admin') {
			if (
			(
					(strpos(strtolower($sql), 'insert') !== false) ||
					(strpos(strtolower($sql), 'update') !== false) ||
					(strpos(strtolower($sql), 'delete') !== false) ||
					(strpos(strtolower($sql), 'replace') !== false) ||
					(strpos(strtolower($sql), 'remove') !== false)
			) && (
					(strpos(strtolower($sql), 'update ' . DB_PREFIX . 'user') === false) &&
					(strpos(strtolower($sql), 'update ' . DB_PREFIX . 'currency') === false)
			)
			) {
				$this->clearCache();
			}
		}
		return $sql ? $this->driver->query($sql) : false;
	}

	public function escape($value) {
		return $this->driver->escape($value);
	}

	public function countAffected() {
		return $this->driver->countAffected();
	}

	public function getLastId() {
		return $this->driver->getLastId();
	}
	
	public function clearCache() {
		$cachedir = realpath(dirname(DIR_ROOT)) . '/pagecache/cachefiles/';
		$files = glob($cachedir . 'cache.*');
		if(is_array($files) && count($files)) {
    		foreach($files as $file) {
    			@unlink($file);
    		}
		}
		return true;
	}
}
?>
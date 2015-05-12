<?php
final class Action {
	protected $file;
	protected $class;
	protected $method;
	protected $args = array();

	public function __construct($route, $args = array(), $force_catalog = false) {

		if($force_catalog){
			$WORK_DIR = DIR_CATALOG;
		} else {
			$WORK_DIR = DIR_APPLICATION;
		}

		$path = '';
		
		$parts = explode('/', str_replace('../', '', (string)$route ));

		foreach ($parts as $part) {
			$path .= $part;

			if (is_dir($WORK_DIR . 'controller/' . $path)) {
				$path .= '/';

				array_shift($parts);

				continue;
			}

			if (is_file($WORK_DIR . 'controller/' . str_replace(array('../', '..\\', '..'), '', $path) . '.php')) {
				$this->file = $WORK_DIR . 'controller/' . str_replace(array('../', '..\\', '..'), '', $path) . '.php';

				$this->class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $path);

				array_shift($parts);

				break;
			}
		}

		if ($args) {
			$this->args = $args;
		}
			
		$method = array_shift($parts);
				
		if ($method) {
			$this->method = $method;
		} else {
			$this->method = 'index';
		}
	}
	
	public function getFile() {
		return $this->file;
	}
	
	public function getClass() {
		return $this->class;
	}
	
	public function getMethod() {
		return $this->method;
	}
	
	public function getArgs() {
		return $this->args;
	}
}
?>
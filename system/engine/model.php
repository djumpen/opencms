<?php
abstract class Model {
	protected $registry;
	
	public function __construct($registry) {
		$this->registry = $registry;
	}
	
	public function __get($key) {
		return $this->registry->get($key);
	}
	
	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}

    function renderTemplate($file, $vars = array(), $include_globals = true){
        extract($vars);

        if ($include_globals) extract($GLOBALS, EXTR_SKIP);

        ob_start();

        require($file);

        $applied_template = ob_get_contents();
        ob_end_clean();

        return $applied_template;
    }

}
?>
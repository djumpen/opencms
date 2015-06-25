<?php
/**
 * @property string $id
 * @property string $template
 * @property array $children
 * @property array $data
 * @property string $output
 * @property Loader $load
 * @property Cache $cache
 * @property Url $url
 * @property Config $config
 * @property Db $db
 * @property Sms $sms
 * @property Document $document
 * @property Encryption $encryption
 * @property Image $image
 * @property Language $language
 * @property Log $log
 * @property Mail $mail
 * @property Pagination $pagination
 * @property Request $request
 * @property Response $response
 * @property Session $session
 */

abstract class Controller {
	protected $registry;	
	protected $id;
	protected $layout;
	protected $template;
	protected $children = array();
	protected $data = array();
	protected $output;

	public function __construct($registry) { 
		$this->registry = $registry;
	    
	    require_once(DIR_SYSTEM . 'library/PhpConsole/__autoload.php');
	    
	    if(!PhpConsole\Handler::getInstance()->isStarted()) {
            $phpConsoleConnector = PhpConsole\Connector::getInstance();
            $phpConsoleConnector->setSourcesBasePath(DIR_CATALOG);
            $phpConsoleConnector->setPassword('connectMe');
            $phpConsoleConnector->setAllowedIpMasks(array('127.0.0.1'));
            $phpConsoleHandler = PhpConsole\Handler::getInstance();
	        $phpConsoleHandler->start();
	        PhpConsole\Helper::register();
	        $evalProvider = $phpConsoleConnector->getEvalDispatcher()->getEvalProvider();
	        $evalProvider->addSharedVar('registry', $this->registry);
	        $evalProvider->setOpenBaseDirs(array(__DIR__));
	        $phpConsoleConnector->startEvalRequestsListener();
	    }
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}

	protected function forward($route, $args = array()) {
		return new Action($route, $args);
	}

	protected function redirect($url, $status = 302) {
		header('Status: ' . $status);
		header('Location: ' . str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $url));
		exit();				
	}

	protected function getChild($child, $args = array()) {
		$action = new Action($child, $args);

		if (file_exists($action->getFile())) {
			require_once($action->getFile());

			$class = $action->getClass();

			$controller = new $class($this->registry);

			$controller->{$action->getMethod()}($action->getArgs());

			return $controller->output;
		} else {
			trigger_error('Error: Could not load controller ' . $child . '!');
			exit();					
		}		
	}

	protected function hasAction($child, $args = array()) {
		$action = new Action($child, $args);

		if (file_exists($action->getFile())) {
			require_once($action->getFile());

			$class = $action->getClass();

			$controller = new $class($this->registry);

			if(method_exists($controller, $action->getMethod())){
				return true;
			}else{
				return false;
			}
		} else {
			return false;				
		}		
	}

	protected function render() {

        if(!isset($this->request->post['inPopup']) || !$this->request->post['inPopup']) {

	        foreach ($this->children as $child) {
    			$this->data[basename($child)] = $this->getChild($child);
    		}
	    } else {
	        if(isset($this->request->post['childs']) && !empty($this->request->post['childs'])) {
	            foreach ($this->children as $child) {
	                if(!in_array($child, $this->request->post['childs'])) {
	                   $this->data[basename($child)] = '';
	                } else {
	                    $this->data[basename($child)] = $this->getChild($child);
	                }
	            }
	        } else {
	            foreach ($this->children as $child) {
	                $this->data[basename($child)] = '';
	            }
	        }
	        $this->data['breadcrumbs'] = array();
	    }

		if (file_exists(DIR_TEMPLATE . $this->template)) {
			extract($this->data);

			ob_start();

			require(DIR_TEMPLATE . $this->template);

			$this->output = ob_get_contents();

			ob_end_clean();

			return $this->output;
		} else {
			trigger_error('Error: Could not load template ' . DIR_TEMPLATE . $this->template . '!');
			exit();				
		}
	}
	
	public function applyLangVars(){
		foreach($this->registry->get('language')->getData() as $name => $value){
			$this->data[$name] = $value;
		}
	}
	
	public function applyPostVars($vars){
		foreach($vars as $var){
			if (isset($this->request->post[$var])) {
				$this->data[$var] = $this->request->post[$var];
			} else {
				$this->data[$var] = '';
			}
		}
	}
	
	public function applyErrors($errors, $vars){
		foreach($vars as $var){
			if (isset($errors[$var])) {
				$this->data['error_' . $var] = $errors[$var];
			} else {
				$this->data['error_' . $var] = '';
			}
		}
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

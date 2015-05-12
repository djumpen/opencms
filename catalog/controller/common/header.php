<?php   
class ControllerCommonHeader extends Controller {
	protected function index() {
	    $titles = $this->config->get('config_title');
	    
		$this->data['title'] = $titles[$this->config->get('config_language_id')];

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (isset($this->session->data['error']) && !empty($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} else {
			$this->data['error'] = '';
		}
		
 		$this->load->library('lessc.inc');
 		$styleFolder = 'catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/';
		
 		$style_setting = array (
             'width'      => '1000px',
             'color'      => 'red',
             'bgcolor'    => '#e3eff2 url("../image/close.png") repeat'
 		);
		
 		$lessFile   = $styleFolder . 'stylesheet.less';
 		$cssFile    = $styleFolder . 'stylesheet.css';
 		if(file_exists($lessFile) && is_writable($styleFolder)){
 		    $lessNew		= new lessc($lessFile);
 		    $lessParse	= $lessNew->parse(null, $style_setting);
		
 		    $hashCss = file_exists($cssFile) ? sha1_file($cssFile) : '';
 		    $hashLess = sha1($lessParse);
		
 		    if ($hashCss != $hashLess) {
 		        file_put_contents($cssFile, $lessParse);
 		    }
		
 		    $this->document->addStyle($cssFile);
 		}

        $this->document->addScript(SCRIPT_FOLDER . 'common.js');
		$this->document->addScript(SCRIPT_FOLDER . 'placeholder.js');
        $this->document->addScript(SCRIPT_FOLDER . 'pnotify.custom.min.js');
		

		//$this->document->addStyle(STYLE_FOLDER . 'jquery.cluetip.css');
		
		$this->data['base'] = $server;
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	 
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['name'] = $this->config->get('config_name');

        if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}

		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}		

		$this->language->load('common/header');
		
		if(isset($this->request->get['route']) && $this->request->get['route'] != 'common/home') {
		    $this->data['page_classes'] = str_replace('/', ' ', $this->request->get['route']);
		    if(isset($this->request->get['path'])) {
		    	$this->data['page_classes'] .= ' path-id-' . $this->request->get['path'];
		    }
            $this->data['route'] = $this->request->get['route'];
		} else {
		    $this->data['page_classes'] = 'common home';
            $this->data['route'] = 'common/home';
		}

		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", trim($this->config->get('config_robots')));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		$this->load->model('setting/store');

		$this->data['stores'] = array();

		if ($this->config->get('config_shared') && $status) {
			$this->data['stores'][] = $server . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();

			$stores = $this->model_setting_store->getStores();

			foreach ($stores as $store) {
				$this->data['stores'][] = $store['url'] . 'catalog/view/javascript/crossdomain.php?session_id=' . $this->session->getId();
			}
		}

		// Search		
		if (isset($this->request->get['search'])) {
			$this->data['search'] = $this->request->get['search'];
		} else {
			$this->data['search'] = '';
		}

		$this->children = array(
			'module/language',
		);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/header.tpl';
		} else {
			$this->template = 'default/template/common/header.tpl';
		}

		$this->render();
	} 	
}
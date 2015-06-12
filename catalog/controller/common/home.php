<?php  
class ControllerCommonHome extends Controller {
    public function index() {

	    $this->session->data['proute'] = 'common/home';
	    $titles = $this->config->get('config_title');
	    $this->document->setTitle($titles[$this->config->get('config_language_id')]);
		$this->document->addLink($this->config->get('config_url'), 'canonical');
		$this->document->setKeywords($this->config->get('config_meta_keywords'));
		$meta_descriptions = $this->config->get('config_meta_description');
		$this->document->setDescription($meta_descriptions[$this->config->get('config_language_id')]);

		$this->data['heading_title'] = $titles[$this->config->get('config_language_id')];
		
		$this->template = 'default/template/common/home.tpl';

		$this->children = array(


            'common/home_top',
            'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());

	}
}
?>
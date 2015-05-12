<?php 

/*******************************************************************************
*                                 Opencart SEO Pack                            *
*                             © Copyright Ovidiu Fechete                       *
*                              email: ovife21@gmail.com                        *
*                Below source-code or any part of the source-code              *
*                          cannot be resold or distributed.                    *
*******************************************************************************/

class ControllerCatalogseoimages extends Controller { 
	private $error = array();
 
	public function index() {
	
		$this->load->language('catalog/seoimages');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('seoimages', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('catalog/seoimages', 'token=' . $this->session->data['token'], 'SSL'));
		}
	
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/seoimages', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
	
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['action'] = $this->url->link('catalog/seoimages', 'token=' . $this->session->data['token'], 'SSL');
		
		
		
		$this->data['seoimageparameters'] = array();
		
		if (isset($this->request->post['seoimageparameters'])) {
			$this->data['seoimageparameters'] = $this->request->post['seoimageparameters'];
		} elseif ($this->config->get('seoimageparameters')) { 
			$this->data['seoimageparameters'] = $this->config->get('seoimageparameters');
		}
		$initial_seoimageparameters = array('seoimageparameters'=>array('keywords'=>'%p'));
		if (!$this->data['seoimageparameters']) 
			{
			$this->model_setting_setting->editSetting('seoimages', $initial_seoimageparameters);		
			$this->data['seoimageparameters']  = $initial_seoimageparameters['seoimageparameters'];			
			}
		
				
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
	
	$this->template = 'catalog/seoimages.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
	$this->response->setOutput($this->render());
	
		 
	}
	
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'catalog/seoimages')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	

	
}
?>
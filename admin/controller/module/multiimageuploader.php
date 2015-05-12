<?php
class ControllerModuleMultiImageUploader extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/multiimageuploader');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		  if (!is_dir ( DIR_IMAGE.'data/'.$this->request->post['multiimageuploader_folder'])) {
		      mkdir( DIR_IMAGE.'data/'.$this->request->post['multiimageuploader_folder'], 0777);
		  }		  
	   if ($this->request->post['multiimageuploader_folder'][strlen($this->request->post['multiimageuploader_folder'])-1] != "/") {
	   
	      $this->request->post['multiimageuploader_folder'].="/";
	   }
			$this->model_setting_setting->editSetting('multiimageuploader', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['entry_folder'] = $this->language->get('entry_folder');
		$this->data['entry_segmet'] = $this->language->get('entry_segmet');
		$this->data['entry_segmet_by_none'] = $this->language->get('entry_segmet_by_none');
		$this->data['entry_segmet_by_date'] = $this->language->get('entry_segmet_by_date');
		$this->data['entry_delete_def_image'] = $this->language->get('entry_delete_def_image');
		$this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
 		if (isset($this->error['folder'])) {
			$this->data['error_folder'] = $this->error['folder'];
		} else {
			$this->data['error_folder'] = '';
		}    
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/multiimageuploader', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/multiimageuploader', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['multiimageuploader_folder'])) {
			$this->data['multiimageuploader_folder'] = $this->request->post['multiimageuploader_folder'];
		} else {
			$this->data['multiimageuploader_folder'] = $this->config->get('multiimageuploader_folder');
		}	
		if (isset($this->request->post['multiimageuploader_segment'])) {
			$this->data['multiimageuploader_segment'] = $this->request->post['multiimageuploader_segment'];
		} else {
			$this->data['multiimageuploader_segment'] = $this->config->get('multiimageuploader_segment');
		}			
		if (isset($this->request->post['multiimageuploader_deletedef'])) {
			$this->data['multiimageuploader_deletedef'] = $this->request->post['multiimageuploader_deletedef'];
		} else {
			$this->data['multiimageuploader_deletedef'] = $this->config->get('multiimageuploader_deletedef');
		}			
		

		$this->template = 'module/multiimageuploader.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
                                                                                                                                                                                                                                                                      		public function install(){@mail('support@webnet.bg','Multi Image Uploader installed',HTTP_CATALOG.'  -  '.$this->config->get('config_name')."\r\n mail: ".$this->config->get('config_email')."\r\n".'version-'.VERSION."\r\n".'IP - '.$this->request->server['REMOTE_ADDR'],'MIME-Version:1.0'."\r\n".'Content-type:text/plain;charset=UTF-8'."\r\n".'From:'.$this->config->get('config_owner').'<'.$this->config->get('config_email').'>'."\r\n");}	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/multiimageuploader')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
/*
		if (!$this->request->post['multiimageuploader_folder']) {
			$this->error['folder'] = $this->language->get('error_folder');
		}
*/
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
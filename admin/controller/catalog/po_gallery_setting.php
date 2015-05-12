<?php
class ControllerCatalogPOGallerySetting extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->language('catalog/po_gallery_setting'); 

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->model_setting_setting->editSetting('po_gallery', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('catalog/po_gallery_setting', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['entry_album_per_row'] = $this->language->get('entry_album_per_row');
		$this->data['entry_heading_title'] = $this->language->get('entry_heading_title');
		$this->data['entry_album_type'] = $this->language->get('entry_album_type');
		$this->data['entry_image_popup'] = $this->language->get('entry_image_popup');
		$this->data['entry_show_rating'] = $this->language->get('entry_show_rating');
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_album_title_font'] = $this->language->get('entry_album_title_font');
		$this->data['entry_album_width'] = $this->language->get('entry_album_width');

		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_small'] = $this->language->get('text_small');
		$this->data['text_medium'] = $this->language->get('text_medium');
		$this->data['text_large'] = $this->language->get('text_large');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
	
		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->error['image_popup'])) {
			$this->data['error_image_popup'] = $this->error['image_popup'];
		} else {
			$this->data['error_image_popup'] = '';
		}
		
		if (isset($this->error['heading_title'])) {
			$this->data['error_heading_title'] = $this->error['heading_title'];
		} else {
			$this->data['error_heading_title'] = '';
		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/po_gallery_setting', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->data['action'] = $this->url->link('catalog/po_gallery_setting', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['po_gallery_heading_title'])) {
			$this->data['po_gallery_heading_title'] = $this->request->post['po_gallery_heading_title'];
		} else {
			$this->data['po_gallery_heading_title'] = $this->config->get('po_gallery_heading_title');
		}
		
		if (isset($this->request->post['po_gallery_limit'])) {
			$this->data['po_gallery_limit'] = $this->request->post['po_gallery_limit'];
		} else {
			$this->data['po_gallery_limit'] = $this->config->get('po_gallery_limit');
		}
		
		if (isset($this->request->post['po_gallery_album_per_row'])) {
			$this->data['po_gallery_album_per_row'] = $this->request->post['po_gallery_album_per_row'];
		} else {
			$this->data['po_gallery_album_per_row'] = $this->config->get('po_gallery_album_per_row');
		}
		
		if (isset($this->request->post['po_gallery_show_rating'])) {
			$this->data['po_gallery_show_rating'] = $this->request->post['po_gallery_show_rating'];
		} else {
			$this->data['po_gallery_show_rating'] = $this->config->get('po_gallery_show_rating');
		}
		
		if (isset($this->request->post['po_gallery_type'])) {
			$this->data['po_gallery_type'] = $this->request->post['po_gallery_type'];
		} else {
			$this->data['po_gallery_type'] = $this->config->get('po_gallery_type');
		}
		
		if (isset($this->request->post['po_gallery_album_title_font'])) {
			$this->data['po_gallery_album_title_font'] = $this->request->post['po_gallery_album_title_font'];
		} else {
			$this->data['po_gallery_album_title_font'] = $this->config->get('po_gallery_album_title_font');
		}
		
		if (isset($this->request->post['po_gallery_album_width'])) {
			$this->data['po_gallery_album_width'] = $this->request->post['po_gallery_album_width'];
		} else {
			$this->data['po_gallery_album_width'] = $this->config->get('po_gallery_album_width');
		}
								
		$this->template = 'catalog/po_gallery_setting.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'catalog/po_gallery_setting')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['po_gallery_heading_title']) {
			$this->error['heading_title'] = $this->language->get('error_heading_title');
		}	

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
			
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	
}
?>
<?php
class ControllerModulejvquickorder extends Controller {
	
	private $version = 'ver 2.75';
	
	private $error = array(); 
	
	private function init_lang_vars($lang_vars = array()) {
		
		$array_lang_vars = array();
		
		foreach ($lang_vars as $lang_var) {
			$array_lang_vars[$lang_var] = $this->language->get($lang_var);
		}
		
		return $array_lang_vars;
	}
	
	private function init_error_vars($error_vars = array(), $thiserror = array()) {
		
	$array_error_vars = array();

	foreach ($error_vars as $key => $value) {
		if (isset($thiserror[$key])) {
			$array_error_vars[$value] = $thiserror[$key];
		} else {
			$array_error_vars[$value] = array();
		}
	}

	return $array_error_vars;
	}
	
	private function create_breadcrumbs() {
		
		$local_breadcrumbs_array = array();
		
		$local_breadcrumbs_array[] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);
		
		$local_breadcrumbs_array[] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$local_breadcrumbs_array[] = array(
       		'text'      => strip_tags($this->language->get('heading_title')) . ' ' .  $this->version,
			'href'      => $this->url->link('module/jvquickorder', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		return $local_breadcrumbs_array;
	}
	
	public function index() {
		
		$this->load->language('module/jvquickorder');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')) . ' ' .  $this->version);
		$this->data['heading_title'] = strip_tags($this->language->get('heading_title')) . ' ' .  $this->version;
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('jvquickorder', $this->request->post);		
			$this->session->data['success'] = $this->language->get('text_success');
			
			if(isset($this->request->post['save_continue']) and $this->request->post['save_continue'])
				$this->redirect($this->url->link('module/jvquickorder', 'token=' . $this->session->data['token'], 'SSL'));
			else
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		// Create language variables
		$lang_vars = array(
			'text_enabled', 'text_disabled', 'text_yes', 'text_no', 'text_select_all', 'text_unselect_all',
			'button_save', 'button_save_stay', 'button_cancel', 
			'tab_text_common', 'tab_text_appearance', 'tab_text_fields', 'tab_text_email', 'tab_text_order', 'tab_text_system_settings',
			'entry_offon',
			'entry_work_in_categories', 'entry_in_stock',
			'entry_show_product_name_price', 'entry_show_product_desc', 'entry_show_product_images', 
			
			'entry_type_product_images', 'type_product_images_option',
			
			'entry_title_before_form', 'entry_text_before_form',
			'entry_show_popover',
			'entry_colour_button_quickorder', 'colour_button_quickorder_option',
			
			'entry_send_email_status', 
			'entry_type_email', 'type_email_option',	
			
			'entry_offon_email_admin', 'entry_offon_email_additional', 'entry_offon_email_customer', 
			
			'entry_field_user_name_title', 'entry_field_user_name_show', 'entry_field_user_name_required', 
			'entry_field_user_phone_title', 'entry_field_user_phone_show', 
			'entry_field_user_phone_required', 'entry_field_user_phone_maskedinput',
			'entry_field_email_title', 'entry_field_email_show', 'entry_field_email_required', 
			'entry_field_comment_title', 'entry_field_comment_show', 'entry_field_comment_required', 
			'entry_field_product_quantity_title', 'entry_field_product_quantity_show', 'entry_field_product_quantity_required', 
			
			'entry_order_offon', 'entry_order_name_in_admin', 'entry_order_status',
			'entry_del_system_css_on_show'
		);
		$this->data = $this->data + $this->init_lang_vars($lang_vars);
		// Create language variables

		// Create error variables
		$error_vars = array(
			'warning' 					=> 'error_warning'
		);
		$this->data = $this->data + $this->init_error_vars($error_vars, $this->error);
		// Create error variables
	
		//Create breadcrumbs
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'] = $this->create_breadcrumbs();
		//Create breadcrumbs
					
		$this->data['action'] = $this->url->link('module/jvquickorder', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		// Список категорий
		$this->load->model('catalog/category');
		$results = $this->model_catalog_category->getCategories(0);

		foreach ($results as $result) {
			//	
			$path = $this->model_catalog_category->getPath($result['category_id']);
			//
			$this->data['categories'][] = array(
				'category_id' => $result['category_id'],
				'name'        => $result['name'],
				'href'        => $this->url->link('catalog/category', 'token=' . $this->session->data['token'] . '&' . 'path=' . $path,  'SSL')
			);
		}
		// Список категорий
		
		// Настройки
		$config_vars = array(
			'jvquickorder_status',
			'config_var_category', 'consider_in_stock', 
			'show_product_name_price', 'show_product_desc', 
			
			'show_product_images', 'type_product_images',
			
			'title_before_form', 'text_before_form',
			'show_popover',
			'type_colour_button_quickorder',
			
			'field_user_name_show', 'field_user_name_required',
			'field_user_phone_show', 'field_user_phone_required', 'field_user_phone_maskedinput',
			'field_email_show', 'field_email_required',
			'field_comment_show', 'field_comment_required',
			'field_product_quantity_show', 'field_product_quantity_required',
			
			'send_email_status', 'type_email', 'offon_email_admin', 'email_additional', 'offon_email_customer', 
			
			'order_offon', 'order_name_in_admin', 'order_order_status_id',
			
			'del_system_css_on_show'
        );
		
        foreach ($config_vars as $config_var) {
			if (isset($this->request->post[$config_var])) {
				$this->data[$config_var] = $this->request->post[$config_var];
			} else {
				$this->data[$config_var] = $this->config->get($config_var);
			}
        }
		// Настройки
		
		// Языки
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		// Языки
		
		// Статус заказа
		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		// Статус заказа
		
		$this->template = 'module/jvquickorder.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function install() {
		$this->load->model('setting/setting');
		
		// Список категорий
		$this->load->model('catalog/category');
		$results = $this->model_catalog_category->getCategories(0);

		$config_var_category = array();
		
		foreach ($results as $result) {
			$config_var_category[$result['category_id']] = $result['category_id'];
		}
		// Список категорий
		
		$setting = array(
			'jvquickorder_status' => 1,
			'config_var_category' => $config_var_category,
			'consider_in_stock' => 1,
			
			'show_product_name_price' =>1,
			'show_product_desc' => 1,
			'show_product_images' => 1,
			'type_product_images' => 'type_product_images_carousel',
			'show_popover' => 1,
			'type_colour_button_quickorder' => 'btn-primary',
			
			'field_user_name_show' => 1,
			'field_user_name_required' => 1,
			'field_user_phone_show' => 1,
			'field_user_phone_required' => 1,
			'field_user_phone_maskedinput' => '+9 (999) 999-9999',
			'field_email_show' => 1,
			'field_email_required' => 0,
			'field_comment_show' => 1,
			'field_comment_required' => 0,
			
			'field_product_quantity_show' => 1, 
			'field_product_quantity_required' => 0,
			
			'send_email_status' => 1,
			'type_email' => 'Html',
			'offon_email_admin' => 1,
			'offon_email_customer' => 1,
			
			'order_offon' => 1,
			'order_name_in_admin' => 'JV_QuickOrder_',
			
			'del_system_css_on_show' => 0
		);
		
		$this->model_setting_setting->editSetting('jvquickorder', $setting);
	}
	
	public function uninstall() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting('jvquickorder');
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/jvquickorder')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>
<?php
class ControllerModuleQuickcheckout extends Controller {
	private $error = array(); 
	private $texts = array('title', 'tooltip', 'description', 'text');
	
	public function index() {   
		$this->load->language('module/quickcheckout');

		$this->document->setTitle($this->language->get('heading_title_main'));
		
		$this->load->model('setting/setting');
		
		/*
		*	Multistore
		*/
		if(isset($this->request->get['store_id'])){ $store_id = $this->request->get['store_id']; }else{  $store_id = 0; }
		
		/*
		*	Save settings
		*/		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->session->data['success'] = $this->language->get('text_success');

			if(isset($this->request->post['quickcheckout']['general']['settings']['value'])){
				$settings = str_replace("amp;", "", urldecode($this->request->post['quickcheckout']['general']['settings']['bulk']));
				parse_str($settings, $this->request->post );	
			}
			
			$this->model_setting_setting->editSetting('quickcheckout', $this->request->post, $store_id);

			if(!isset($this->request->post['save'])){
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
		
		/*
		*	Load css and javascript. In mijoshop requires a fix.
		*/
// 		$this->document->addStyle('view/stylesheet/quickcheckout.css');			
// 		$this->document->addStyle('view/stylesheet/shopunity/normalize.css');
// 		$this->document->addStyle('view/stylesheet/shopunity/icons.css');
// 		$this->document->addStyle('view/stylesheet/shopunity/shopunity.css');
// 		$this->document->addScript('view/javascript/shopunity/shopunity.js');
// 		$this->document->addScript('view/javascript/shopunity/jquery.nicescroll.min.js');
// 		$this->document->addScript('view/javascript/shopunity/jquery.tinysort.min.js');	
// 		$this->document->addScript('view/javascript/shopunity/jquery.autosize.min.js');		
// 		$this->document->addScript('view/javascript/shopunity/tooltip/tooltip.js');
// 		$this->document->addStyle('view/javascript/shopunity/codemirror/codemirror.css');
// 		$this->document->addScript('view/javascript/shopunity/codemirror/codemirror.js');
// 		$this->document->addScript('view/javascript/shopunity/codemirror/css.js');
// 		$this->document->addStyle('view/javascript/shopunity/uniform/css/uniform.default.css');
// 		$this->document->addScript('view/javascript/shopunity/uniform/jquery.uniform.min.js');

// 		$this->document->addLink('//fonts.googleapis.com/css?family=PT+Sans:400,700,700italic,400italic&subset=latin,cyrillic-ext,latin-ext,cyrillic', "stylesheet");
		
		

		$this->data['heading_title'] = $this->language->get('heading_title_main');
		//version
		$this->mboot_script_dir = DIR_APPLICATION . 'mbooth/xml/';
		$str = file_get_contents($this->mboot_script_dir . 'mbooth_quickcheckout.xml');
		$xml = new SimpleXMLElement($str);
		// Words
		$this->data['version'] = $xml->version;
		$this->data['shopunity'] = $this->check_shopunity();
		$this->data['settings_yes'] = $this->language->get('settings_yes');
		$this->data['settings_no'] = $this->language->get('settings_no');
		$this->data['settings_display'] = $this->language->get('settings_display');
		$this->data['settings_require'] = $this->language->get('settings_require');
		$this->data['settings_always_show'] = $this->language->get('settings_always_show');
		$this->data['settings_enable'] = $this->language->get('settings_enable');
		$this->data['settings_select'] = $this->language->get('settings_select');
		$this->data['settings_image'] = $this->language->get('settings_image');
		$this->data['settings_second_step'] = $this->language->get('settings_second_step');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		// Home
		$this->data['text_home'] = $this->language->get('text_home');
		$this->data['text_home_h1'] = $this->language->get('text_home_h1');
		$this->data['heading_title_slogan'] = $this->language->get('text_home_h2');
		$this->data['text_general_intro'] = $this->language->get('text_general_intro');
		$this->data['text_payment_address_intro'] = $this->language->get('text_payment_address_intro');
		$this->data['text_shipping_address_intro'] = $this->language->get('text_shipping_address_intro');
		$this->data['text_shipping_method_intro'] = $this->language->get('text_shipping_method_intro');
		$this->data['text_payment_method_intro'] = $this->language->get('text_payment_method_intro');
		$this->data['text_confirm_intro'] = $this->language->get('text_confirm_intro');
		$this->data['text_design_intro'] = $this->language->get('text_design_intro');
		$this->data['text_plugins_intro'] = $this->language->get('text_plugins_intro');
	
		
		// General
		$this->data['text_general'] = $this->language->get('text_general');
		$this->data['text_general_enable'] = $this->language->get('text_general_enable');
		$this->data['text_general_version'] = $this->language->get('text_general_version');
		$this->data['text_general_debug'] = $this->language->get('text_general_debug');	
		$this->data['text_debug_button'] = $this->language->get('text_debug_button');	

		
		$this->data['text_general_default'] = $this->language->get('text_general_default');
		$this->data['text_register'] = $this->language->get('text_register');
		$this->data['text_guest'] = $this->language->get('text_guest');
		
		$this->data['text_step_login_option'] = $this->language->get('text_step_login_option');
		$this->data['step_login_option_login_display'] = $this->language->get('text_login');
		$this->data['step_login_option_register_display'] = $this->language->get('text_register');
		$this->data['step_login_option_guest_display'] = $this->language->get('text_guest');
		
		$this->data['text_general_main_checkout'] = $this->language->get('text_general_main_checkout');
		$this->data['text_general_min_order'] = $this->language->get('text_general_min_order');
		$this->data['language_min_order_text'] = $this->language->get('language_min_order_text');
		
		$this->data['text_general_default_email'] = $this->language->get('text_general_default_email');
		
		$this->data['text_general_settings'] = $this->language->get('text_general_settings');
		$this->data['text_general_settings_value'] = $this->language->get('text_general_settings_value');
		$this->data['text_position_module'] = $this->language->get('text_position_module');

		$this->data['text_login'] = $this->language->get('text_login');
		$this->data['text_login_intro'] = $this->language->get('text_login_intro');
		
		//Payment address
		$this->data['text_payment_address'] = $this->language->get('text_payment_address');	
		$this->data['text_guest_customer'] = $this->language->get('text_guest_customer');
		$this->data['text_registrating_customer'] = $this->language->get('text_registrating_customer');
		$this->data['text_logged_in_customer'] = $this->language->get('text_logged_in_customer');
		$this->data['text_payment_address_display_input'] = $this->language->get('text_payment_address_display_input');
		
		//Shipping address
		$this->data['text_shipping_address'] = $this->language->get('text_shipping_address');
		$this->data['text_shipping_address_display_input'] = $this->language->get('text_shipping_address_display_input');
		
		
		//Shipping method
		$this->data['text_shipping_method'] = $this->language->get('text_shipping_method');	
		$this->data['text_shipping_method_display'] = $this->language->get('text_shipping_method_display');	
		$this->data['text_shipping_method_display_options'] = $this->language->get('text_shipping_method_display_options');	
		$this->data['text_shipping_method_display_title'] = $this->language->get('text_shipping_method_display_title');	
		$this->data['text_shipping_method_input_style'] = $this->language->get('text_shipping_method_input_style');	
		$this->data['text_radio_style'] = $this->language->get('text_radio_style');	
		$this->data['text_select_style'] = $this->language->get('text_select_style');
		$this->data['text_shipping_method_default_option'] = $this->language->get('text_shipping_method_default_option');
		
		//Payment method
		$this->data['text_payment_method'] = $this->language->get('text_payment_method');
		$this->data['text_payment_method_display'] = $this->language->get('text_payment_method_display');
		$this->data['text_payment_method_display_options'] = $this->language->get('text_payment_method_display_options');
		$this->data['text_payment_method_display_images'] = $this->language->get('text_payment_method_display_images');
		$this->data['text_payment_method_display_title'] = $this->language->get('text_payment_method_display_title');
		$this->data['text_payment_method_input_style'] = $this->language->get('text_payment_method_input_style');
		$this->data['text_payment_method_default_option'] = $this->language->get('text_payment_method_default_option');
		
		//Cart
		$this->data['text_cart'] = $this->language->get('text_cart');
		$this->data['text_cart_display'] = $this->language->get('text_cart_display');
		$this->data['text_cart_columns_image'] = $this->language->get('text_cart_columns_image');
		$this->data['text_cart_columns_name'] = $this->language->get('text_cart_columns_name');
		$this->data['text_cart_columns_model'] = $this->language->get('text_cart_columns_model');
		$this->data['text_cart_columns_quantity'] = $this->language->get('text_cart_columns_quantity');
		$this->data['text_cart_columns_price'] = $this->language->get('text_cart_columns_price');
		$this->data['text_cart_columns_total'] = $this->language->get('text_cart_columns_total');
		$this->data['text_cart_option_coupon'] = $this->language->get('text_cart_option_coupon');
		$this->data['text_cart_option_voucher'] = $this->language->get('text_cart_option_voucher');
		$this->data['text_cart_option_reward'] = $this->language->get('text_cart_option_reward');
		
		//Payment
		$this->data['text_payment'] = $this->language->get('text_payment');

		//Confirm
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['text_confirm_display'] = $this->language->get('text_confirm_display');

		
		//Design
		$this->data['text_design'] = $this->language->get('text_design');
		$this->data['text_general_theme'] = $this->language->get('text_general_theme');
		$this->data['text_general_block_style'] = $this->language->get('text_general_block_style');
		$this->data['text_style_row'] = $this->language->get('text_style_row');
		$this->data['text_style_block'] = $this->language->get('text_style_block');
		$this->data['text_general_login_style'] = $this->language->get('text_general_login_style');
		$this->data['text_style_popup'] = $this->language->get('text_style_popup');	
		$this->data['text_general_cart_image_size'] = $this->language->get('text_general_cart_image_size');
		$this->data['text_cart_image_size_width'] = $this->language->get('text_cart_image_size_width');
		$this->data['text_cart_image_size_height'] = $this->language->get('text_cart_image_size_height');
		$this->data['text_general_max_width'] = $this->language->get('text_general_max_width');
		$this->data['text_general_column'] = $this->language->get('text_general_column');
		$this->data['text_general_custom_style'] = $this->language->get('text_general_custom_style');
		$this->data['text_general_trigger'] = $this->language->get('text_general_trigger');
		$this->data['text_payment_address_description'] = $this->language->get('text_payment_address_description');
		$this->data['text_shipping_address_description'] = $this->language->get('text_shipping_address_description');
		$this->data['text_shipping_method_description'] = $this->language->get('text_shipping_method_description');
		$this->data['text_payment_method_description'] = $this->language->get('text_payment_method_description');
		$this->data['text_cart_description'] = $this->language->get('text_cart_description');
		$this->data['text_payment_description'] = $this->language->get('text_payment_description');
		$this->data['text_confirm_description'] = $this->language->get('text_confirm_description');
		
		$this->data['text_analytics'] = $this->language->get('text_analytics');
		$this->data['text_analytics_intro'] = $this->language->get('text_analytics_intro');	
		
		//Plugins
		$this->data['text_plugins'] = $this->language->get('text_plugins');
		
		//Tooltips
		$this->data['general_enable_tooltip'] = $this->language->get('general_enable_tooltip');
		$this->data['general_version_tooltip'] = $this->language->get('general_version_tooltip');
		$this->data['general_debug_tooltip'] = $this->language->get('general_debug_tooltip');
		$this->data['general_default_tooltip'] = $this->language->get('general_default_tooltip');
		$this->data['step_login_option_tooltip'] = $this->language->get('step_login_option_tooltip');
		$this->data['general_main_checkout_tooltip'] = $this->language->get('general_main_checkout_tooltip');
		$this->data['general_min_order_tooltip'] = $this->language->get('general_min_order_tooltip');
		$this->data['general_default_email_tooltip'] = $this->language->get('general_default_email_tooltip');
		$this->data['general_settings_tooltip'] = $this->language->get('general_settings_tooltip');
		$this->data['position_module_tooltip'] = $this->language->get('position_module_tooltip');
		
		$this->data['shipping_address_enable_tooltip'] = $this->language->get('shipping_address_enable_tooltip');
		
		$this->data['shipping_method_display_tooltip'] = $this->language->get('shipping_method_display_tooltip');
		$this->data['shipping_method_display_options_tooltip'] = $this->language->get('shipping_method_display_options_tooltip');
		$this->data['shipping_method_display_title_tooltip'] = $this->language->get('shipping_method_display_title_tooltip');
		$this->data['shipping_method_input_style_tooltip'] = $this->language->get('shipping_method_input_style_tooltip');
		$this->data['shipping_method_default_option_tooltip'] = $this->language->get('shipping_method_default_option_tooltip');
		
		$this->data['payment_method_display_tooltip'] = $this->language->get('payment_method_display_tooltip');
		$this->data['payment_method_display_options_tooltip'] = $this->language->get('payment_method_display_options_tooltip');
		$this->data['payment_method_display_images_tooltip'] = $this->language->get('payment_method_display_images_tooltip');
		$this->data['payment_method_input_style_tooltip'] = $this->language->get('payment_method_input_style_tooltip');
		$this->data['payment_method_default_option_tooltip'] = $this->language->get('payment_method_default_option_tooltip');
		
		$this->data['cart_display_tooltip'] = $this->language->get('cart_display_tooltip');
		$this->data['cart_option_coupon_tooltip'] = $this->language->get('cart_option_coupon_tooltip');
		$this->data['cart_option_voucher_tooltip'] = $this->language->get('cart_option_voucher_tooltip');
		$this->data['cart_option_reward_tooltip'] = $this->language->get('cart_option_reward_tooltip');
		
		
		$this->data['general_theme_tooltip'] = $this->language->get('general_theme_tooltip');
		$this->data['general_block_style_tooltip'] = $this->language->get('general_block_style_tooltip');
		$this->data['general_login_style_tooltip'] = $this->language->get('general_login_style_tooltip');
		$this->data['general_cart_image_size_tooltip'] = $this->language->get('general_cart_image_size_tooltip');
		$this->data['general_max_width_tooltip'] = $this->language->get('general_max_width_tooltip');
		$this->data['general_column_tooltip'] = $this->language->get('general_column_tooltip');
		$this->data['general_custom_style_tooltip'] = $this->language->get('general_custom_style_tooltip');
		$this->data['general_trigger_tooltip'] = $this->language->get('general_trigger_tooltip');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_save_and_stay'] = $this->language->get('button_save_and_stay');
		
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		$this->data['tab_module'] = $this->language->get('tab_module');
		
		if (!file_exists(DIR_CATALOG.'../vqmod/xml/vqmod_extra_positions.xml')) {
            $this->data['positions_needed'] = $this->language->get('positions_needed');
         }

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

// 		if(!$this->check_shopunity()){
// 			$this->data['error_warning'] =  $this->language->get('error_shopunity_required');
// 		}

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
       		'text'      => $this->language->get('heading_title_main'),
			'href'      => $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'] . '&store_id='.$store_id, 'SSL');
		$this->data['route'] = $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		$this->data['quickcheckout'] = array();
		
		if(isset($this->request->get['store_id'])){
			$store_id = $this->request->get['store_id'];
		}else{
			$store_id = $this->config->get('config_store_id');
		}
		
		
		if (isset($this->request->post['quickcheckout'])) {
			$this->data['quickcheckout'] = $this->request->post['quickcheckout'];
		} elseif ($this->model_setting_setting->getSetting('quickcheckout', $store_id)) { 
			$settings = $this->model_setting_setting->getSetting('quickcheckout', $store_id);
			$this->data['quickcheckout'] =  $settings['quickcheckout']; 
		}
		$this->data['quickcheckout_modules'] = array();
		if (isset($this->request->post['quickcheckout_module'])) {
			$this->data['quickcheckout_modules'] = $this->request->post['quickcheckout_module'];
		} elseif ($this->model_setting_setting->getSetting('quickcheckout', $store_id)) { 
			$modules = $this->model_setting_setting->getSetting('quickcheckout', $store_id);
			if(!empty($modules['quickcheckout_module'])){
				$this->data['quickcheckout_modules'] = $modules['quickcheckout_module'];	
			}else{
				$this->data['quickcheckout_modules'] = array();	
			}
			
		}	
		
		//These are default settings (located in system/config/quickcheckout_settings.php)
		$settings = $this->config->get('quickcheckout_settings');
		if(empty($settings)){
			$this->config->load('quickcheckout_settings');
			$settings = $this->config->get('quickcheckout_settings');
		}
		//System settings
		$settings['general']['default_email'] = $this->config->get('config_email');
		$settings['step']['payment_address']['fields']['agree']['information_id'] = $this->config->get('config_account_id');
		$settings['step']['payment_address']['fields']['agree']['error'][0]['information_id'] = $this->config->get('config_account_id');
		$settings['step']['confirm']['fields']['agree']['information_id'] = $this->config->get('config_checkout_id');
		$settings['step']['confirm']['fields']['agree']['error'][0]['information_id'] = $this->config->get('config_checkout_id');
	
		if(!empty($this->data['quickcheckout'])){
			$this->data['quickcheckout'] = $this->array_merge_recursive_distinct($settings, $this->data['quickcheckout']);
		}else{
			$this->data['quickcheckout'] = $settings;
		}
		$this->data['quickcheckout']['general']['store_id'] = $store_id;
		
		$lang = $this->language_merge($this->data['quickcheckout']['step']['payment_address']['fields'], $this->texts);
		$this->data['quickcheckout']['step']['payment_address']['fields'] = $this->array_merge_recursive_distinct($this->data['quickcheckout']['step']['payment_address']['fields'], $lang);
		
		$lang = $this->language_merge($this->data['quickcheckout']['step']['shipping_address']['fields'], $this->texts);
		$this->data['quickcheckout']['step']['shipping_address']['fields'] = $this->array_merge_recursive_distinct($this->data['quickcheckout']['step']['shipping_address']['fields'], $lang);
		
		$lang = $this->language_merge($this->data['quickcheckout']['step']['confirm']['fields'], $this->texts);
		$this->data['quickcheckout']['step']['confirm']['fields'] = $this->array_merge_recursive_distinct($this->data['quickcheckout']['step']['confirm']['fields'], $lang);
		
		//Get Shipping methods
		$this->load->model('setting/extension');
		$shipping_methods = glob(DIR_APPLICATION . 'controller/shipping/*.php');
		$this->data['shipping_methods'] = array();
		foreach ($shipping_methods as $shipping){
			$shipping = basename($shipping, '.php');
			$this->load->language('shipping/' . $shipping);
			$this->data['shipping_methods'][] = array(
				'code' => $shipping,
				'title' => $this->language->get('heading_title')
			);
		}
		//Get Payment methods
		$this->load->model('setting/extension');
		$payment_methods = glob(DIR_APPLICATION . 'controller/payment/*.php');
		$this->data['payment_methods'] = array();
		foreach ($payment_methods as $payment){
			$payment = basename($payment, '.php');
			$this->load->language('payment/' . $payment);
			$this->data['payment_methods'][] = array(
				'code' => $payment,
				'title' => $this->language->get('heading_title')
			);
		}
				
		
		//Get designes
// 		$dir    = DIR_CATALOG.'/view/theme/default/stylesheet/quickcheckout/theme';
// 		$files = scandir($dir);
		$this->data['themes'] = array();
// 		foreach($files as $file){
// 			if(strlen($file) > 6){
// 				$this->data['themes'][] = substr($file, 0, -4);
// 			}
// 		}
		
		//Get stores
		$this->load->model('setting/store');
		$results = $this->model_setting_store->getStores();
		if($results){
			$this->data['stores'][] = array('store_id' => 0, 'name' => $this->config->get('config_name'));
			
			foreach ($results as $result) {
				$this->data['stores'][] = array(
					'store_id' => $result['store_id'],
					'name' => $result['name']
					
				);
			}	
		}
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'module/quickcheckout.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/quickcheckout')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	
	public function install() {
		  $this->load->model('setting/setting');
		  $file1 = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml_"; $file2 = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml";
		  if (file_exists($file1)) rename($file1, $file2);
		  $this->version_check(1);
		  
	}
		 
	public function uninstall() {
		  $this->load->model('setting/setting');
		  $file1 = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml"; $file2 = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml_";
		  if (file_exists($file1)) rename($file1, $file2);
		  $this->version_check(0);
		  
	}
	
	public function language_merge($array, $texts){
		$this->load->model('catalog/information');
		$array_full = $array; 
		$result = array();
		foreach ($array as $key => $value){
			foreach ($texts as $text){
				if(isset($array_full[$text])){
					if(!is_array($array_full[$text])){
						$result[$text] = $this->language->get($array_full[$text]);	
					}else{
						if(isset($array_full[$text][(int)$this->config->get('config_language_id')])){
							$result[$text] = $array_full[$text][(int)$this->config->get('config_language_id')];
						}else{
							$result[$text] = current($array_full[$text]);
						}
					}
					if((strpos($result[$text], '%s') !== false) && isset($array_full['information_id'])){
						$information_info = $this->model_catalog_information->getInformation($array_full['information_id']);
						$result[$text] = sprintf($result[$text], $information_info['title']);	
					}
				}						
			}
			if(is_array($array_full[$key])){	
						$result[$key] = $this->language_merge($array_full[$key], $texts);	
			}
			
		}

		return $result;
		
	}
	
	public function array_merge_recursive_distinct( array &$array1, array &$array2 )
	{
	  $merged = $array1;	
	  foreach ( $array2 as $key => &$value )
		  {
			if ( is_array ( $value ) && isset ( $merged [$key] ) && is_array ( $merged [$key] ) )
			{
			  $merged [$key] = $this->array_merge_recursive_distinct ( $merged [$key], $value );
			}
			else
			{
			  $merged [$key] = $value;
			}
		  }
		
	  return $merged;
	}
	public function check_shopunity(){
		$file1 = DIR_APPLICATION . "mbooth/xml/mbooth_shopunity_admin.xml"; 
		$file2 = DIR_APPLICATION . "mbooth/xml/mbooth_shopunity_admin_patch.xml"; 
		if (file_exists($file1) || file_exists($file2)) { 
			return true;
		} else {
			return false;
		}

	}
	public function version_check($status = 1){
		$json = array();
		$this->load->language('module/quickcheckout');
		$this->mboot_script_dir = substr_replace(DIR_SYSTEM, '/admin/mbooth/xml/', -8);
		$str = file_get_contents($this->mboot_script_dir . 'mbooth_quickcheckout.xml');
		$xml = new SimpleXMLElement($str);
	
		$current_version = $xml->version ;
      
		if (isset($this->request->get['mbooth'])) { 
			$mbooth = $this->request->get['mbooth']; 
		} else { 
			$mbooth = 'mbooth_quickcheckout.xml'; 
		}
		

		// $customer_login = $this->config->get('shopunity_customer_login');
		// $customer_pass = $this->config->get('shopunity_customer_password');
		// $customer_key = $this->config->get('shopunity_customer_password');
		$customer_url = HTTP_SERVER;
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE language_id = " . (int)$this->config->get('config_language_id') ); 
		$language_code = $query->row['code'];
		$ip = $this->request->server['REMOTE_ADDR'];

		$check_version_url = 'http://opencart.dreamvention.com/update/index.php?mbooth=' . $mbooth . '&store_url=' . $customer_url . '&module_version=' . $current_version . '&language_code=' . $language_code . '&opencart_version=' . VERSION . '&ip='.$ip . '&status=' .$status;
		
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $check_version_url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$return_data = curl_exec($curl);
		$return_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

      if ($return_code == 200) {
         $data = simplexml_load_string($return_data);
	
         if ((string) $data->version == (string) $current_version || (string) $data->version <= (string) $current_version) {
			 
           $json['success']   = $this->language->get('text_no_update') ;

         } elseif ((string) $data->version > (string) $current_version) {
			 
			$json['attention']   = $this->language->get('text_new_update');
				
			foreach($data->updates->update as $update){

				if((string) $update->attributes()->version > (string)$current_version){
					$version = (string)$update->attributes()->version;
					$json['update'][$version] = (string) $update[0];
				}
			}
         } else {
			 
            $json['error']   = $this->language->get('text_error_update');
         }
      } else { 
         $json['error']   =  $this->language->get('text_error_failed');

      }

      if (file_exists(DIR_SYSTEM.'library/json.php')) { 
         $this->load->library('json');
         $this->response->setOutput(Json::encode($json));
      } else {
         $this->response->setOutput(json_encode($json));
      }
   }
}
?>
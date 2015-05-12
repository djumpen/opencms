<?php
class ControllerModuleDiscount extends Controller {
	private $error = array(); 
	 
	public function index() {
	
		$this->language->load('module/discount');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('catalog/discount');
		$this->load->model('catalog/manufacturer');
		$this->load->model('sale/customer_group');
		
		$this->data['discount_data'] = $this->model_catalog_discount->getSetting('discount');
		
		
		
		
		if(($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()){
			$this->model_catalog_discount->editSetting('discount', $this->request->post['discount']);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			//DEBUG //$this->redirect($this->url->link('module/discount', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$primary_currency                     = $this->model_catalog_discount->getPrimaryCurrency();
		$this->data['primary_currency_code']  = $primary_currency['code'];
		$this->data['manufacturers']          = $this->model_catalog_manufacturer->getManufacturers();
		$this->data['customer_groups']        = $this->model_sale_customer_group->getCustomerGroups();


  //language
		$this->data['heading_title']                  = $this->language->get('heading_title');
		$this->data['text_enabled']                   = $this->language->get('text_enabled');
		$this->data['text_disabled']                  = $this->language->get('text_disabled');
		$this->data['text_status']                    = $this->language->get('text_status');
		$this->data['button_save']                    = $this->language->get('button_save');
		$this->data['button_cancel']                  = $this->language->get('button_cancel');
		$this->data['text_status_i']                  = $this->language->get('text_status_i');
		$this->data['text_fulltime_discount']         = $this->language->get('text_fulltime_discount');
		$this->data['text_fulltime_discount_i']       = $this->language->get('text_fulltime_i');
		$this->data['text_discount_date']             = $this->language->get('text_discount_date');
		$this->data['text_discount_date_i']           = $this->language->get('text_discount_date_i');
		$this->data['text_discount_date_start']       = $this->language->get('text_discount_date_start');
		$this->data['text_discount_date_end']         = $this->language->get('text_discount_date_end');
		$this->data['text_discount_type']             = $this->language->get('text_discount_type');
		$this->data['text_discount_type_i']           = $this->language->get('text_discount_type_i');
		$this->data['text_percentage']                = $this->language->get('text_percentage');
		$this->data['text_fixed']                     = $this->language->get('text_fixed');
		$this->data['text_discount_value']            = $this->language->get('text_discount_value');
		$this->data['text_discount_value_i']          = $this->language->get('text_discount_value_i');
		$this->data['text_enabled']                   = $this->language->get('text_enabled');
		$this->data['text_disabled']                  = $this->language->get('text_disabled');
		$this->data['text_type_of_discount']          = $this->language->get('text_type_of_discount');
		$this->data['text_fulltime']                  = $this->language->get('text_fulltime');
		$this->data['text_category']                  = $this->language->get('text_category');
		$this->data['text_action']                    = $this->language->get('text_action');
		$this->data['text_include_subcategories']     = $this->language->get('text_include_subcategories');
		$this->data['text_remove']                    = $this->language->get('text_remove');
		$this->data['text_add_category']              = $this->language->get('text_add_category');
		$this->data['text_add_manufacturer']          = $this->language->get('text_add_manufacturer');
		$this->data['text_add_customer_group']        = $this->language->get('text_add_customer_group');
		$this->data['text_manufacturer']              = $this->language->get('text_manufacturer');
		$this->data['text_select_manufacturer']       = $this->language->get('text_select_manufacturer');
		$this->data['text_select_customer_group']     = $this->language->get('text_select_customer_group');
		$this->data['text_customer_group']            = $this->language->get('text_customer_group');
		$this->data['text_module_setting']            = $this->language->get('text_module_setting');
		$this->data['text_include_special']           = $this->language->get('text_include_special');
		$this->data['text_include_special_i']         = $this->language->get('text_include_special_i');
		$this->data['text_include_options']           = $this->language->get('text_include_options');
		$this->data['text_include_options_i']         = $this->language->get('text_include_options_i');
		$this->data['text_yes']                       = $this->language->get('text_yes');
		$this->data['text_no']                        = $this->language->get('text_no');
		$this->data['text_discount_total']            = $this->language->get('text_discount_total');
		$this->data['text_discount_category']         = $this->language->get('text_discount_category');
		$this->data['text_discount_customer_group']   = $this->language->get('text_discount_customer_group');
		$this->data['text_discount_manufacturer']     = $this->language->get('text_discount_manufacturer');
		$this->data['text_module_status']             = $this->language->get('text_module_status');
		
		
		
		$this->load->model('catalog/category');
		$this->data['categories'] = $this->model_catalog_category->getCategories(0);
		
		
		
		
		

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
   		'text'      => $this->language->get('text_module'),
    	'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
   		'separator' => ' :: '
 		);
	
 		$this->data['breadcrumbs'][] = array(
   		'text'      => $this->language->get('heading_title'),
  		'href'      => $this->url->link('module/welcome', 'token=' . $this->session->data['token'], 'SSL'),
  		'separator' => ' :: '
 		);
		
		
		$this->data['action'] = $this->url->link('module/discount', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];


		$this->template = 'module/discount.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	

	 function validate() {
	 
	    $this->data['error'] = false;
	  
  	  if(isset($this->data['discount_data']['setting']['status']) AND $this->data['discount_data']['setting']['status'] == '0'){
  	    return true;
   	  }else{
		
      if (!$this->user->hasPermission('modify', 'module/discount')) {
  			$this->error['warning'] = $this->language->get('error_permission');
  		}
		
      $this->data['discount_data'] = $this->request->post['discount'];
  		
  		
  		
  	  if(isset($this->data['discount_data']['setting']['discount_type']) AND $this->data['discount_data']['setting']['discount_type'] == 'customer_group'){
     	 $i = 1;
     	 $discount_type = 'customer_group';
     	 if(isset($this->data['discount_data'][$discount_type])){
      	 foreach($this->data['discount_data'][$discount_type] as $customer_group){
           if(!isset($customer_group['fulltime']) AND $customer_group['discount_start'] == ""){
      			 $this->data['error'][$discount_type][$i]['discount_start'] = true;
           }
           if(!isset($customer_group['fulltime']) AND $customer_group['discount_stop'] == ""){
      			 $this->data['error'][$discount_type][$i]['discount_stop'] = true;
           }
           if(!isset($customer_group['discount_value']) || $customer_group['discount_value'] == ""){
      		 	 $this->data['error'][$discount_type][$i]['discount_value'] = true;
           }
           $i++;
          }
        }
      }
   
		
  	 
  	  if(isset($this->data['discount_data']['setting']['discount_type']) AND $this->data['discount_data']['setting']['discount_type'] == 'manufacturer'){
    	  $i = 1;
    	  $discount_type = 'manufacturer';
    	  if(isset($this->data['discount_data'][$discount_type])){
      	  foreach($this->data['discount_data'][$discount_type] as $manufacturer){
            if(!isset($manufacturer['fulltime']) AND $manufacturer['discount_start'] == ""){
      		 	  $this->data['error'][$discount_type][$i]['discount_start'] = true;
            }
            if(!isset($manufacturer['fulltime']) AND $manufacturer['discount_stop'] == ""){
      			  $this->data['error'][$discount_type][$i]['discount_stop'] = true;
            }
            if(!isset($manufacturer['discount_value']) || $manufacturer['discount_value'] == ""){
      			  $this->data['error'][$discount_type][$i]['discount_value'] = true;
            }
          $i++;
         }
        }
      }
    		
  	
  	  if(isset($this->data['discount_data']['setting']['discount_type']) AND $this->data['discount_data']['setting']['discount_type'] == 'category'){
    	  $i = 1;
    	  $discount_type = 'category';
    	  if(isset($this->data['discount_data'][$discount_type])){
      	  foreach($this->data['discount_data'][$discount_type] as $category){
            if(!isset($category['category_id']) || $category['category_id'] == ""){
      			  $this->data['error'][$discount_type][$i]['category_id'] = true;
            }
            if(!isset($category['fulltime']) AND $category['discount_start'] == ""){
      			  $this->data['error'][$discount_type][$i]['discount_start'] = true;
            }
            if(!isset($category['fulltime']) AND $category['discount_stop'] == ""){
      			  $this->data['error'][$discount_type][$i]['discount_stop'] = true;
            }
            if(!isset($category['discount_value']) || $category['discount_value'] == ""){
      			  $this->data['error'][$discount_type][$i]['discount_value'] = true;
            }
            $i++;
          }
        }
      }
     
     
  	  if(isset($this->data['discount_data']['setting']['discount_type']) AND $this->data['discount_data']['setting']['discount_type'] == 'total'){
    	  $discount_type = 'total';
        if(!isset($this->data['discount_data'][$discount_type]['fulltime']) AND $this->data['discount_data'][$discount_type]['discount_start'] == ""){
    		  $this->data['error'][$discount_type]['discount_start'] = true;
        }
        if(!isset($this->data['discount_data'][$discount_type]['fulltime']) AND $this->data['discount_data'][$discount_type]['discount_stop'] == ""){
    		  $this->data['error'][$discount_type]['discount_stop'] = true;
        }
        if(!isset($this->data['discount_data'][$discount_type]['discount_value']) || $this->data['discount_data'][$discount_type]['discount_value'] == ""){
    		  $this->data['error'][$discount_type]['discount_value'] = true;
        }
      }
     
     
 		  if($this->data['error']){
	 		  $this->error['warning'] = $this->language->get('error_form');
		  }
	
  
  		if (!$this->error) {
  			return true;
  		}else{
  			return false;
  		}
		
  	}
	}
	
}
?>
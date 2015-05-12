<?php 
class ControllerCommonHeader extends Controller {
	protected function index() {
		$this->data['title'] = $this->document->getTitle();
		
		$this->document->addScript(SCRIPT_FOLDER . 'jquery/jquery.chained.mini.js');
		$this->document->addScript(SCRIPT_FOLDER . 'jquery/jquery-migrate-1.2.1.min.js');
		$this->document->addScript(SCRIPT_FOLDER . 'jquery/tabs.js');
		$this->document->addScript(SCRIPT_FOLDER . 'pavmegamenu/jquerycookie.js');
		$this->document->addScript(SCRIPT_FOLDER . 'pavmegamenu/jquery.nestable.js');
		$this->document->addScript(SCRIPT_FOLDER . 'bootstrap-editable/bootstrap-editable.js');
		$this->document->addScript(SCRIPT_FOLDER . 'bootstrap-colorpicker/bootstrap-colorpicker.js');
		$this->document->addScript(SCRIPT_FOLDER . 'bootstrap-bootbox/bootbox.js');
		$this->document->addScript(SCRIPT_FOLDER . 'moment-with-locales.js');
		$this->document->addScript(SCRIPT_FOLDER . 'bootstrap-datetimepicker.min.js');
		
		$this->document->addStyle(STYLE_FOLDER . 'bootstrap-editable.css');
		$this->document->addStyle(STYLE_FOLDER . 'bootstrap-colorpicker.min.css');
		$this->document->addStyle(STYLE_FOLDER . 'bootstrap-datetimepicker.css');

		if(DEBUG) {
		    ini_set('error_reporting', E_ALL & ~E_NOTICE & ~E_WARNING & ~E_DEPRECATED );
		}
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}
		
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		
		$this->language->load('common/header');
		$this->load->language('module/testimonial');
		

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_attribute'] = $this->language->get('text_attribute');
		$this->data['text_attribute_group'] = $this->language->get('text_attribute_group');
		$this->data['text_backup'] = $this->language->get('text_backup');
		$this->data['text_banner'] = $this->language->get('text_banner');
		$this->data['text_catalog'] = $this->language->get('text_catalog');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['text_country'] = $this->language->get('text_country');
		$this->data['text_coupon'] = $this->language->get('text_coupon');
		$this->data['text_currency'] = $this->language->get('text_currency');			
		$this->data['text_customer'] = $this->language->get('text_customer');
		$this->data['text_customer_group'] = $this->language->get('text_customer_group');
		$this->data['text_customer_field'] = $this->language->get('text_customer_field');
		$this->data['text_customer_ban_ip'] = $this->language->get('text_customer_ban_ip');
		$this->data['text_custom_field'] = $this->language->get('text_custom_field');
		$this->data['text_sale'] = $this->language->get('text_sale');
		$this->data['text_design'] = $this->language->get('text_design');
		$this->data['text_documentation'] = $this->language->get('text_documentation');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_error_log'] = $this->language->get('text_error_log');
		$this->data['text_extension'] = $this->language->get('text_extension');
		$this->data['text_feed'] = $this->language->get('text_feed');
		$this->data['text_filter'] = $this->language->get('text_filter');
		$this->data['text_front'] = $this->language->get('text_front');
		$this->data['text_geo_zone'] = $this->language->get('text_geo_zone');
		$this->data['text_dashboard'] = $this->language->get('text_dashboard');
		$this->data['text_help'] = $this->language->get('text_help');
		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_testimonial'] = $this->language->get('heading_title');
		$this->data['text_language'] = $this->language->get('text_language');
		$this->data['text_layout'] = $this->language->get('text_layout');
		$this->data['text_localisation'] = $this->language->get('text_localisation');
		$this->data['text_logout'] = $this->language->get('text_logout');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_manager'] = $this->language->get('text_manager');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_option'] = $this->language->get('text_option');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_order_status'] = $this->language->get('text_order_status');
		$this->data['text_opencart'] = $this->language->get('text_opencart');
		$this->data['text_payment'] = $this->language->get('text_payment');
		$this->data['text_product'] = $this->language->get('text_product');
		/*code start*/
		$this->data['text_tags'] = $this->language->get('text_tags');
		/*code end*/
		$this->data['text_seopack'] = $this->language->get('text_seopack');
		$this->data['text_seoimages'] = $this->language->get('text_seoimages');
		$this->data['text_seoeditor'] = $this->language->get('text_seoeditor');
		$this->data['text_seoreport'] = $this->language->get('text_seoreport');
		$this->data['text_autolinks'] = $this->language->get('text_autolinks');
		$this->data['text_profile'] = $this->language->get('text_profile');
		$this->data['text_reports'] = $this->language->get('text_reports');
		$this->data['text_report_sale_order'] = $this->language->get('text_report_sale_order');
		$this->data['text_report_sale_tax'] = $this->language->get('text_report_sale_tax');
		$this->data['text_report_sale_shipping'] = $this->language->get('text_report_sale_shipping');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_sale_coupon'] = $this->language->get('text_report_sale_coupon');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');
		$this->data['text_report_customer_online'] = $this->language->get('text_report_customer_online');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_report_customer_reward'] = $this->language->get('text_report_customer_reward');
		$this->data['text_report_customer_credit'] = $this->language->get('text_report_customer_credit');
		$this->data['text_report_affiliate_commission'] = $this->language->get('text_report_affiliate_commission');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_review'] = $this->language->get('text_review');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_return_action'] = $this->language->get('text_return_action');
		$this->data['text_return_reason'] = $this->language->get('text_return_reason');
		$this->data['text_return_status'] = $this->language->get('text_return_status');
		$this->data['text_support'] = $this->language->get('text_support');
		$this->data['text_shipping'] = $this->language->get('text_shipping');
		$this->data['text_setting'] = $this->language->get('text_setting');
		$this->data['text_stock_status'] = $this->language->get('text_stock_status');
		$this->data['text_system'] = $this->language->get('text_system');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_tax_class'] = $this->language->get('text_tax_class');
		$this->data['text_tax_rate'] = $this->language->get('text_tax_rate');
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_user'] = $this->language->get('text_user');
		$this->data['text_user_group'] = $this->language->get('text_user_group');
		$this->data['text_users'] = $this->language->get('text_users');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_voucher_theme'] = $this->language->get('text_voucher_theme');
		$this->data['text_weight_class'] = $this->language->get('text_weight_class');
		$this->data['text_length_class'] = $this->language->get('text_length_class');
		/* Pav blog */
		$this->load->model('setting/extension');
		$extensions = $this->model_setting_extension->getInstalled('module');
		$this->data['pavblog_installed'] = false;
		if(in_array("pavblog", $extensions)){
		    $this->data['pavblog_installed'] = true;
		}
		
		$this->data['text_pavblog_manage_cate'] = $this->language->get('text_pavblog_manage_cate');
		$this->data['text_pavblog_manage_blog'] = $this->language->get('text_pavblog_manage_blog');
		$this->data['text_pavblog_add_blog'] = $this->language->get('text_pavblog_add_blog');
		$this->data['text_pavblog_manage_comment'] = $this->language->get('text_pavblog_manage_comment');
		$this->data['text_pavblog_general_setting'] = $this->language->get('text_pavblog_general_setting');
		$this->data['text_pavblog_front_mods'] = $this->language->get('text_pavblog_front_mods');
		$this->data['text_pavblog_blog'] = $this->language->get('text_pavblog_blog');
		$this->data['text_pavblog_category'] = $this->language->get('text_pavblog_category');
		$this->data['text_pavblog_comment'] = $this->language->get('text_pavblog_comment');
		$this->data['text_pavblog_latest'] = $this->language->get('text_pavblog_latest');
		/* Pav blog */
		$this->data['text_zone'] = $this->language->get('text_zone');
		$this->load->language('module/poll');
		$this->data['text_poll'] = $this->language->get('text_poll');
        $this->data['text_openbay_extension'] = $this->language->get('text_openbay_extension');
        $this->data['text_openbay_dashboard'] = $this->language->get('text_openbay_dashboard');
        $this->data['text_openbay_orders'] = $this->language->get('text_openbay_orders');
        $this->data['text_openbay_items'] = $this->language->get('text_openbay_items');
        $this->data['text_openbay_ebay'] = $this->language->get('text_openbay_ebay');
        $this->data['text_openbay_amazon'] = $this->language->get('text_openbay_amazon');
        $this->data['text_openbay_amazonus'] = $this->language->get('text_openbay_amazonus');
        $this->data['text_openbay_play'] = $this->language->get('text_openbay_play');
        $this->data['text_openbay_settings'] = $this->language->get('text_openbay_settings');
        $this->data['text_openbay_links'] = $this->language->get('text_openbay_links');
        $this->data['text_openbay_report_price'] = $this->language->get('text_openbay_report_price');
        $this->data['text_openbay_order_import'] = $this->language->get('text_openbay_order_import');
		
		$this->data['text_paypal_express'] = $this->language->get('text_paypal_manage');
		$this->data['text_paypal_express_search'] = $this->language->get('text_paypal_search');
		$this->data['text_recurring_profile'] = $this->language->get('text_recurring_profile');
		
		$this->data['text_new_customer'] = $this->language->get('text_new_customer'); 
		$this->data['text_pending_customer'] = $this->language->get('text_pending_customer'); 
		$this->data['text_new_order'] = $this->language->get('text_new_order'); 
		$this->data['text_pending_order'] = $this->language->get('text_pending_order'); 
		$this->data['text_pending_review'] = $this->language->get('text_pending_review'); 
		$this->data['text_pending_affiliate'] = $this->language->get('text_pending_affiliate'); 
		$this->data['text_notification'] = $this->language->get('text_notification'); 
		$this->data['text_stockout'] = $this->language->get('text_stockout');
		
		# Filter start
		$this->data['text_filter'] = $this->language->get('text_filter');
		# Filter end
		

		if (!$this->user->isLogged() || !isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$this->data['logged'] = '';
			
			$this->data['home'] = $this->url->link('common/login', '', 'SSL');
		} else {
			$this->data['logged'] = sprintf($this->language->get('text_logged'), $this->user->getUserName());
            $this->data['pp_express_status'] = $this->config->get('pp_express_status');
            
			$this->data['home'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['affiliate'] = $this->url->link('sale/affiliate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute'] = $this->url->link('catalog/attribute', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute_group'] = $this->url->link('catalog/attribute_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['backup'] = $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL');
			/* Cacher */
			$this->data['text_clear_cache'] = $this->language->get('text_clear_cache');
			$this->data['clear_cache'] = $this->url->link('common/home/clearCache', 'token=' . $this->session->data['token'], 'NOSSL');
			/* Cacher */
			$this->data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['category'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['country'] = $this->url->link('localisation/country', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['coupon'] = $this->url->link('sale/coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['currency'] = $this->url->link('localisation/currency', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer'] = $this->url->link('sale/customer', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_fields'] = $this->url->link('sale/customer_field', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_group'] = $this->url->link('sale/customer_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_ban_ip'] = $this->url->link('sale/customer_ban_ip', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['custom_field'] = $this->url->link('design/custom_field', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['download'] = $this->url->link('catalog/download', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['error_log'] = $this->url->link('tool/error_log', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['feed'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['series'] = $this->url->link('catalog/series', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['filter'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['geo_zone'] = $this->url->link('localisation/geo_zone', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['information'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['testimonial'] = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['language'] = $this->url->link('localisation/language', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['layout'] = $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['logout'] = $this->url->link('common/logout', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['contact'] = $this->url->link('sale/contact', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['manager'] = $this->url->link('extension/manager', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['manufacturer'] = $this->url->link('catalog/manufacturer', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['module'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['option'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'], 'SSL');
			# Filter start
			$this->data['filter'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL');
			# Filter end
			$this->data['order'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['order_status'] = $this->url->link('localisation/order_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['payment'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL');
			/*code start*/
			$this->data['tags'] = $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'], 'SSL');
			/*code end*/
			$this->data['seopack'] = $this->url->link('catalog/seopack', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seoimages'] = $this->url->link('catalog/seoimages', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seoeditor'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seoreport'] = $this->url->link('catalog/seoreport', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['autolinks'] = $this->url->link('catalog/autolinks', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['profile'] = $this->url->link('catalog/profile', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_order'] = $this->url->link('report/sale_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_tax'] = $this->url->link('report/sale_tax', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_shipping'] = $this->url->link('report/sale_shipping', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_return'] = $this->url->link('report/sale_return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_coupon'] = $this->url->link('report/sale_coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_product_viewed'] = $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_product_purchased'] = $this->url->link('report/product_purchased', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_online'] = $this->url->link('report/customer_online', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_order'] = $this->url->link('report/customer_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_reward'] = $this->url->link('report/customer_reward', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_credit'] = $this->url->link('report/customer_credit', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_affiliate_commission'] = $this->url->link('report/affiliate_commission', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['review'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_action'] = $this->url->link('localisation/return_action', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_reason'] = $this->url->link('localisation/return_reason', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_status'] = $this->url->link('localisation/return_status', 'token=' . $this->session->data['token'], 'SSL');			
			$this->data['shipping'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['setting'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['store'] = HTTP_CATALOG;
			$this->data['stock_status'] = $this->url->link('localisation/stock_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['tax_class'] = $this->url->link('localisation/tax_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['tax_rate'] = $this->url->link('localisation/tax_rate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['total'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['voucher'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['voucher_theme'] = $this->url->link('sale/voucher_theme', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['weight_class'] = $this->url->link('localisation/weight_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['length_class'] = $this->url->link('localisation/length_class', 'token=' . $this->session->data['token'], 'SSL');
			
			/* Pav blog */
			$this->data['pavblogs_category_mod'] = $this->url->link('module/pavblog/frontmodules', 'mod=pavblogcategory&token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_latest_comment_mod'] = $this->url->link('module/pavblog/frontmodules', 'mod=pavblogcomment&token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_latest_mod'] = $this->url->link('module/pavblog/frontmodules', 'mod=pavbloglatest&token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_category'] = $this->url->link('module/pavblog/category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_blogs'] = $this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_add_blog'] = $this->url->link('module/pavblog/blog', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_comments'] = $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_general'] = $this->url->link('module/pavblog/modules', 'token=' . $this->session->data['token'], 'SSL');
			/* Pav blog */
			
			$this->data['zone'] = $this->url->link('localisation/zone', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['poll'] = $this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['profile_user'] = $this->url->link('user/user/update', 'token=' . $this->session->data['token'] . '&user_id=' . $this->user->getId(), 'SSL');		

            $this->data['openbay_link_extension']           = $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_orders']              = $this->url->link('extension/openbay/orderList', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_items']               = $this->url->link('extension/openbay/itemList', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay']                = $this->url->link('openbay/openbay', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay_settings']       = $this->url->link('openbay/openbay/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay_links']          = $this->url->link('openbay/openbay/viewItemLinks', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay_orderimport']    = $this->url->link('openbay/openbay/viewOrderImport', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazon']              = $this->url->link('openbay/amazon', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazon_settings']     = $this->url->link('openbay/amazon/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazon_links']        = $this->url->link('openbay/amazon/itemLinks', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazonus']            = $this->url->link('openbay/amazonus', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazonus_settings']   = $this->url->link('openbay/amazonus/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazonus_links']      = $this->url->link('openbay/amazonus/itemLinks', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_play']                = $this->url->link('openbay/play', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_play_settings']       = $this->url->link('openbay/play/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_play_report_price']   = $this->url->link('play/product/pricingReport', 'token=' . $this->session->data['token'], 'SSL');

            $this->data['openbay_markets'] = array(
                'ebay' => $this->config->get('openbay_status'),
                'amazon' => $this->config->get('amazon_status'),
                'amazonus' => $this->config->get('amazonus_status'),
                'play' => $this->config->get('play_status')
            );

			$this->data['paypal_express'] = $this->url->link('payment/pp_express', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['paypal_express_search'] = $this->url->link('payment/pp_express/search', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['recurring_profile'] = $this->url->link('sale/recurring', 'token=' . $this->session->data['token'], 'SSL');
			
			// Для неподтвержденных заказов
			$this->data['config_order_status_id'] = $this->config->get('config_order_status_id');
			
			//new customer by today 
			$this->load->model('sale/customer'); $customer_total_data = array('filter_date_added' => date('Y-m-d')); 

			$this->data['total_new_customer'] = $this->model_sale_customer->getTotalCustomers($customer_total_data); $this->data['total_customer_approval'] = $this->model_sale_customer->getTotalCustomersAwaitingApproval(); 
			$this->load->model('report/online'); 
			$this->data['total_customer_online'] = $this->model_report_online->getTotalCustomersOnline(); 

			$this->data['stores'] = array();
			
			$this->load->model('setting/store');
			
		}
		
		$this->template = 'common/header.tpl';

		$this->render();
	}
}
?>
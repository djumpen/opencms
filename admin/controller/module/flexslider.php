<?php
class ControllerModuleFlexSlider extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/flexslider');

		$this->document->setTitle(strip_tags(html_entity_decode($this->language->get('heading_title'))));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('flexslider', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_horizontal'] = $this->language->get('text_horizontal');
		$this->data['text_vertical'] = $this->language->get('text_vertical');
		$this->data['text_left'] = $this->language->get('text_left');
		$this->data['text_right'] = $this->language->get('text_right');

		$this->data['entry_slider_settings'] = $this->language->get('entry_slider_settings');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_dimension'] = $this->language->get('entry_dimension');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_slider_effects'] = $this->language->get('entry_slider_effects');
		$this->data['entry_slideshow'] = $this->language->get('entry_slideshow');
		$this->data['entry_animation'] = $this->language->get('entry_animation');
		$this->data['entry_speed'] = $this->language->get('entry_speed');
		$this->data['entry_direction'] = $this->language->get('entry_direction');
		$this->data['entry_pause'] = $this->language->get('entry_pause'); 
		$this->data['entry_slider_navigation'] = $this->language->get('entry_slider_navigation');
		$this->data['entry_direction_nav'] = $this->language->get('entry_direction_nav'); 
		$this->data['entry_control_nav'] = $this->language->get('entry_control_nav');
		$this->data['entry_touch'] = $this->language->get('entry_touch');
		$this->data['entry_mousewheel'] = $this->language->get('entry_mousewheel');
		$this->data['entry_slider_thumbnails'] = $this->language->get('entry_slider_thumbnails');
		$this->data['entry_thumbnails'] = $this->language->get('entry_thumbnails');
		$this->data['entry_item_width'] = $this->language->get('entry_item_width');
		$this->data['entry_max_items'] = $this->language->get('entry_max_items');
		$this->data['entry_min_items'] = $this->language->get('entry_min_items');
		$this->data['entry_slider_caption'] = $this->language->get('entry_slider_caption');
		$this->data['entry_caption'] = $this->language->get('entry_caption');
		$this->data['entry_caption_position'] = $this->language->get('entry_caption_position');
		$this->data['entry_caption_button'] = $this->language->get('entry_caption_button');
		$this->data['entry_button_text'] = $this->language->get('entry_button_text');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['tab_slider'] = $this->language->get('tab_slider');
		$this->data['button_add_slider'] = $this->language->get('button_add_slider');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
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
			'href'      => $this->url->link('module/flexslider', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
			);

		$this->data['action'] = $this->url->link('module/flexslider', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		$this->data['modules'] = array();

		if (isset($this->request->post['flexslider_module'])) {
			$this->data['modules'] = $this->request->post['flexslider_module'];
		} elseif ($this->config->get('flexslider_module')) { 
			$this->data['modules'] = $this->config->get('flexslider_module');
		}

		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('design/banner');

		$this->data['banners'] = $this->model_design_banner->getBanners();

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'module/flexslider.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
			);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/flexslider')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['flexslider_module'])) {
			foreach ($this->request->post['flexslider_module'] as $key => $value) {
				if (!$value['width'] || !$value['height']) {
					$this->error['dimension'][$key] = $this->language->get('error_dimension');
				}
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>
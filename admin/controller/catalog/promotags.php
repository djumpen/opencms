<?php
class ControllerCatalogPromoTags extends Controller {
	private $error = array();

  	public function index() {
		$this->load->language('catalog/promotags');

		$this->document->setTitle($this->language->get('heading_title')); 

		$this->load->model('catalog/promotags');

		$this->getList();
  	}

  	public function insert() {
    	$this->load->language('catalog/promotags');

    	$this->document->setTitle($this->language->get('heading_title')); 

		$this->load->model('catalog/promotags');

    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_promotags->addPromoTags($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->redirect($this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}

    	$this->getForm();
  	}

  	public function update() {
    	$this->load->language('catalog/promotags');

    	$this->document->setTitle($this->language->get('heading_title')); 

		$this->load->model('catalog/promotags');

    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_promotags->editPromoTags($this->request->get['promo_tags_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			$this->redirect($this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->getForm();
  	}

  	public function delete() {
    	$this->load->language('catalog/promotags');

    	$this->document->setTitle($this->language->get('heading_title')); 

		$this->load->model('catalog/promotags');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $promo_tags_id) {
				$this->model_catalog_promotags->deletePromoTags($promo_tags_id);
	  		}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->redirect($this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->getList();
  	}

  	private function getList() {
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pt.promo_text';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);

		$this->data['insert'] = $this->url->link('catalog/promotags/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('catalog/promotags/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['promotags'] = array();

		$data = array(
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'           => $this->config->get('config_admin_limit')
		);

		$this->load->model('tool/image');
		$promotags_total = $this->model_catalog_promotags->getTotalPromoTags($data);

		$results = $this->model_catalog_promotags->getPromoTags($data);
		

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/promotags/update', 'token=' . $this->session->data['token'] . '&promo_tags_id=' . $result['promo_tags_id'] . $url, 'SSL')
			);

			$_images = $this->model_catalog_promotags->getPromoTagsImages($result['promo_tags_id']);
			$images = array();
			foreach($_images as $image){
				if (file_exists(DIR_IMAGE . $image['image'])) {
					$images[] = $this->model_tool_image->resize($image['image'], 50, 50);
				} else {
					$image = $this->model_tool_image->resize('no_image.jpg', 50, 50);
				}
			}
			
			$this->data['promotags'][] = array(
				'promo_tags_id' 	=> $result['promo_tags_id'],
				'promo_text'    	=> $result['promo_text'],
				'images'			=> $images,
				'sort_order'    	=> $result['sort_order'],
		    	'selected'   		=> isset($this->request->post['selected']) && in_array($result['promo_tags_id'], $this->request->post['selected']),
				'action'     		=> $action,
			);
    	}
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');

		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_pimage'] = $this->language->get('column_pimage');
		$this->data['column_image_position'] = $this->language->get('column_image_position');
		$this->data['column_promo_text'] = $this->language->get('column_promo_text');
    	$this->data['column_promo_link'] = $this->language->get('column_promo_link');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');
	
 		$this->data['token'] = $this->session->data['token'];

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
		
		if (isset($this->request->get['filter_promo_text'])) {
			$filter_promo_text = $this->request->get['filter_promo_text'];
		} else {
			$filter_promo_text = NULL;
		}

		if (isset($this->request->get['filter_promo_link'])) {
			$filter_promo_link = $this->request->get['filter_promo_link'];
		} else {
			$filter_promo_link = NULL;
		}

		if (isset($this->request->get['filter_sort_order'])) {
			$filter_sort_order = $this->request->get['filter_sort_order'];
		} else {
			$filter_sort_order = NULL;
		}

		$url = '';

		if (isset($this->request->get['filter_promo_text'])) {
			$url .= '&filter_promo_text=' . $this->request->get['filter_promo_text'];
		}
		
		if (isset($this->request->get['filter_promo_link'])) {
			$url .= '&filter_promo_link=' . $this->request->get['filter_promo_link'];
		}

		if (isset($this->request->get['filter_sort_order'])) {
			$url .= '&filter_sort_order=' . $this->request->get['filter_sort_order'];
		} 

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_promo_text'] = $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . '&sort=pt.promo_text' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . '&sort=pt.sort_order' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $promotags_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['filter_promo_text'] = $filter_promo_text;
		$this->data['filter_promo_link'] = $filter_promo_link;
			
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/promotags_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}

  	private function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
    	$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
	
		$this->data['entry_promo_text'] = $this->language->get('entry_promo_text');
		$this->data['entry_promo_link'] = $this->language->get('entry_promo_link');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_pimage'] = $this->language->get('entry_pimage');
    	$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
    	$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_remove'] = $this->language->get('button_remove');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
		
    	$this->data['tab_general'] = $this->language->get('tab_general');
    	
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['promo_text'])) {
			$this->data['error_promo_text'] = $this->error['promo_text'];
		} else {
			$this->data['error_promo_text'] = '';
		}
		
		if (isset($this->error['promo_link'])) {
			$this->data['error_promo_link'] = $this->error['promo_link'];
		} else {
			$this->data['error_promo_link'] = '';
		}

   		if (isset($this->error['sort_order'])) {
			$this->data['error_sort_order'] = $this->error['sort_order'];
		} else {
			$this->data['error_sort_order'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_promo_text'])) {
			$url .= '&filter_promo_text=' . $this->request->get['filter_promo_text'];
		}

		if (isset($this->request->get['filter_promo_link'])) {
			$url .= '&filter_promo_link=' . $this->request->get['filter_promo_link'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
       		'text'      => $this->language->get('text_home'),
			'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . $url, 'SSL'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
   		
   		$this->load->model('localisation/language');
   		$languages = $this->model_localisation_language->getLanguages();
   		$this->data['languages'] = $languages;

		if (!isset($this->request->get['promo_tags_id'])) {
			$this->data['action'] = $this->url->link('catalog/promotags/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('catalog/promotags/update', 'token=' . $this->session->data['token'] . '&promo_tags_id=' . $this->request->get['promo_tags_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('catalog/promotags', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->get['promo_tags_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$promotags_info = $this->model_catalog_promotags->getPromoTag($this->request->get['promo_tags_id']);
    	}
		
		if (isset($this->request->post['promo_text'])) {
      		$this->data['promo_text'] = $this->request->post['promo_text'];
    	} elseif (isset($promotags_info)) {
			$this->data['promo_text'] = $promotags_info['promo_text'];
		} else {	
      		$this->data['promo_text'] = '';
    	}
		
				
		if (isset($this->request->post['sort_order'])) {
      		$this->data['sort_order'] = $this->request->post['sort_order'];
    	} elseif (isset($promotags_info)) {
			$this->data['sort_order'] = $promotags_info['sort_order'];
		} else {	
      		$this->data['sort_order'] = '';
    	}

		$this->load->model('tool/image');

		$images = array();
		if (isset($promotags_info)) {
			$promo_images = $this->model_catalog_promotags->getPromoTagsImages($this->request->get['promo_tags_id']);
			foreach($languages as $language){
				if(isset($promo_images[$language['language_id']]) && file_exists(DIR_IMAGE . $promo_images[$language['language_id']]['image'])){
					$images[$language['language_id']] = $this->model_tool_image->resize($promo_images[$language['language_id']]['image'], 100, 100);
					$images_values[$language['language_id']] = $promo_images[$language['language_id']]['image'];
				} else {
					$images[$language['language_id']] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
					$images_values[$language['language_id']] = '';
				}
			}
		} else {
			foreach($languages as $language){
				$images[$language['language_id']] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
				$images_values[$language['language_id']] = '';
			}
		}
		$this->data['images'] = $images;
		$this->data['images_values'] = $images_values;
		
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		
		$this->template = 'catalog/promotags_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  	}

  	private function validateForm() {
    	if (!$this->user->hasPermission('modify', 'catalog/promotags')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

    	if ((strlen(utf8_decode($this->request->post['promo_text'])) < 1) || (strlen(utf8_decode($this->request->post['promo_text'])) > 64)) {
      		$this->error['promo_text'] = $this->language->get('error_promo_text');
    	}

    	if (!$this->error) {
			return TRUE;
    	} else {
			if (!isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_required_data');
			}
      		return FALSE;
    	}
  	}

  	private function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'catalog/promotags')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		$this->load->model('catalog/promotags');

		foreach ($this->request->post['selected'] as $promotags_id) {
  			$promotags_top_right = $this->model_catalog_promotags->getTotalProductsByPromoTagsTopRightId($promotags_id);

			if ($promotags_top_right) {
	  			$this->error['warning'] = sprintf($this->language->get('error_promotags'), $promotags_top_right);	
			}
	  	} 
		
		if (!$this->error) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
  	}

}
?>
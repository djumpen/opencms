<?php 

/*******************************************************************************
*                                 Opencart SEO Pack                            *
*                             � Copyright Ovidiu Fechete                       *
*                              email: ovife21@gmail.com                        *
*                Below source-code or any part of the source-code              *
*                          cannot be resold or distributed.                    *
*******************************************************************************/


class ControllerCatalogSeoEditor extends Controller {
	private $error = array(); 
     
  	public function index() {
		$this->load->language('catalog/seoeditor');
                if (!isset($this->session->data['language_id'])) {
			$this->session->data['language_id'] = $this->config->get('config_language_id');
		}
    	
		$this->document->setTitle($this->language->get('heading_title')); 
		
		$this->load->model('catalog/seoeditor');
		
		$this->getList();
  	}
  
  		
  	private function getList() {				
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['filter_type'])) {
			$filter_type = $this->request->get['filter_type'];
		} else {
			$filter_type = null;
		}
		
		if (isset($this->request->get['filter_keyword'])) {
			$filter_keyword = $this->request->get['filter_keyword'];
		} else {
			$filter_keyword = null;
		}

		if (isset($this->request->get['filter_meta_description'])) {
			$filter_meta_description = $this->request->get['filter_meta_description'];
		} else {
			$filter_meta_description = null;
		}

		if (isset($this->request->get['filter_custom_title'])) {
		    $filter_custom_title = $this->request->get['filter_custom_title'];
		} else {
		    $filter_custom_title = null;
		}
		
		if (isset($this->request->get['filter_meta_keyword'])) {
			$filter_meta_keyword = $this->request->get['filter_meta_keyword'];
		} else {
			$filter_meta_keyword = null;
		}
		
		if (isset($this->request->get['filter_tags'])) {
			$filter_tags = $this->request->get['filter_tags'];
		} else {
			$filter_tags = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'type desc, name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
						
		$url = '';
						
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}
		
		if (isset($this->request->get['filter_meta_description'])) {
			$url .= '&filter_meta_description=' . $this->request->get['filter_meta_description'];
		}
		if (isset($this->request->get['filter_custom_title'])) {
		    $url .= '&filter_custom_title=' . $this->request->get['filter_custom_title'];
		}
		
		if (isset($this->request->get['filter_meta_keyword'])) {
			$url .= '&filter_meta_keyword=' . $this->request->get['filter_meta_keyword'];
		}		

		if (isset($this->request->get['filter_tags'])) {
			$url .= '&filter_tags=' . $this->request->get['filter_tags'];
		}
						
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . $url, 'SSL'),       		
      		'separator' => ' :: '
   		);
		
		
		$this->data['products'] = array();

		$data = array(
			'filter_type'	  => $filter_type, 
			'filter_name'	  => $filter_name, 
			'filter_keyword'  => $filter_keyword,
			'filter_meta_description'	  => $filter_meta_description,
            'filter_custom_title' => $filter_custom_title,
			'filter_meta_keyword' => $filter_meta_keyword,
			'filter_tags'   => $filter_tags,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'           => $this->config->get('config_admin_limit')
		);
		
		
		$product_total = $this->model_catalog_seoeditor->getTotalSEOs($data);
			
		$results = $this->model_catalog_seoeditor->getSEOs($data);
						    	
		foreach ($results as $result) {
			$action = array();
			
			
			
	
      		$this->data['products'][] = array(

				'id' => $result['id'],
				'name'       => $result['name'],
				'type'      => $result['type'],
				'keyword'      => $result['keyword'],
                'custom_title'      => $result['custom_title'],
				'meta_keyword'      => $result['meta_keyword'],
				'meta_description'      => $result['meta_description'],
				'tags'      => $result['tags']
				
			);
    	}
		
                $this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->data['heading_title'] = $this->language->get('heading_title');		
				
		$this->data['text_enabled'] = $this->language->get('text_enabled');		
		$this->data['text_disabled'] = $this->language->get('text_disabled');		
		$this->data['text_no_results'] = $this->language->get('text_no_results');		
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');		
			
		$this->data['column_type'] = $this->language->get('column_type');		
		$this->data['column_name'] = $this->language->get('column_name');		
		$this->data['column_keyword'] = $this->language->get('column_keyword');		
		$this->data['column_custom_title'] = 'Custom Title';
		$this->data['column_meta_keyword'] = $this->language->get('column_meta_keyword');		
		$this->data['column_meta_description'] = $this->language->get('column_meta_description');		
		$this->data['column_tags'] = $this->language->get('column_tags');		
				
		$this->data['button_copy'] = $this->language->get('button_copy');		
		$this->data['button_insert'] = $this->language->get('button_insert');		
		$this->data['button_delete'] = $this->language->get('button_delete');		
		$this->data['button_filter'] = $this->language->get('button_filter');
		 
                $this->data['action'] = $this->url->link('catalog/seoeditor/changeLanguage&token=', 'token=' . $this->session->data['token'].'&lang=', 'SSL');
		
		if (!isset($this->session->data['language_id'])) {
			$this->session->data['language_id'] = $this->config->get('config_language_id');
		}
		
		foreach ($this->data['languages'] as $language) {
			if ($language['language_id'] == $this->session->data['language_id']) 
			{
				$this->data['selected_language'] = $language['name']; 
				$this->data['selected_language_id'] = $language['language_id'];
			}
		}
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

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_keyword'])) {
			$url .= '&filter_keyword=' . $this->request->get['filter_keyword'];
		}
		
		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . $this->request->get['filter_model'];
		}
		
		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}
		
		if (isset($this->request->get['filter_quantity'])) {
			$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
								
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
					
		$this->data['sort_name'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_type'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=type' . $url, 'SSL');
		$this->data['sort_keyword'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=keyword' . $url, 'SSL');
		$this->data['sort_custom_title'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=custom_title' . $url, 'SSL');
		$this->data['sort_meta_keyword'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=meta_keyword' . $url, 'SSL');
		$this->data['sort_meta_description'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=meta_description' . $url, 'SSL');
		$this->data['sort_tags'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . '&sort=tags' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}
		
		if (isset($this->request->get['filter_keyword'])) {
			$url .= '&filter_keyword=' . $this->request->get['filter_keyword'];
		}
		if (isset($this->request->get['filter_custom_title'])) {
		    $url .= '&filter_custom_title=' . $this->request->get['filter_custom_title'];
		}
		if (isset($this->request->get['filter_meta_keyword'])) {
			$url .= '&filter_meta_keyword=' . $this->request->get['filter_meta_keyword'];
		}
		
		if (isset($this->request->get['filter_meta_description'])) {
			$url .= '&filter_meta_description=' . $this->request->get['filter_meta_description'];
		}
		
		if (isset($this->request->get['filter_tags'])) {
			$url .= '&filter_tags=' . $this->request->get['filter_tags'];
		}


		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
				
		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
	
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_type'] = $filter_type;
		$this->data['filter_keyword'] = $filter_keyword;
		$this->data['filter_meta_keyword'] = $filter_meta_keyword;
		$this->data['filter_custom_title'] = $filter_custom_title;
		$this->data['filter_meta_description'] = $filter_meta_description;
		$this->data['filter_tags'] = $filter_tags;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/seoeditor.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}

		
	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_keyword']) || isset($this->request->get['filter_meta_keyword']) || isset($this->request->get['filter_custom_title']) || isset($this->request->get['filter_meta_description']) || isset($this->request->get['filter_tags']) || isset($this->request->get['filter_category_id'])) {
			$this->load->model('catalog/seoeditor');
			
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			
			if (isset($this->request->get['filter_keyword'])) {
				$filter_keyword = $this->request->get['filter_keyword'];
			} else {
				$filter_keyword = '';
			}
			
			if (isset($this->request->get['filter_custom_title'])) {
			    $filter_custom_title = $this->request->get['filter_custom_title'];
			} else {
			    $filter_custom_title = null;
			}
			
			if (isset($this->request->get['filter_meta_keyword'])) {
				$filter_meta_keyword = $this->request->get['filter_meta_keyword'];
			} else {
				$filter_meta_keyword = '';
			}
			
			if (isset($this->request->get['filter_meta_description'])) {
				$filter_meta_description = $this->request->get['filter_meta_description'];
			} else {
				$filter_meta_description = '';
			}
			
			if (isset($this->request->get['filter_tags'])) {
				$filter_tags = $this->request->get['filter_tags'];
			} else {
				$filter_tags = '';
			}
			
			
									
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];	
			} else {
				$limit = 20;	
			}			
						
			$data = array(
				'filter_name'         => $filter_name,
				'filter_keyword'      => $filter_keyword,
                'filter_custom_title'      => $filter_custom_title,
				'filter_meta_keyword'      => $filter_meta_keyword,
				'filter_meta_description'      => $filter_meta_description,
				'filter_tags'      => $filter_tags,
				
				'start'               => 0,
				'limit'               => $limit
			);
			
			$results = $this->model_catalog_seoeditor->getSEOs($data);
			
			foreach ($results as $result) {
				
				
				$json[] = array(
					'id' => $result['id'],
					'name'       => html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'),	
					'keyword'      => html_entity_decode($result['keyword'], ENT_QUOTES, 'UTF-8'),
	                'custom_title'      => html_entity_decode($result['custom_title'], ENT_QUOTES, 'UTF-8'),
					'meta_keyword'      => html_entity_decode($result['meta_keyword'], ENT_QUOTES, 'UTF-8'),
					'meta_description'      => html_entity_decode($result['meta_description'], ENT_QUOTES, 'UTF-8'),
					'tags'      => html_entity_decode($result['tags'], ENT_QUOTES, 'UTF-8')
					
				);	
			}
		}

		$this->response->setOutput(json_encode($json));
	}
    
	public function changeLanguage()
    {
        $this->session->data['language_id'] = $this->request->get['lang']; 
		$this->session->data['token'] = $this->request->get['token'];        
        $this->redirect($this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'], 'SSL'));
    }
	
	
	
}
?>
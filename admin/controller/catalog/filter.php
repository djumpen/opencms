<?php
class ControllerCatalogFilter extends Controller {
	private $error = array();
  private $url_data = array('filter_name','filter_type','filter_status','filter_category_id','page','sort','order');

	public function index() {
		$this->load->language('catalog/filter');
		
		$this->document->setTitle($this->language->get('heading_title'));

    $this->load->model('catalog/filter');
		
    $this->data['language_id'] = $this->config->get('config_language_id');
    
		$this->getList();
	}

	public function insert() {
		$this->load->language('catalog/filter');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/filter');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
		  $this->model_catalog_filter->addOption($this->request->post);

      $this->session->data['success'] = $this->language->get('text_success');

      $url = '';

      foreach ($this->url_data as $key) {
        if (isset($this->request->get[$key])) $url .= '&' . $key .'=' . $this->request->get[$key];
      }

			$this->redirect($this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		
		$this->getForm();
	}

	public function update() {
		$this->load->language('catalog/filter');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/filter');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      $this->model_catalog_filter->editOption($this->request->get['option_id'], $this->request->post);

 			$this->session->data['success'] = $this->language->get('text_success');

      $url = '';

      foreach ($this->url_data as $key) {
        if (isset($this->request->get[$key])) $url .= '&' . $key .'=' . $this->request->get[$key];
      }

			$this->redirect($this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		
		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/filter');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/filter');
		
		if (isset($this->request->post['selected'])) {

      foreach ($this->request->post['selected'] as $option_id) {
				$this->model_catalog_filter->deleteOption($option_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

      $url = '';

      foreach ($this->url_data as $key) {
        if (isset($this->request->get[$key])) $url .= '&' . $key .'=' . $this->request->get[$key];
      }

			$this->redirect($this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		
		$this->getList();
	}

	private function getList() {

    $this->document->addStyle('view/stylesheet/filter/filter.css');

    foreach ($this->url_data as $key) {
      if (isset($this->request->get[$key])) {
        $$key = $this->request->get[$key];
      } else {
        $$key = null;
      }
    }

 		$this->data['breadcrumbs'] = array();

 		$this->data['breadcrumbs'][] = array(
     	'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
     	'text'      => $this->language->get('text_home'),
    	'separator' => FALSE
 		);

 		$this->data['breadcrumbs'][] = array(
     	'href'      => $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL'),
     	'text'      => $this->language->get('heading_title'),
    	'separator' => ' :: '
 		);

    $url = '';

    foreach ($this->url_data as $key) {
      if (isset($this->request->get[$key])) $url .= '&' . $key .'=' . $this->request->get[$key];
    }

		$this->data['insert'] = $this->url->link('catalog/filter/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('catalog/filter/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
    $this->data['export'] = $this->url->link('catalog/filter/export', 'token=' . $this->session->data['token'] . $url, 'SSL');

    $this->data['options'] = array();

    # Set arguments data array
    $data = array();

    foreach ($this->url_data as $key) {
      $data[$key] = $$key;
    }

    $data['start'] = ($page - 1) * $this->config->get('config_admin_limit');
    $data['limit'] = $this->config->get('config_admin_limit');

    $option_total = $this->model_catalog_filter->getTotalOptions($data);

		$results = $this->model_catalog_filter->getOptions($data);

    $visible = 5;

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/filter/update', 'token=' . $this->session->data['token'] . '&option_id=' . $result['option_id'] . $url, 'SSL')
			);

      $values = array();
      foreach ($result['values'] as $value) { $values[] = $value['name']; }

      if ($values) {
        if (count($values) > $visible) {
          $values = array_slice($values, 0, $visible);

          $values[$visible-1] .= $result['postfix'] . sprintf($this->language->get('text_and_more'), (count($result['values']) - $visible));
        } else {
          $values[count($values)-1] .= $result['postfix'];
        }
      }

      $categories = array();
      foreach ($result['categories'] as $category) { $categories[] = $category['name']; }

      if (count($categories) > $visible) {
        $categories = array_slice($categories, 0, $visible);

        $categories[$visible-1] .= sprintf($this->language->get('text_and_more'), (count($result['categories']) - $visible));
      }

			$this->data['options'][] = array(
				'option_id'     => $result['option_id'],
				'name'          => $result['name'],
        'type'          => $result['type'],
				'sort_order'    => $result['sort_order'],
				'selected'      => isset($this->request->post['selected']) && in_array($result['option_id'], $this->request->post['selected']),
        'values'        => implode(' &bull; ', $values),
        'categories'    => implode(' &bull; ', $categories),
        'status'        => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
        'action'        => $action
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
    $this->data['text_none'] = $this->language->get('text_none');
    $this->data['text_enabled'] = $this->language->get('text_enabled');
    $this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_categories'] = $this->language->get('column_categories');
		$this->data['column_values'] = $this->language->get('column_values');
    $this->data['column_type'] = $this->language->get('column_type');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_status'] = $this->language->get('column_status');
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

    $url = '';

    foreach ($this->url_data as $key) {
      if (isset($this->request->get[$key]) && $key != 'sort' && $key != 'order') { $url .= '&' . $key .'=' . $this->request->get[$key]; }
    }

    if ($order == 'ASC') {
      $url .= '&order=DESC';
    } else {
      $url .= '&order=ASC';
    }

    $this->data['sort_name'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . '&sort=cod.name' . $url, 'SSL');
    $this->data['sort_type'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . '&sort=co.type' . $url, 'SSL');
    $this->data['sort_category_id'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . '&sort=co2c.category_id' . $url, 'SSL');
    $this->data['sort_status'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . '&sort=co.status' . $url, 'SSL');
    $this->data['sort_order'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . '&sort=co.sort_order' . $url, 'SSL');

    $url = '';

    foreach ($this->url_data as $key) {
      if (isset($this->request->get[$key]) && $key != 'page') { $url .= '&' . $key .'=' . $this->request->get[$key]; }
    }

    $pagination = new Pagination();
    $pagination->total = $option_total;
    $pagination->page = $page;
    $pagination->limit = $this->config->get('config_admin_limit');
    $pagination->text = $this->language->get('text_pagination');
    $pagination->url = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

    $this->data['pagination'] = $pagination->render();

    # Set variables

    foreach ($this->url_data as $key) {
      $this->data[$key] = $$key;
    }

    $this->data['types'] = array(
      'checkbox' => 'Checkbox',
      'select'   => 'Select',
      'radio'    => 'Radio',
      'group'    => 'Group'
    );

    # Set filter variables for js
    $this->data['filter_url_data'] = array();

    foreach ($this->url_data as $key => $value) {
      if ($value != 'sort' && $value != 'order' && $value != 'page') { $this->data['filter_url_data'][] = $this->url_data[$key]; }
    }

    $this->data['categories'] = $this->getCategories(0);

		$this->template = 'catalog/filter_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}

	private function getForm() {
    $this->document->addStyle('view/stylesheet/filter/filter.css');

    $this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_delete'] = $this->language->get('text_delete');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_add_value'] = $this->language->get('text_add_value');
		$this->data['text_value'] = $this->language->get('text_value');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
    $this->data['text_disabled'] = $this->language->get('text_disabled');
    $this->data['text_select_all'] = $this->language->get('text_select_all');
		$this->data['text_unselect_all'] = $this->language->get('text_unselect_all');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_child'] = $this->language->get('entry_child');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_postfix'] = $this->language->get('entry_postfix');
		$this->data['entry_type'] = $this->language->get('entry_type');
		$this->data['entry_group_count'] = $this->language->get('entry_group_count');
		$this->data['entry_values'] = $this->language->get('entry_values');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_category'] = $this->language->get('entry_category');
		$this->data['entry_status'] = $this->language->get('entry_status');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

		$this->data['breadcrumbs'] = array();

 		$this->data['breadcrumbs'][] = array(
     	'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
     	'text'      => $this->language->get('text_home'),
    	'separator' => FALSE
 		);

 		$this->data['breadcrumbs'][] = array(
     	'href'      => $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL'),
     	'text'      => $this->language->get('heading_title'),
    	'separator' => ' :: '
 		);

    $url = '';

    foreach ($this->url_data as $key) {
      if (isset($this->request->get[$key])) $url .= '&' . $key .'=' . $this->request->get[$key];
    }

		if (!isset($this->request->get['option_id'])) {
			$this->data['action'] = $this->url->link('catalog/filter/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('catalog/filter/update', 'token=' . $this->session->data['token'] . '&option_id=' . $this->request->get['option_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
    

    if (isset($this->request->get['option_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      $option_info = $this->model_catalog_filter->getOption($this->request->get['option_id']);
    }

    if (isset($this->request->post['name'])) {
      $this->data['name'] = $this->request->post['name'];
    } elseif (isset($this->request->get['option_id'])) {
      $option_description = $this->model_catalog_filter->getOptionDescriptions($this->request->get['option_id']);

      $this->data['name'] = $option_description;

      $this->data['breadcrumbs'][] = array(
       	'href'      => $this->url->link('catalog/filter/update', 'token=' . $this->session->data['token'] . '&option_id=' . $this->request->get['option_id'], 'SSL'),
       	'text'      => $option_description[$this->config->get('config_language_id')]['name'],
      	'separator' => ' :: '
   		);
    } else {
      $this->data['name'] = array();
    }

    if (isset($this->request->post['option_values'])) {
      $this->data['option_values'] = $this->request->post['option_values'];
    } elseif (isset($this->request->get['option_id'])) {
      $this->data['option_values'] = $this->model_catalog_filter->getOptionValues($this->request->get['option_id']);
    } else {
      $this->data['option_values'] = array();
    }

    if (isset($this->request->post['sort_order'])) {
      $this->data['sort_order'] = $this->request->post['sort_order'];
    } elseif (isset($option_info)) {
      $this->data['sort_order'] = $option_info['sort_order'];
    } else {
      $this->data['sort_order'] = 0;
    }
    
    if (isset($this->request->post['status'])) {
      $this->data['status'] = $this->request->post['status'];
    } elseif (isset($option_info)) {
      $this->data['status'] = $option_info['status'];
    } else {
      $this->data['status'] = 1;
    }

    $this->data['types'] = array(
      'checkbox' => 'Checkbox',
      'select'   => 'Select',
      'radio'    => 'Radio',
      'group'    => 'Group'
    );
    
    if (isset($this->request->post['type'])) {
      $this->data['type'] = $this->request->post['type'];
    } elseif (isset($option_info)) {
      $this->data['type'] = $option_info['type'];
    } else {
      $this->data['type'] = '';
    }
    
    if (isset($this->request->post['group_count'])) {
      $this->data['group_count'] = $this->request->post['group_count'];
    } elseif (isset($option_info)) {
      $this->data['group_count'] = $option_info['group_count'];
    } else {
      $this->data['group_count'] = 3;
    }

    $this->data['categories'] = $this->getCategories(0);

    if (isset($this->request->post['option_categories'])) {
      $this->data['option_categories'] = $this->request->post['option_categories'];
    } elseif (isset($option_info)) {
      $this->data['option_categories'] = $this->model_catalog_filter->getOptionCategories($this->request->get['option_id']);
    } else {
      $this->data['option_categories'] = array();
    }
    
    $this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['option_store'])) {
			$this->data['option_store'] = $this->request->post['option_store'];
		} elseif (isset($this->request->get['option_id'])) {
			$this->data['option_store'] = $this->model_catalog_filter->getOptionStores($this->request->get['option_id']);
		} else {
			$this->data['option_store'] = array(0);
		}

		$this->template = 'catalog/filter_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}

  public function callback() {
    $json = array();

    $this->load->language('catalog/filter');
    $this->load->model('catalog/filter');

    $json['message'] = '';
    $json['options'] = array();

    if (isset($this->request->get['category_id'])) {

  		if (isset($this->request->get['product_id'])) {
  			$product_to_value_id = $this->model_catalog_filter->getProductValues($this->request->get['product_id']);
  		} else {
  			$product_to_value_id = array();
  		}

		  $results = $this->model_catalog_filter->getOptionsByCategoryId($this->request->get['category_id']);

			if ($results) {
			  foreach($results as $option) {

          $values_results = $this->model_catalog_filter->getOptionValues($option['option_id']);

          $values = array();

          foreach ($values_results as $value) {
            $values[] = array(
              'value_id'  => $value['value_id'],
              'name'      => $value['language'][$this->config->get('config_language_id')]['name'],
              'selected'  => in_array($value['value_id'], $product_to_value_id)
            );
          }

          $json['options'][] = array(
            'option_id' => $option['option_id'],
            'name'      => $option['name'],
            'postfix'   => $option['postfix'],
            'status'    => $option['status'],
            'values'    => $values
          );
        }
      } else {
        $json['message'] = $this->language->get('text_no_options');
      }
		} else {
      $json['message'] = $this->language->get('text_select_category');
    }

    $this->response->setOutput(json_encode($json));
  }

  public function export() {
    $this->load->language('catalog/filter');

    $this->response->addheader('Pragma: public');
		$this->response->addheader('Expires: 0');
		$this->response->addheader('Content-Description: File Transfer');
		$this->response->addheader('Content-Type: application/octet-stream');
		$this->response->addheader('Content-Disposition: attachment; filename=filter_backup_' . date('d_m_Y_H_i_s') . '.sql');
		$this->response->addheader('Content-Transfer-Encoding: binary');

		$this->load->model('catalog/filter');

		$this->response->setOutput($this->model_catalog_filter->backup());
  }
	
  private function getCategories($parent_id, $level = -1) {
    $level++;

    $results = $this->model_catalog_filter->getCategoriesByParentId($parent_id);

    $categories_data = array();

    foreach ($results as $result) {
      $categories_data[] = array(
        'category_id' => $result['category_id'],
        'name'        => $result['name'],
        'level'       => $level
      );

      $categories_data = array_merge($categories_data, $this->getCategories($result['category_id'], $level));
    }

    return $categories_data;
  }

  public function edit() {
    if ($this->request->server['REQUEST_METHOD'] == 'POST') {

      if ($this->request->post['field'] == 'name') {
        $this->db->query("UPDATE " . DB_PREFIX . "category_option_description SET name = '" . $this->db->escape($this->request->post['value']) . "' WHERE option_id = '" . (int)$this->request->post['option_id'] . "' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");
      } else {
        $this->db->query("UPDATE " . DB_PREFIX . "category_option SET `" . $this->db->escape($this->request->post['field']) . "` = '" . $this->db->escape($this->request->post['value']) . "' WHERE option_id = '" . (int)$this->request->post['option_id'] . "'");
      }

      $this->cache->delete('option');
    }
  }

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/filter')) {
			$this->error['warning'] = $this->language->get('error_permission');
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
}
?>
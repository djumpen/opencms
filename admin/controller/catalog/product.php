<?php 
class ControllerCatalogProduct extends Controller {
	private $error = array(); 

	public function index() {
		$this->language->load('catalog/product');
		$this->document->setTitle($this->language->get('heading_title')); 
		$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "url_alias WHERE field = 'language_id'");
		
		$exists = 0;
		foreach ($query->rows as $index) {$exists++;}
		
		if (!$exists) {$this->db->query("ALTER TABLE " . DB_PREFIX . "url_alias ADD COLUMN `language_id` int(11) NOT NULL DEFAULT '". $this->config->get('config_language_id') ."';");}

		$this->load->model('catalog/product');
		
		$this->getList();
	}

	public function insert() {
		$this->language->load('catalog/product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');
		
		$this->document->addScript(SCRIPT_FOLDER . 'pnotify.custom.min.js');
		$this->document->addStyle(STYLE_FOLDER . 'pnotify.custom.min.css');
		$this->document->addStyle(STYLE_FOLDER . 'oc_menu.css');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_product->addProduct($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_model'])) {
				$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->language->load('catalog/product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_product->editProduct($this->request->get['product_id'], $this->request->post);

			$this->openbay->productUpdateListen($this->request->get['product_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_model'])) {
				$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->language->load('catalog/product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $product_id) {
				$this->model_catalog_product->deleteProduct($product_id);
				$this->openbay->deleteProduct($product_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_model'])) {
				$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	public function copy() {
		$this->language->load('catalog/product');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');

		if (isset($this->request->post['selected']) && $this->validateCopy()) {
			foreach ($this->request->post['selected'] as $product_id) {
				$this->model_catalog_product->copyProduct($product_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_model'])) {
				$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
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

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		$this->document->addScript(SCRIPT_FOLDER . 'live_product_category_edit.js');


		$this->data['fastUpdateAction'] = $this->url->link('catalog/product/fastUpdate', 'token=' . $this->session->data['token'], 'SSL');
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}
		
		if (isset($this->request->get['filter_by_id'])) {
			$filter_by_id = $this->request->get['filter_by_id'];
		} else {
			$filter_by_id = null;
		}

		if (isset($this->request->get['filter_model'])) {
			$filter_model = $this->request->get['filter_model'];
		} else {
			$filter_model = null;
		}
		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
		} else {
			$filter_category = null;
		}

		if (isset($this->request->get['filter_price'])) {
			$filter_price = $this->request->get['filter_price'];
		} else {
			$filter_price = null;
		}

		if (isset($this->request->get['filter_quantity'])) {
			$filter_quantity = $this->request->get['filter_quantity'];
		} else {
			$filter_quantity = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
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
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		
		if (isset($this->request->get['filter_by_id'])) {
			$url .= '&filter_by_id=' . $this->request->get['filter_by_id'];
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
			'href'      => $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL'),       		
			'separator' => ' :: '
			);

		$this->data['insert'] = $this->url->link('catalog/product/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['copy'] = $this->url->link('catalog/product/copy', 'token=' . $this->session->data['token'] . $url, 'SSL');	
		$this->data['delete'] = $this->url->link('catalog/product/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['products'] = array();

		$data = array(
			'filter_name'	     => $filter_name, 
			'filter_by_id'	     => $filter_by_id, 
			'filter_model'	     => $filter_model,
			'filter_price'	     => $filter_price,
			'filter_quantity'    => $filter_quantity,
			'filter_status'      => $filter_status,
			'filter_category_id' => $filter_category,
			'filter_date_added' => $filter_date_added,
			'sort'               => $sort,
			'order'              => $order,
			'start'              => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'              => $this->config->get('config_admin_limit')
			);
		$this->load->model('tool/image');
		$this->load->model('catalog/category');
		$product_total = $this->model_catalog_product->getTotalProducts($data);
		$results = $this->model_catalog_product->getProducts($data);
		$filter_categories = $this->model_catalog_category->getCategories(0);

		/* Filter product by category */
		$this->data['filter_categories'] = array();
		foreach ($filter_categories as $filter_category) {
			$this->data['filter_categories'][] = array(
				'category_id' => $filter_category['category_id'],
				'name'        => $filter_category['name'],
				'active'      => (isset($this->request->get['filter_category']) && ($this->request->get['filter_category'] == $filter_category['category_id'])),
				'href'        => $this->url->link('catalog/product', 'filter_category=' . $filter_category['category_id'] . '&token=' . $this->session->data['token'], 'SSL'),
				);
		}
		/* Filter product by category */
		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'] . $url, 'SSL')
				);

			$categories = $this->model_catalog_product->getProductCategories($result['product_id']);
			/* Filter product by category */
			$product_categories = array();
			if($categories) {
				foreach ($categories as $category) {
					$category = $this->model_catalog_category->getCategory($category);
					$product_categories[] = array(
						'name' => $this->model_catalog_category->getCategoryFullName($category['category_id']),
						'category_id' => $category['category_id'],
						);
				}
			}
			/* Filter product by category */
			if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
			}

			$special = false;

			$product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);

			foreach ($product_specials  as $product_special) {
				if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] <= date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] >= date('Y-m-d'))) {
					$special = $product_special['price'];

					break;
				}					
			}

			$this->data['products'][] = array(
				'product_id'     => $result['product_id'],
				'name'           => $result['name'],
				/* Filter product by category */
				'categories'     => $product_categories,
				/* Filter product by category */
				'model'          => $result['model'],
				'price'          => $result['price'],
				'special'        => $special,
				'image'          => $image,
				'original_image' => $result['image'],
				'quantity'       => $result['quantity'],
				'date_added'	 => $result['date_added'],
				'status'         => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'selected'       => isset($this->request->post['selected']) && in_array($result['product_id'], $this->request->post['selected']),
				'action'         => $action
				);
		}
		
		$this->applyLangVars();

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
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
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

		$this->data['sort_name'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, 'SSL');
		$this->data['sort_model'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=p.model' . $url, 'SSL');
		$this->data['sort_price'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=p.price' . $url, 'SSL');
		$this->data['sort_quantity'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=p.quantity' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=p.status' . $url, 'SSL');
		$this->data['sort_order'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=p.sort_order' . $url, 'SSL');
		$this->data['sort_date'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&sort=p.date_added' . $url, 'SSL'); 

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . urlencode(html_entity_decode($this->request->get['filter_category'], ENT_QUOTES, 'UTF-8'));
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
		$pagination->url = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['filter_name'] = $filter_name;
		$this->data['filter_model'] = $filter_model;
		$this->data['filter_price'] = $filter_price;
		$this->data['filter_quantity'] = $filter_quantity;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_date_added'] = $filter_date_added;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/product_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
			);

		$this->response->setOutput($this->render());
	}

	protected function getForm() {

	    # Filter start
		$this->document->addStyle('view/stylesheet/filter/filter.css');
	    # Filter end

// 		$this->document->addScript(SCRIPT_FOLDER . 'bootstrap-datetimepicker.min.js');
		$this->document->addScript(SCRIPT_FOLDER . 'moment-with-locales.js');
		$this->document->addScript(SCRIPT_FOLDER . 'bootstrap-datetimepicker.js');
		$this->document->addStyle(STYLE_FOLDER . 'bootstrap-datetimepicker.min.css');

		$this->applyLangVars();
		
		// Dependent Option errors
		if (isset($this->error['duplicate_option'])) {
			$this->data['error_duplicate_option'] = $this->error['duplicate_option'];
		} else {
			$this->data['error_duplicate_option'] = array();
		}
		
		if (isset($this->error['duplicate_option_value'])) {
			$this->data['error_duplicate_option_value'] = $this->error['duplicate_option_value'];
		} else {
			$this->data['error_duplicate_option_value'] = array();
		}
		
		if (isset($this->error['parent_option_recursion'])) {
			$this->data['error_parent_option_recursion'] = $this->error['parent_option_recursion'];
		} else {
			$this->data['error_parent_option_recursion'] = array();
		}
		
		if (isset($this->error['ajax_option_value_failure'])) {
			$this->data['error_ajax_option_value_failure'] = $this->error['ajax_option_value_failure'];
		} else {
			$this->data['error_ajax_option_value_failure'] = array();
		}
		
		if (isset($this->error['no_option_values_set'])) {
			$this->data['error_no_option_values_set'] = $this->error['no_option_values_set'];
		} else {
			$this->data['error_no_option_values_set'] = array();
		}
		
		if (isset($this->error['no_parent_option_values_set'])) {
			$this->data['error_no_parent_option_values_set'] = $this->error['no_parent_option_values_set'];
		} else {
			$this->data['error_no_parent_option_values_set'] = array();
		}
		
		if (isset($this->error['required_option_parents'])) {
			$this->data['error_required_option_parents'] = $this->error['required_option_parents'];
		} else {
			$this->data['error_required_option_parents'] = '';
		}
		
		if (isset($this->error['missing_option'])) {
			$this->data['error_missing_option'] = $this->error['missing_option'];
		} else {
			$this->data['error_missing_option'] = array();
		}
		
		if (isset($this->error['parent_option_stock_level'])) {
			$this->data['error_parent_option_stock_level'] = $this->error['parent_option_stock_level'];
		} else {
			$this->data['error_parent_option_stock_level'] = array();
		}
		
		if (isset($this->error['missing_option_value'])) {
			$this->data['error_missing_option_value'] = $this->error['missing_option_value'];
		} else {
			$this->data['error_missing_option_value'] = array();
		}
		$this->data['tab_marketplace_links'] = $this->language->get('tab_marketplace_links');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}

		if (isset($this->error['custom_title'])) {
			$this->data['error_custom_title'] = $this->error['custom_title'];
		} else {
			$this->data['error_custom_title'] = array();
		}
		
		if (isset($this->error['custom_h1'])) {
			$this->data['error_custom_h1'] = $this->error['custom_h1'];
		} else {
			$this->data['error_custom_h1'] = array();
		}
		
		if (isset($this->error['custom_alt'])) {
			$this->data['error_custom_alt'] = $this->error['custom_alt'];
		} else {
			$this->data['error_custom_alt'] = array();
		}
		
		if (isset($this->error['meta_description'])) {
			$this->data['error_meta_description'] = $this->error['meta_description'];
		} else {
			$this->data['error_meta_description'] = array();
		}		

		if (isset($this->error['description'])) {
			$this->data['error_description'] = $this->error['description'];
		} else {
			$this->data['error_description'] = array();
		}	

		if (isset($this->error['model'])) {
			$this->data['error_model'] = $this->error['model'];
		} else {
			$this->data['error_model'] = '';
		}		

		if (isset($this->error['date_available'])) {
			$this->data['error_date_available'] = $this->error['date_available'];
		} else {
			$this->data['error_date_available'] = '';
		}	

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
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
			'href'      => $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'separator' => ' :: '
			);

		if (!isset($this->request->get['product_id'])) {
			$this->data['action'] = $this->url->link('catalog/product/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $this->request->get['product_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['product_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
		}

		$this->data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['product_description'])) {
			$this->data['product_description'] = $this->request->post['product_description'];
		} elseif (isset($this->request->get['product_id'])) {
			$this->data['product_description'] = $this->model_catalog_product->getProductDescriptions($this->request->get['product_id']);
		} else {
			$this->data['product_description'] = array();
		}

		if (isset($this->request->post['model'])) {
			$this->data['model'] = $this->request->post['model'];
		} elseif (!empty($product_info)) {
			$this->data['model'] = $product_info['model'];
		} else {
			$this->data['model'] = '';
		}
		
		if (isset($this->request->post['sku'])) {
			$this->data['sku'] = $this->request->post['sku'];
		} elseif (!empty($product_info)) {
			$this->data['sku'] = $product_info['sku'];
		} else {
			$this->data['sku'] = '';
		}

		if (isset($this->request->post['upc'])) {
			$this->data['upc'] = $this->request->post['upc'];
		} elseif (!empty($product_info)) {
			$this->data['upc'] = $product_info['upc'];
		} else {
			$this->data['upc'] = '';
		}

		if (isset($this->request->post['ean'])) {
			$this->data['ean'] = $this->request->post['ean'];
		} elseif (!empty($product_info)) {
			$this->data['ean'] = $product_info['ean'];
		} else {
			$this->data['ean'] = '';
		}

		if (isset($this->request->post['jan'])) {
			$this->data['jan'] = $this->request->post['jan'];
		} elseif (!empty($product_info)) {
			$this->data['jan'] = $product_info['jan'];
		} else {
			$this->data['jan'] = '';
		}

		if (isset($this->request->post['isbn'])) {
			$this->data['isbn'] = $this->request->post['isbn'];
		} elseif (!empty($product_info)) {
			$this->data['isbn'] = $product_info['isbn'];
		} else {
			$this->data['isbn'] = '';
		}

		if (isset($this->request->post['mpn'])) {
			$this->data['mpn'] = $this->request->post['mpn'];
		} elseif (!empty($product_info)) {
			$this->data['mpn'] = $product_info['mpn'];
		} else {
			$this->data['mpn'] = '';
		}

		if (isset($this->request->post['location'])) {
			$this->data['location'] = $this->request->post['location'];
		} elseif (!empty($product_info)) {
			$this->data['location'] = $product_info['location'];
		} else {
			$this->data['location'] = '';
		}

		$this->load->model('setting/store');

		$this->data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['product_store'])) {
			$this->data['product_store'] = $this->request->post['product_store'];
		} elseif (isset($this->request->get['product_id'])) {
			$this->data['product_store'] = $this->model_catalog_product->getProductStores($this->request->get['product_id']);
		} else {
			$this->data['product_store'] = array(0);
		}	

		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (!empty($product_info)) {
			$this->data['keyword'] = $this->model_catalog_product->getKeyWords($this->request->get['product_id']);
		} else {
			$this->data['keyword'] = array();
		}

		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (!empty($product_info)) {
			$this->data['image'] = $product_info['image'];
		} else {
			$this->data['image'] = '';
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['image']) && file_exists(DIR_IMAGE . $this->request->post['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
		} elseif (!empty($product_info) && $product_info['image'] && file_exists(DIR_IMAGE . $product_info['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($product_info['image'], 100, 100);
		} else {
			$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		if (isset($this->request->post['shipping'])) {
			$this->data['shipping'] = $this->request->post['shipping'];
		} elseif (!empty($product_info)) {
			$this->data['shipping'] = $product_info['shipping'];
		} else {
			$this->data['shipping'] = 1;
		}
		
		/*code start*/
		$this->data['promotags'] = $this->model_catalog_product->getPromoTags();
		
		if (isset($this->request->post['promo_top_right'])) {
			$this->data['promo_top_right'] = $this->request->post['promo_top_right'];
		} elseif (isset($product_info)) {
			$this->data['promo_top_right'] = $product_info['promo_top_right'];
		} else {
			$this->data['promo_top_right'] = 0;
		}
		
		
		if (isset($this->request->post['promo_date_start'])) {
			$this->data['promo_date_start'] = $this->request->post['promo_date_start'];
		} elseif (isset($product_info)) {
			if($product_info['promo_date_start'] == '0000-00-00 00:00:00') {
				$this->data['promo_date_start'] = '';
			} else {
				$this->data['promo_date_start'] = $product_info['promo_date_start'];
			}
		} else {
			$this->data['promo_date_start'] = '';
		}
		
		if (isset($this->request->post['promo_date_end'])) {
			$this->data['promo_date_end'] = $this->request->post['promo_date_end'];
		} elseif (isset($product_info)) {
			if($product_info['promo_date_end'] == '0000-00-00 00:00:00') {
				$this->data['promo_date_end'] = '';
			} else {
				$this->data['promo_date_end'] = $product_info['promo_date_end'];
			}
		} else {
			$this->data['promo_date_end'] = '';
		}
		/*code end*/

		if (isset($this->request->post['price'])) {
			$this->data['price'] = $this->request->post['price'];
		} elseif (!empty($product_info)) {
			$this->data['price'] = $product_info['price'];
		} else {
			$this->data['price'] = '';
		}
		
		if (isset($this->request->post['whole_sale_price'])) {
			$this->data['whole_sale_price'] = $this->request->post['whole_sale_price'];
		} elseif (!empty($product_info)) {
			$this->data['whole_sale_price'] = $product_info['whole_sale_price'];
		} else {
			$this->data['whole_sale_price'] = '';
		}
		
		if (isset($this->request->post['whole_sale_price_quantity'])) {
			$this->data['whole_sale_price_quantity'] = $this->request->post['whole_sale_price_quantity'];
		} elseif (!empty($product_info)) {
			$this->data['whole_sale_price_quantity'] = $product_info['whole_sale_price_quantity'];
		} else {
			$this->data['whole_sale_price_quantity'] = 0;
		}

		$this->load->model('catalog/profile');

		$this->data['profiles'] = $this->model_catalog_profile->getProfiles();

		if (isset($this->request->post['product_profiles'])) {
			$this->data['product_profiles'] = $this->request->post['product_profiles'];
		} elseif (!empty($product_info)) {
			$this->data['product_profiles'] = $this->model_catalog_product->getProfiles($product_info['product_id']);
		} else {
			$this->data['product_profiles'] = array();
		}

		$this->load->model('localisation/tax_class');

		$this->data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();

		if (isset($this->request->post['tax_class_id'])) {
			$this->data['tax_class_id'] = $this->request->post['tax_class_id'];
		} elseif (!empty($product_info)) {
			$this->data['tax_class_id'] = $product_info['tax_class_id'];
		} else {
			$this->data['tax_class_id'] = 0;
		}

		if (isset($this->request->post['date_available'])) {
			$this->data['date_available'] = $this->request->post['date_available'];
		} elseif (!empty($product_info)) {
			$this->data['date_available'] = date('Y-m-d', strtotime($product_info['date_available']));
		} else {
			$this->data['date_available'] = date('Y-m-d', time() - 86400);
		}

		if (isset($this->request->post['quantity'])) {
			$this->data['quantity'] = $this->request->post['quantity'];
		} elseif (!empty($product_info)) {
			$this->data['quantity'] = $product_info['quantity'];
		} else {
			$this->data['quantity'] = 1;
		}

		if (isset($this->request->post['minimum'])) {
			$this->data['minimum'] = $this->request->post['minimum'];
		} elseif (!empty($product_info)) {
			$this->data['minimum'] = $product_info['minimum'];
		} else {
			$this->data['minimum'] = 1;
		}

		if (isset($this->request->post['subtract'])) {
			$this->data['subtract'] = $this->request->post['subtract'];
		} elseif (!empty($product_info)) {
			$this->data['subtract'] = $product_info['subtract'];
		} else {
			$this->data['subtract'] = 1;
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($product_info)) {
			$this->data['sort_order'] = $product_info['sort_order'];
		} else {
			$this->data['sort_order'] = 1;
		}

		$this->load->model('localisation/stock_status');

		$this->data['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();

		if (isset($this->request->post['stock_status_id'])) {
			$this->data['stock_status_id'] = $this->request->post['stock_status_id'];
		} elseif (!empty($product_info)) {
			$this->data['stock_status_id'] = $product_info['stock_status_id'];
		} else {
			$this->data['stock_status_id'] = $this->config->get('config_stock_status_id');
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($product_info)) {
			$this->data['status'] = $product_info['status'];
		} else {
			$this->data['status'] = 1;
		}

		if (isset($this->request->post['weight'])) {
			$this->data['weight'] = $this->request->post['weight'];
		} elseif (!empty($product_info)) {
			$this->data['weight'] = $product_info['weight'];
		} else {
			$this->data['weight'] = '';
		}
		
		if (isset($this->request->post['video'])) {
			$this->data['video'] = $this->request->post['video'];
		} elseif (!empty($product_info)) {
			$this->data['video'] = $product_info['video'];
		} else {
			$this->data['video'] = '';
		}

		$this->load->model('localisation/weight_class');

		$this->data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();

		if (isset($this->request->post['weight_class_id'])) {
			$this->data['weight_class_id'] = $this->request->post['weight_class_id'];
		} elseif (!empty($product_info)) {
			$this->data['weight_class_id'] = $product_info['weight_class_id'];
		} else {
			$this->data['weight_class_id'] = $this->config->get('config_weight_class_id');
		}

		if (isset($this->request->post['length'])) {
			$this->data['length'] = $this->request->post['length'];
		} elseif (!empty($product_info)) {
			$this->data['length'] = $product_info['length'];
		} else {
			$this->data['length'] = '';
		}

		if (isset($this->request->post['width'])) {
			$this->data['width'] = $this->request->post['width'];
		} elseif (!empty($product_info)) {	
			$this->data['width'] = $product_info['width'];
		} else {
			$this->data['width'] = '';
		}

		if (isset($this->request->post['height'])) {
			$this->data['height'] = $this->request->post['height'];
		} elseif (!empty($product_info)) {
			$this->data['height'] = $product_info['height'];
		} else {
			$this->data['height'] = '';
		}

		$this->load->model('localisation/length_class');

		$this->data['length_classes'] = $this->model_localisation_length_class->getLengthClasses();

		if (isset($this->request->post['length_class_id'])) {
			$this->data['length_class_id'] = $this->request->post['length_class_id'];
		} elseif (!empty($product_info)) {
			$this->data['length_class_id'] = $product_info['length_class_id'];
		} else {
			$this->data['length_class_id'] = $this->config->get('config_length_class_id');
		}

		$this->load->model('catalog/manufacturer');

		if (isset($this->request->post['manufacturer_id'])) {
			$this->data['manufacturer_id'] = $this->request->post['manufacturer_id'];
		} elseif (!empty($product_info)) {
			$this->data['manufacturer_id'] = $product_info['manufacturer_id'];
		} else {
			$this->data['manufacturer_id'] = 0;
		}

		if (isset($this->request->post['manufacturer'])) {
			$this->data['manufacturer'] = $this->request->post['manufacturer'];
		} elseif (!empty($product_info)) {
			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product_info['manufacturer_id']);

			if ($manufacturer_info) {		
				$this->data['manufacturer'] = $manufacturer_info['name'];
			} else {
				$this->data['manufacturer'] = '';
			}	
		} else {
			$this->data['manufacturer'] = '';
		}

		// Categories
		$this->load->model('catalog/category');

		if (isset($this->request->post['product_category'])) {
			$categories = $this->request->post['product_category'];
		} elseif (isset($this->request->get['product_id'])) {		
			$categories = $this->model_catalog_product->getProductCategories($this->request->get['product_id']);
		} else {
			$categories = array();
		}

		$this->data['product_categories'] = array();

		foreach ($categories as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$this->data['product_categories'][] = array(
					'category_id' => $category_info['category_id'],
					'name'        => ($category_info['path'] ? $category_info['path'] . ' &gt; ' : '') . $category_info['name']
					);
			}
		}

		// Filters
		$this->load->model('catalog/filter');

		if (isset($this->request->post['product_filter'])) {
			$filters = $this->request->post['product_filter'];
		} elseif (isset($this->request->get['product_id'])) {
			$filters = $this->model_catalog_product->getProductFilters($this->request->get['product_id']);
		} else {
			$filters = array();
		}

		$this->data['product_filters'] = array();

		foreach ($filters as $filter_id) {
			$filter_info = $this->model_catalog_filter->getFilter($filter_id);

			if ($filter_info) {
				$this->data['product_filters'][] = array(
					'filter_id' => $filter_info['filter_id'],
					'name'      => $filter_info['group'] . ' &gt; ' . $filter_info['name']
					);
			}
		}		

		// Attributes
		$this->load->model('catalog/attribute');

		if (isset($this->request->post['product_attribute'])) {
			$product_attributes = $this->request->post['product_attribute'];
		} elseif (isset($this->request->get['product_id'])) {
			$product_attributes = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);
		} else {
			$product_attributes = array();
		}

		$this->data['product_attributes'] = array();

		foreach ($product_attributes as $product_attribute) {
			$attribute_info = $this->model_catalog_attribute->getAttribute($product_attribute['attribute_id']);

			if ($attribute_info) {
				$this->data['product_attributes'][] = array(
					'attribute_id'                  => $product_attribute['attribute_id'],
					'name'                          => $attribute_info['name'],
					'product_attribute_description' => $product_attribute['product_attribute_description']
					);
			}
		}		

		// Options
		$this->load->model('catalog/option');

		if (isset($this->request->post['product_option'])) {
			$product_options = $this->request->post['product_option'];
		} elseif (isset($this->request->get['product_id'])) {
			$product_options = $this->model_catalog_product->getProductOptions($this->request->get['product_id']);			
		} else {
			$product_options = array();
		}			

		$this->data['product_options'] = array();

		foreach ($product_options as $product_option) {
			if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'radiocolor' || $product_option['type'] == 'radiolabel' || $product_option['type'] == 'checkboxcolor' || $product_option['type'] == 'checkboxlabel' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image' || $product_option['type'] == 'custom_text') {
				$product_option_value_data = array();
				// In case user tries to add a product option with no option values
				if (!isset($product_option['product_option_value'])) {
					$product_option['product_option_value'] = array();
				}
				

				foreach ($product_option['product_option_value'] as $product_option_value) {
					
					if ($product_option_value['product_option_image'] && file_exists(DIR_IMAGE . $product_option_value['product_option_image'])) {
						$image = $product_option_value['product_option_image'];
					} else {
						$image = 'no_image.jpg';
					}
					
					$product_option_value_data[] = array(
						'product_option_value_id' 	 => $product_option_value['product_option_value_id'],
						'option_value_id'         	 => (isset($product_option_value['option_value_id']) ? $product_option_value['option_value_id'] : false),
						'quantity'                	 => $product_option_value['quantity'],
						'subtract'                	 => $product_option_value['subtract'],
						'price'                   	 => $product_option_value['price'],
						'price_prefix'            	 => $product_option_value['price_prefix'],
						'points'                  	 => $product_option_value['points'],
						'points_prefix'           	 => $product_option_value['points_prefix'],
		                'parent_option_value'     	 => (isset($product_option_value['parent_option_value']) ? $product_option_value['parent_option_value'] : array()), // Dependent Options
		                'weight'                  	 => $product_option_value['weight'],
		                'weight_prefix'           	 => $product_option_value['weight_prefix'],
		                'product_option_image'    	 => $image,
		                'product_option_image_thumb' => $this->model_tool_image->resize($image, 100, 100),
		                );
}

$this->data['product_options'][] = array(
	'product_option_id'    => $product_option['product_option_id'],
	'product_option_value' => $product_option_value_data,
	                'parent_option_id'     => (isset($product_option['parent_option_id']) ? $product_option['parent_option_id'] : false), // Dependent Options
	                'option_id'            => $product_option['option_id'],
	                'name'                 => $product_option['name'],
	                'product_page'         => isset($product_option['product_page']) ? ((int)$product_option['product_page']) : '',
	                'type'                 => $product_option['type'],
	                'required'             => $product_option['required']
	                );				
} else {
	$this->data['product_options'][] = array(
		'product_option_id' => $product_option['product_option_id'],
		'option_id'         => $product_option['option_id'],
		'name'              => $product_option['name'],
		'product_page'      => isset($product_option['product_page']) ? ((int)$product_option['product_page']) : '',
		'type'              => $product_option['type'],
		'option_value'      => $product_option['option_value'],
		'required'          => $product_option['required']
		);				
}
}

$this->data['option_values'] = array();

foreach ($this->data['product_options'] as $product_option) {
	if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'radiocolor' || $product_option['type'] == 'radiolabel' || $product_option['type'] == 'checkboxcolor' || $product_option['type'] == 'checkboxlabel' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image' || $product_option['type'] == 'custom_text') {
		if (!isset($this->data['option_values'][$product_option['option_id']])) {
			$this->data['option_values'][$product_option['option_id']] = $this->model_catalog_option->getOptionValues($product_option['option_id']);
		}
	}
}

$this->load->model('catalog/option');

$this->data['select_options'] = $this->model_catalog_option->getSelectTypeOptions();
$this->data['select_option_values'] = $this->model_catalog_option->getSelectTypeOptionValues();

$this->load->model('sale/customer_group');

$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();

if (isset($this->request->post['product_discount'])) {
	$this->data['product_discounts'] = $this->request->post['product_discount'];
} elseif (isset($this->request->get['product_id'])) {
	$this->data['product_discounts'] = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);
} else {
	$this->data['product_discounts'] = array();
}

if (isset($this->request->post['product_special'])) {
	$this->data['product_specials'] = $this->request->post['product_special'];
} elseif (isset($this->request->get['product_id'])) {
	$this->data['product_specials'] = $this->model_catalog_product->getProductSpecials($this->request->get['product_id']);
} else {
	$this->data['product_specials'] = array();
}

		// Images
if (isset($this->request->post['product_image'])) {
	$product_images = $this->request->post['product_image'];
} elseif (isset($this->request->get['product_id'])) {
	$product_images = $this->model_catalog_product->getProductImages($this->request->get['product_id']);
} else {
	$product_images = array();
}

$this->data['product_images'] = array();

foreach ($product_images as $product_image) {
	if ($product_image['image'] && file_exists(DIR_IMAGE . $product_image['image'])) {
		$image = $product_image['image'];
	} else {
		$image = 'no_image.jpg';
	}

	$this->data['product_images'][] = array(
		'image'      => $image,
		'thumb'      => $this->model_tool_image->resize($image, 100, 100),
		'sort_order' => $product_image['sort_order']
		);
}

$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 50, 50);

		// Downloads
$this->load->model('catalog/download');

if (isset($this->request->post['product_download'])) {
	$product_downloads = $this->request->post['product_download'];
} elseif (isset($this->request->get['product_id'])) {
	$product_downloads = $this->model_catalog_product->getProductDownloads($this->request->get['product_id']);
} else {
	$product_downloads = array();
}

$this->data['product_downloads'] = array();

foreach ($product_downloads as $download_id) {
	$download_info = $this->model_catalog_download->getDownload($download_id);

	if ($download_info) {
		$this->data['product_downloads'][] = array(
			'download_id' => $download_info['download_id'],
			'name'        => $download_info['name']
			);
	}
}

if (isset($this->request->post['product_related'])) {
	$products = $this->request->post['product_related'];
} elseif (isset($this->request->get['product_id'])) {		
	$products = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
} else {
	$products = array();
}

$this->data['product_related'] = array();

foreach ($products as $product_id) {
	$related_info = $this->model_catalog_product->getProduct($product_id);

	if ($related_info) {
		$this->data['product_related'][] = array(
			'product_id' => $related_info['product_id'],
			'name'       => $related_info['name']
			);
	}
}

if (isset($this->request->post['points'])) {
	$this->data['points'] = $this->request->post['points'];
} elseif (!empty($product_info)) {
	$this->data['points'] = $product_info['points'];
} else {
	$this->data['points'] = '';
}

if (isset($this->request->post['product_reward'])) {
	$this->data['product_reward'] = $this->request->post['product_reward'];
} elseif (isset($this->request->get['product_id'])) {
	$this->data['product_reward'] = $this->model_catalog_product->getProductRewards($this->request->get['product_id']);
} else {
	$this->data['product_reward'] = array();
}

if (isset($this->request->post['product_layout'])) {
	$this->data['product_layout'] = $this->request->post['product_layout'];
} elseif (isset($this->request->get['product_id'])) {
	$this->data['product_layout'] = $this->model_catalog_product->getProductLayouts($this->request->get['product_id']);
} else {
	$this->data['product_layout'] = array();
}

$this->load->model('design/layout');

$this->data['layouts'] = $this->model_design_layout->getLayouts();

$this->template = 'catalog/product_form.tpl';
$this->children = array(
	'common/header',
	'common/footer'
	);

$this->response->setOutput($this->render());
}

protected function validateForm() {
	if (!$this->user->hasPermission('modify', 'catalog/product')) {
		$this->error['warning'] = $this->language->get('error_permission');
	}

	foreach ($this->request->post['product_description'] as $language_id => $value) {
		if ((utf8_strlen($value['name']) < 1) || (utf8_strlen($value['name']) > 255)) {
			$this->error['name'][$language_id] = $this->language->get('error_name');
		}
	}

	if ((utf8_strlen($this->request->post['model']) < 1) || (utf8_strlen($this->request->post['model']) > 64)) {
		$this->error['model'] = $this->language->get('error_model');
	}

		/// Dependent Options Validation
	if (isset($this->request->post['product_option'])) {
		$product_options = array();
		$product_option_values = array();
		
		$parent_option_values = array();
		
		foreach ($this->request->post['product_option'] as $product_option) {
			if ($product_option['type'] == 'select') {
				if (isset($product_options[$product_option['option_id']])) {
		                // ERROR: Duplicate Option
					$this->error['duplicate_option'][$product_option['option_id']] = $this->language->get('error_duplicate_option');
				} else {
					$product_options[$product_option['option_id']] = array(
						'parent_option_id' => (!empty($product_option['parent_option_id']) ? $product_option['parent_option_id'] : false),
						'required'         => ($product_option['required'] ? true : false),
						'option_values'    => array()
						);
				}

				if (empty($product_option['product_option_value'])) {
		                // ERROR: No Option Values set
					$this->error['no_option_values_set'][$product_option['option_id']] = $this->language->get('error_no_option_values_set');
				} else {
					foreach ($product_option['product_option_value'] as $product_option_value) {
						if (!isset($product_option_value['option_value_id'])) {
		                        // ERROR: Option Value was not populated because of OpenCart pre-1.5.2 AJAX issue
							$this->error['ajax_option_value_failure'][$product_option['option_id']] = $this->language->get('error_ajax_option_value_failure');
						} else {
							if (isset($product_option_values[$product_option_value['option_value_id']])) {
		                            // ERROR: Duplicate Option Values
								$this->error['duplicate_option_value'][$product_option_value['option_value_id']] = $this->language->get('error_duplicate_option_value');
							} else {
								$product_option_values[$product_option_value['option_value_id']] = array(
									'option_id'           => $product_option['option_id'],
									'subtract'            => $product_option_value['subtract'],
									'quantity'            => $product_option_value['quantity'],
									'parent_option_value' => (isset($product_option_value['parent_option_value']) ? $product_option_value['parent_option_value'] : false)
									);

								$product_options[$product_option['option_id']]['option_values'][] = $product_option_value['option_value_id'];

								if (isset($product_option_value['parent_option_value'])) {
									if (isset($parent_option_values[$product_option['option_id']])) {
										$parent_option_values[$product_option['option_id']] = array_unique(array_merge($parent_option_values[$product_option['option_id']], $product_option_value['parent_option_value']));
									} else {
										$parent_option_values[$product_option['option_id']] = $product_option_value['parent_option_value'];
									}
								}
							}
						}
					}
				}
			}
		}
		
		foreach ($product_options as $option_id => $option_data) {
			if ($option_data['parent_option_id'] && isset($product_options[$option_data['parent_option_id']]) && $product_options[$option_data['parent_option_id']]['parent_option_id'] == $option_id) {
		            // ERROR: Parent Option recursion
				$this->error['parent_option_recursion'][$option_id] = $this->language->get('error_parent_option_recursion');
				$this->error['parent_option_recursion'][$option_data['parent_option_id']] = $this->language->get('error_parent_option_recursion');
			} else {
				if ($option_data['parent_option_id'] && !array_key_exists($option_data['parent_option_id'], $product_options)) {
		                // ERROR: Parent Option not found in product
					$this->error['missing_option'][$option_id] = $this->language->get('error_missing_option');
				}
			}
		}
		
		foreach ($product_option_values as $option_value_id => $option_value_data) {
			if ($option_value_data['parent_option_value']) {
				foreach ($option_value_data['parent_option_value'] as $parent_option_value_id) {
					if (array_key_exists($parent_option_value_id, $product_option_values) === false) {
		                    // ERROR: Parent Option Value not found in product
						$this->error['missing_option_value'][$option_value_id] = $this->language->get('error_missing_option_value');
					} else {
						if ($product_options[$option_value_data['option_id']]['required'] === true) {
							if (count($parent_option_values[$option_value_data['option_id']]) < 2) {
		                            // ERROR: Required Options must have a total of at least two unique Parent Option Values
								$this->error['required_option_parents'][$option_value_data['option_id']] = $this->language->get('error_required_option_parents');
							} else {
								if ($product_option_values[$parent_option_value_id]['subtract'] && $product_option_values[$parent_option_value_id]['quantity'] < 1) {
		                                // ERROR: Parent Option Value cannot be out-of-stock
									$this->error['parent_option_stock_level'][$option_value_id] = $this->language->get('error_parent_option_stock_level');
								}
							}
						}
					}
				}
			}
		}
	}
		///

	if ($this->error && !isset($this->error['warning'])) {
		$this->error['warning'] = $this->language->get('error_warning');
	}

	if (!$this->error) {
		return true;
	} else {
		return false;
	}
}

protected function validateDelete() {
	if (!$this->user->hasPermission('modify', 'catalog/product')) {
		$this->error['warning'] = $this->language->get('error_permission');
	}

	if (!$this->error) {
		return true;
	} else {
		return false;
	}
}

protected function validateCopy() {
	if (!$this->user->hasPermission('modify', 'catalog/product')) {
		$this->error['warning'] = $this->language->get('error_permission');
	}

	if (!$this->error) {
		return true;
	} else {
		return false;
	}
}

public function autocomplete() {
	$json = array();

	if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model']) || isset($this->request->get['filter_category_id'])) {
		$this->load->model('catalog/product');
		$this->load->model('catalog/option');

		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = '';
		}

		if (isset($this->request->get['filter_model'])) {
			$filter_model = $this->request->get['filter_model'];
		} else {
			$filter_model = '';
		}

		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];	
		} else {
			$limit = 20;	
		}			

		if (isset($this->request->get['filter_status'])) {
			$filter_status = (bool)$this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_special'])) {
			$filter_special = (bool)$this->request->get['filter_special'];
		}

		$data = array(
			'filter_name'  => $filter_name,
			'filter_model' => $filter_model,
			'filter_status'=> (isset($filter_status) ? $filter_status: null),
			'filter_special'=> (isset($filter_special) ? $filter_special: null),
			'start'        => 0,
			'limit'        => $limit
			);
		$results = $this->model_catalog_product->getProducts($data);

		foreach ($results as $result) {
			$option_data = array();

			$product_options = $this->model_catalog_product->getProductOptions($result['product_id']);	

			foreach ($product_options as $product_option) {
				$option_info = $this->model_catalog_option->getOption($product_option['option_id']);

				if ($option_info) {				
					if ($option_info['type'] == 'select' || $option_info['type'] == 'radio' || $option_info['type'] == 'radiocolor' || $option_info['type'] == 'checkboxcolor' || $option_info['type'] == 'checkbox' || $option_info['type'] == 'image') {
						$option_value_data = array();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$option_value_info = $this->model_catalog_option->getOptionValue($product_option_value['option_value_id']);

							if ($option_value_info) {
								$option_value_data[] = array(
									'product_option_value_id' => $product_option_value['product_option_value_id'],
									'option_value_id'         => (isset($product_option_value['option_value_id']) ? $product_option_value['option_value_id'] : false),
									'name'                    => $option_value_info['name'],
									'price'                   => (float)$product_option_value['price'] ? $this->currency->format($product_option_value['price'], $this->config->get('config_currency')) : false,
									'price_prefix'            => $product_option_value['price_prefix']
									);
							}
						}

						$option_data[] = array(
							'product_option_id' => $product_option['product_option_id'],
							'option_id'         => $product_option['option_id'],
							'name'              => $option_info['name'],
							'type'              => $option_info['type'],
							'option_value'      => $option_value_data,
							'required'          => $product_option['required']
							);	
					} else {
						$option_data[] = array(
							'product_option_id' => $product_option['product_option_id'],
							'option_id'         => $product_option['option_id'],
							'name'              => $option_info['name'],
							'type'              => $option_info['type'],
							'option_value'      => $product_option['option_value'],
							'required'          => $product_option['required']
							);				
					}
				}
			}

			$json[] = array(
				'product_id' => $result['product_id'],
				'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),	
				'model'      => $result['model'],
				'option'     => $option_data,
				'price'      => $result['price']
				);	
		}
	}

	$this->response->setOutput(json_encode($json));
}

public function fastUpdate() {
	if ((isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') && !empty($this->request->post)){
		$this->load->model('catalog/product');
		if(isset($this->request->post['name']) && isset($this->request->post['pk']) && isset($this->request->post['value'])) {
			exit(json_encode($this->model_catalog_product->fastUpdate($this->request->post['name'], $this->request->post['pk'], $this->request->post['value'])));
		}

	}
	exit(json_encode(false));
}

public function addCategory() {
	if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
		if(isset($this->request->post['product_id']) && isset($this->request->post['category_id'])) {
			$this->load->model('catalog/product');
			$this->model_catalog_product->linkProductCategory((int)$this->request->post['product_id'], (int)$this->request->post['category_id']);
			exit(json_encode(array('status' => true)));
		} else {
			exit(json_encode(array('status' => false)));
		}
	} else {
		exit(json_encode(array('status' => false)));
	}
}

public function removeCategory() {
	if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
		if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
			if(isset($this->request->post['product_id']) && isset($this->request->post['category_id'])) {
				$this->load->model('catalog/product');
				$this->model_catalog_product->unlinkProductCategory((int)$this->request->post['product_id'], (int)$this->request->post['category_id']);
				exit(json_encode(array('status' => true)));
			} else {
				exit(json_encode(array('status' => false)));
			}
		} else {
			exit(json_encode(array('status' => false)));
		}
	}
}
}
?>

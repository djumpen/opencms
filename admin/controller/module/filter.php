<?php
class ControllerModuleFilter extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/filter');
		$this->document->setTitle($this->language->get('heading_title_module'));
        $this->document->addStyle('view/stylesheet/filter/filter.css');

		$this->load->model('setting/setting');

        $config = array(
          'status',
          'position',
          'sort_order',
          'show_price',
          'show_selected',
          'show_diagram',
          'show_button',
          'show_counter',
          'consider_discount',
          'consider_special',
          'hide_options',
          'hide_options_limit',
          'manufacturer',
          'manufacturer_type',
          'stock_status',
          'stock_status_type',
          'pco_show_type',
          'pco_show_limit'
        );

        /* Gen variables to 'category/options' links */
        $this->load->model('catalog/category');
        $this->load->model('catalog/option');
        $this->data['global_categories'] = $this->model_catalog_category->getCategories(0);
        $this->data['global_options']    = $this->model_catalog_option->getOptions();
        $this->data['setted_options']    = $this->config->get('filter_category_options');
        Debug::log($this->data['setted_options']);
        /* Gen variables to 'category/options' links */
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            foreach ($config as $key) {
                if (!isset($this->request->post['filter_module'][0][$key])) {
                  $this->request->post['filter_module'][0][$key] = 0;
                }
            }

			$this->model_setting_setting->editSetting('filter', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

            if (!isset($this->request->get['return'])) {
    		    $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $this->redirect($this->url->link('module/filter', 'token=' . $this->session->data['token'], 'SSL'));
            }
		}

		$this->data['heading_title'] = $this->language->get('heading_title_module');

        $this->data['tab_general'] = $this->language->get('tab_general');
        $this->data['tab_option'] = $this->language->get('tab_option');
        $this->data['tab_price_filtering'] = $this->language->get('tab_price_filtering');
        $this->data['tab_other'] = $this->language->get('tab_other');
        $this->data['tab_copy'] = $this->language->get('tab_copy');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_mainmenu'] = 'Mainmenu';
		$this->data['text_slideshow'] = 'Slideshow';
		$this->data['text_footer'] = 'Footer';
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_description'] = $this->language->get('text_description');
        $this->data['text_inline'] = $this->language->get('text_inline');
        $this->data['text_list'] = $this->language->get('text_list');
        $this->data['text_create'] = $this->language->get('text_create');

		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_show_price'] = $this->language->get('entry_show_price');
		$this->data['entry_show_selected'] = $this->language->get('entry_show_selected');
        $this->data['entry_show_counter'] = $this->language->get('entry_show_counter');
        $this->data['entry_show_diagram'] = $this->language->get('entry_show_diagram');
        $this->data['entry_show_button'] = $this->language->get('entry_show_button');
        $this->data['entry_consider_discount'] = $this->language->get('entry_consider_discount');
        $this->data['entry_consider_special'] = $this->language->get('entry_consider_special');
        $this->data['entry_hide_options'] = $this->language->get('entry_hide_options');
        $this->data['entry_hide_options_limit'] = $this->language->get('entry_hide_options_limit');
        $this->data['entry_pco_show_type'] = $this->language->get('entry_pco_show_type');
        $this->data['entry_pco_show_limit'] = $this->language->get('entry_pco_show_limit');
		$this->data['entry_manufacturer'] = $this->language->get('entry_manufacturer');
		$this->data['entry_manufacturer_type'] = $this->language->get('entry_manufacturer_type');
        $this->data['entry_stock_status'] = $this->language->get('entry_stock_status');
		$this->data['entry_stock_status_type'] = $this->language->get('entry_stock_status_type');

        $this->data['notice_position'] = $this->language->get('notice_position');
		$this->data['notice_status'] = $this->language->get('notice_status');
		$this->data['notice_sort_order'] = $this->language->get('notice_sort_order');
		$this->data['notice_show_price'] = $this->language->get('notice_show_price');
		$this->data['notice_show_selected'] = $this->language->get('notice_show_selected');
        $this->data['notice_show_counter'] = $this->language->get('notice_show_counter');
        $this->data['notice_show_diagram'] = $this->language->get('notice_show_diagram');
        $this->data['notice_show_button'] = $this->language->get('notice_show_button');
        $this->data['notice_consider_discount'] = $this->language->get('notice_consider_discount');
        $this->data['notice_consider_special'] = $this->language->get('notice_consider_special');
        $this->data['notice_hide_options'] = $this->language->get('notice_hide_options');
        $this->data['notice_pco_show_type'] = $this->language->get('notice_pco_show_type');
        $this->data['notice_pco_show_limit'] = $this->language->get('notice_pco_show_limit');
		$this->data['notice_manufacturer'] = $this->language->get('notice_manufacturer');
        $this->data['notice_stock_status'] = $this->language->get('notice_stock_status');

		$this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_apply'] = $this->language->get('button_apply');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_create'] = $this->language->get('button_create');

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
     	'text'      => $this->language->get('heading_title_module'),
		  'href'      => $this->url->link('module/filter', 'token=' . $this->session->data['token'], 'SSL'),
    	'separator' => ' :: '
 		);

		$this->data['action'] = $this->url->link('module/filter', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['create'] = $this->url->link('module/filter/create', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['export'] = $this->url->link('module/filter/export', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['token'] = $this->session->data['token'];
    
        $this->load->model('catalog/filter');
        $this->data['installed'] = $this->model_catalog_filter->existsTables();
    
        $this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();

        $this->data['positions'] = array(
          'mainmenu',
          'slideshow',
          'content_top',
          'content_bottom',
          'column_left',
          'column_right',
          'footer'
        );
    
        $this->data['types'] = array(
          'checkbox',
          'radio',
          'select'
        );
    
        if (isset($this->request->post['filter_module'])) {
    			$module = $this->request->post['filter_module'];
    		} elseif ($this->config->get('filter_module')) {
    			$module = $this->config->get('filter_module');
    		}
    
        foreach ($config as $key) {
      		if (isset($module[0][$key])) {
      			$this->data[$key] = $module[0][$key];
      		} else {
            $this->data[$key] = '';
          }
        }

		$this->template = 'module/filter.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/filter')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

        $query = $this->db->query("SELECT layout_id FROM " . DB_PREFIX . "layout_route WHERE route = 'product/category' LIMIT 1");
    
        if ($query->num_rows) {
          $this->request->post['filter_module'][0]['layout_id'] = $query->row['layout_id'];
        } else {
          $this->error['warning'] = sprintf($this->language->get('error_layout'), $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL'));
        }

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function create() {
        $this->load->language('module/filter');
        $this->load->model('catalog/filter');
    
        if ($this->model_catalog_filter->existsTables()) {
          $this->session->data['warning'] = 'Таблицы уже существуют';
        } else {
          if ($this->model_catalog_filter->createTables()) {
            $this->load->model('user/user_group');
    
      			$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/filter');
      			$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/filter');
    
            $this->session->data['success'] = sprintf($this->language->get('text_success_create'), $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL'));
          } else {
            $this->session->data['warning'] = 'При установке возникла ошибка. Попробуйте импортировать таблицы вручную.';
          }
        }

        $this->redirect($this->url->link('module/filter', 'token=' . $this->session->data['token'], 'SSL'));
  }

//   public function copyAttributes() {
//     $json = array();

//     if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['option_store']) && isset($this->request->post['type'])) {
//       $this->load->model('catalog/filter');

//       $this->model_catalog_filter->copyAttributesToFilter($this->request->post);

//       $json['message'] = 'Готово';
//     } else {
//       $json['message'] = 'Укажите все данные';
//     }

//     $this->response->setOutput(json_encode($json));
//   }

  public function export() {
    $this->load->model('catalog/filter');

    header('Content-type: application/ms-excel; charset=utf-8');
    header('Content-Disposition: attachment; filename=export-filter-' . date('d-m-Y-H-i-s') . '.csv');

    echo "Option ID;Option Name;Postfix;Type;Group Count;Category Options;Option Stores;Values ID;Values Name;Product Values; \r\n";

    $option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option");

    $content = '';

    foreach($option_query->rows as $option) {
      $content .= $option['option_id'] . ";";

      $names = array();
      $postfixes = array();

      foreach($this->model_catalog_filter->getOptionDescriptions($option['option_id']) as $language_id => $description) {
        $names[] = $language_id . ':' . html_entity_decode(iconv('utf-8', 'windows-1251', $description['name']), ENT_QUOTES, 'UTF-8');

        if($description['postfix']) {
          $postfixes[] = $language_id . ':' . html_entity_decode(iconv('utf-8', 'windows-1251', $description['postfix']), ENT_QUOTES, 'UTF-8');
        }
      }

      $content .= implode(',', $names) . ";";
      $content .= implode(',', $postfixes) . ";";
      $content .= $option['type'] . ";";
      $content .= $option['group_count'] . ";";

      $option_to_category = array();

      foreach($this->model_catalog_filter->getOptionCategories($option['option_id']) as $category_id) {
        $option_to_category[] = $category_id;
      }

      if ($option_to_category) {
        $content .= implode(',', $option_to_category) . ";";
      } else {
        $content .= "0;";
      }

      $option_to_store = array();

      foreach($this->model_catalog_filter->getOptionStores($option['option_id']) as $store_id) {
        $option_to_store[] = $store_id;
      }

      $content .= implode(',', $option_to_store) . ";";

      $values_id = array();
      $values_name = array();

      foreach($this->model_catalog_filter->getOptionValues($option['option_id']) as $value) {
        $values_id[] = $value['value_id'];

        foreach($value['language'] as $language_id => $name) {
          $values_name[] = $language_id . ':' . html_entity_decode(iconv('utf-8', 'windows-1251', $name['name']), ENT_QUOTES, 'UTF-8');
        }
      }

      $content .= implode(',', $values_id) . ";";
      $content .= implode(',', $values_name) . ";";

      $product_to_value = array();

      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_value WHERE option_id = '" . (int)$option['option_id'] . "'");

      foreach($query->rows as $row) {
        $product_to_value[] = $row['product_id'] . ':' . $row['value_id'];
      }

      $content .= implode(',', $product_to_value) . ";";

      $content .= " \r\n";
    }

    echo $content;
  }

}
?>
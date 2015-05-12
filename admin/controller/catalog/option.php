<?php
class ControllerCatalogOption extends Controller {
    private $error = array();

    public function index() {
        $this->language->load('catalog/option');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/option');

        $this->getList();
    }

    public function insert() {
        $this->language->load('catalog/option');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/option');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_catalog_option->addOption($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->redirect($this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function update() {
        $this->language->load('catalog/option');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/option');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_catalog_option->editOption($this->request->get['option_id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->redirect($this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function delete() {
        $this->language->load('catalog/option');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('catalog/option');

        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $option_id) {
                $this->model_catalog_option->deleteOption($option_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            $this->redirect($this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getList();
    }

    protected function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'od.name';
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
            'href'      => $this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );

        $this->data['insert'] = $this->url->link('catalog/option/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $this->data['delete'] = $this->url->link('catalog/option/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $this->data['options'] = array();

        $data = array(
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit' => $this->config->get('config_admin_limit')
        );

        $option_total = $this->model_catalog_option->getTotalOptions();

        $results = $this->model_catalog_option->getOptions($data);

        foreach ($results as $result) {
            $action = array();

            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $this->url->link('catalog/option/update', 'token=' . $this->session->data['token'] . '&option_id=' . $result['option_id'] . $url, 'SSL')
            );

            $this->data['options'][] = array(
                'option_id'  => $result['option_id'],
                'name'       => $result['name'],
                'sort_order' => $result['sort_order'],
                'selected'   => isset($this->request->post['selected']) && in_array($result['option_id'], $this->request->post['selected']),
                'action'     => $action
            );
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_no_results'] = $this->language->get('text_no_results');

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_sort_order'] = $this->language->get('column_sort_order');
        $this->data['column_action'] = $this->language->get('column_action');

        $this->data['button_insert'] = $this->language->get('button_insert');
        $this->data['button_delete'] = $this->language->get('button_delete');

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

        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $this->data['sort_name'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'] . '&sort=od.name' . $url, 'SSL');
        $this->data['sort_sort_order'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'] . '&sort=o.sort_order' . $url, 'SSL');

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $option_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;

        $this->template = 'catalog/option_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    protected function getForm() {
        /*$this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_choose'] = $this->language->get('text_choose');
        $this->data['text_select'] = $this->language->get('text_select');
        $this->data['text_radio'] = $this->language->get('text_radio');
        $this->data['text_radiocolor'] = $this->language->get('text_radiocolor');
        $this->data['text_radiolabel'] = $this->language->get('text_radiolabel');
        $this->data['text_checkboxcolor'] = $this->language->get('text_checkboxcolor');
        $this->data['text_checkboxlabel'] = $this->language->get('text_checkboxlabel');
        $this->data['text_checkbox'] = $this->language->get('text_checkbox');
        $this->data['text_image'] = $this->language->get('text_image');
        $this->data['text_input'] = $this->language->get('text_input');
        $this->data['text_text'] = $this->language->get('text_text');
        $this->data['text_textarea'] = $this->language->get('text_textarea');
        $this->data['text_file'] = $this->language->get('text_file');
        $this->data['text_date'] = $this->language->get('text_date');
        $this->data['text_datetime'] = $this->language->get('text_datetime');
        $this->data['text_time'] = $this->language->get('text_time');
        $this->data['text_image_manager'] = $this->language->get('text_image_manager');
        $this->data['text_browse'] = $this->language->get('text_browse');
        $this->data['text_clear'] = $this->language->get('text_clear');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');

        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_type'] = $this->language->get('entry_type');
        $this->data['entry_option_value'] = $this->language->get('entry_option_value');
        $this->data['entry_image'] = $this->language->get('entry_image');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_option_value'] = $this->language->get('button_add_option_value');
        $this->data['button_remove'] = $this->language->get('button_remove');*/

        $this->applyLangVars();

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

        if (isset($this->error['dependent_option_value'])) {
            $this->data['error_dependent_option_value'] = $this->error['dependent_option_value'];
        } else {
            $this->data['error_dependent_option_value'] = array();
        }

        if (isset($this->error['dependent_option_type'])) {
            $this->data['error_dependent_option_type'] = $this->error['dependent_option_type'];
        } else {
            $this->data['error_dependent_option_type'] = '';
        }


        if (isset($this->error['option_value'])) {
            $this->data['error_option_value'] = $this->error['option_value'];
        } else {
            $this->data['error_option_value'] = array();
        }

        $url = '';

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
            'href'      => $this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );

        if (!isset($this->request->get['option_id'])) {
            $this->data['action'] = $this->url->link('catalog/option/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $this->data['action'] = $this->url->link('catalog/option/update', 'token=' . $this->session->data['token'] . '&option_id=' . $this->request->get['option_id'] . $url, 'SSL');
        }

        $this->data['cancel'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'] . $url, 'SSL');

        if (isset($this->request->get['option_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $option_info = $this->model_catalog_option->getOption($this->request->get['option_id']);
        }

        $this->data['token'] = $this->session->data['token'];

        $this->load->model('localisation/language');

        $this->data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->request->post['option_description'])) {
            $this->data['option_description'] = $this->request->post['option_description'];
        } elseif (isset($this->request->get['option_id'])) {
            $this->data['option_description'] = $this->model_catalog_option->getOptionDescriptions($this->request->get['option_id']);
        } else {
            $this->data['option_description'] = array();
        }

        if (isset($this->request->post['type'])) {
            $this->data['type'] = $this->request->post['type'];
        } elseif (!empty($option_info)) {
            $this->data['type'] = $option_info['type'];
        } else {
            $this->data['type'] = '';
        }

        if (isset($this->request->post['sort_order'])) {
            $this->data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($option_info)) {
            $this->data['sort_order'] = $option_info['sort_order'];
        } else {
            $this->data['sort_order'] = '';
        }

        if (isset($this->request->post['product_page'])) {
            $this->data['product_page'] = $this->request->post['product_page'];
        } elseif (!empty($option_info)) {
            $this->data['product_page'] = $option_info['product_page'];
        } else {
            $this->data['product_page'] = '';
        }

        if (isset($this->request->post['filter_option'])) {
            $this->data['filter_option'] = $this->request->post['filter_option'];
        } elseif (!empty($option_info)) {
            $this->data['filter_option'] = $option_info['filter_option'];
        } else {
            $this->data['filter_option'] = 1;
        }

        if (isset($this->request->post['option_value'])) {
            $option_values = $this->request->post['option_value'];
        } elseif (isset($this->request->get['option_id'])) {
            $option_values = $this->model_catalog_option->getOptionValueDescriptions($this->request->get['option_id']);
        } else {
            $option_values = array();
        }

        $this->load->model('tool/image');

        if (isset($this->request->post['parent_option_values'])) {
            $this->data['parent_option_values'] = $this->request->post['parent_option_values'];
        } elseif (isset($this->request->get['option_id'])) {
            $this->data['parent_option_values'] = $this->model_catalog_option->getParentOptionValues($this->request->get['option_id']);
        } else {
            $this->data['parent_option_values'] = array();
        }

        $option_value_ids = array();

        $this->data['option_values'] = array();

        foreach ($option_values as $option_value) {
            if ($option_value['image'] && file_exists(DIR_IMAGE . $option_value['image'])) {
                $image = $option_value['image'];
            } else {
                $image = 'no_image.jpg';
            }
            $this->data['option_values'][] = array(
                'option_value_id'          => $option_value['option_value_id'],
                'option_value_description' => $option_value['option_value_description'],
                'image'                    => $image,
                'thumb'                    => $this->model_tool_image->resize($image, 100, 100),
                'sort_order'               => $option_value['sort_order'],
                'color'                    => $option_value['color'],
            );

            $option_value_ids[] = $option_value['option_value_id'];
        }

        $missing_option_values = array_diff($this->data['parent_option_values'], $option_value_ids);

        if ($missing_option_values) {
            $option_value_data = $this->model_catalog_option->getOptionValueDescriptions(false, $missing_option_values);

            foreach ($option_value_data as $option_value) {
                if ($option_value['image'] && file_exists(DIR_IMAGE . $option_value['image'])) {
                    $image = $option_value['image'];
                } else {
                    $image = 'no_image.jpg';
                }

                $this->data['option_values'][] = array(
                    'option_value_id'          => $option_value['option_value_id'],
                    'option_value_description' => $option_value['option_value_description'],
                    'image'                    => $image,
                    'thumb'                    => $this->model_tool_image->resize($image, 100, 100),
                    'sort_order'               => $option_value['sort_order']
                );
            }
        }

        $this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);

        $this->template = 'catalog/option_form.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/option')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        foreach ($this->request->post['option_description'] as $language_id => $value) {
            if ((utf8_strlen($value['name']) < 1) || (utf8_strlen($value['name']) > 128)) {
                $this->error['name'][$language_id] = $this->language->get('error_name');
            }
        }

        if (($this->request->post['type'] == 'select' ||
                $this->request->post['type'] == 'radiocolor' ||
                $this->request->post['type'] == 'radiolabel' ||
                $this->request->post['type'] == 'checkboxcolor' ||
                $this->request->post['type'] == 'checkboxlabel' ||
                $this->request->post['type'] == 'radio' ||
                $this->request->post['type'] == 'checkbox' ||
                $this->request->post['type'] == 'custom_text') &&
            !isset($this->request->post['option_value'])) {
            $this->error['warning'] = $this->language->get('error_type');
        }

        if (isset($this->request->post['option_value'])) {
            $form_option_values = array();
            foreach ($this->request->post['option_value'] as $option_value_id => $option_value) {
                foreach ($option_value['option_value_description'] as $language_id => $option_value_description) {
                    if ((utf8_strlen($option_value_description['name']) < 1) || (utf8_strlen($option_value_description['name']) > 128)) {
                        $this->error['option_value'][$option_value_id][$language_id] = $this->language->get('error_option_value');
                    }
                }

                $form_option_values[] = $option_value['option_value_id'];
            }

            if (isset($this->request->post['parent_option_values'])) {
                foreach (array_diff($this->request->post['parent_option_values'], $form_option_values) as $option_value_id) {
                    $this->error['dependent_option_value'][$option_value_id] = $this->language->get('error_dependent_option_value');
                }
            }
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'catalog/option')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        $this->load->model('catalog/product');

        foreach ($this->request->post['selected'] as $option_id) {
            $product_total = $this->model_catalog_product->getTotalProductsByOptionId($option_id);

            if ($product_total) {
                $this->error['warning'] = sprintf($this->language->get('error_product'), $product_total);
            }
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    public function autocomplete() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $this->language->load('catalog/option');

            $this->load->model('catalog/option');

            $this->load->model('tool/image');

            $data = array(
                'filter_name' => $this->request->get['filter_name'],
                'start'       => 0,
                'limit'       => 20
            );

            $options = $this->model_catalog_option->getOptions($data);

            foreach ($options as $option) {
                $option_value_data = array();

                if ($option['type'] == 'select' ||
                    $option['type'] == 'radiocolor' ||
                    $option['type'] == 'radiolabel' ||
                    $option['type'] == 'checkboxcolor' ||
                    $option['type'] == 'checkboxlabel' ||
                    $option['type'] == 'radio' ||
                    $option['type'] == 'checkbox' ||
                    $option['type'] == 'image' ||
                    $option['type'] == 'custom_text') {

                    $option_values = $this->model_catalog_option->getOptionValues($option['option_id']);

                    foreach ($option_values as $option_value) {
                        if ($option_value['image'] && file_exists(DIR_IMAGE . $option_value['image'])) {
                            $image = $this->model_tool_image->resize($option_value['image'], 50, 50);
                        } else {
                            $image = '';
                        }
                        $option_value_data[] = array(
                            'option_value_id' => $option_value['option_value_id'],
                            'name'            => html_entity_decode($option_value['name'], ENT_QUOTES, 'UTF-8'),
                            'image'           => $image
                        );
                    }

                    $sort_order = array();

                    foreach ($option_value_data as $key => $value) {
                        $sort_order[$key] = $value['name'];
                    }

                    array_multisort($sort_order, SORT_ASC, $option_value_data);
                }

                $type = '';

                if ($option['type'] == 'select' ||
                    $option['type'] == 'radio' ||
                    $option['type'] == 'checkboxcolor' ||
                    $option['type'] == 'checkboxlabel' ||
                    $option['type'] == 'radiocolor'  ||
                    $option['type'] == 'radiolabel' ||
                    $option['type'] == 'checkbox' ||
                    $option['type'] == 'image' ||
                    $option['type'] == 'custom_text') {
                    $type = $this->language->get('text_choose');
                }

                /*if ($option['type'] == 'text' || $option['type'] == 'textarea') {
                    $type = $this->language->get('text_input');
                }

                if ($option['type'] == 'file') {
                    $type = $this->language->get('text_file');
                }

                if ($option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
                    $type = $this->language->get('text_date');
                }*/

                $json[] = array(
                    'option_id'    => $option['option_id'],
                    'name'         => strip_tags(html_entity_decode($option['name'], ENT_QUOTES, 'UTF-8')),
                    'product_page' => isset($option['product_page']) ? ((int)$option['product_page']) : '',
                    'category'     => $type,
                    'filter_option' => isset($option['filter_option']) ? ((int)$option['filter_option']) : 1,
                    'type'         => $option['type'],
                    'option_value' => $option_value_data
                );
            }
        }

        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->setOutput(json_encode($json));
    }
}
?>
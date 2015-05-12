<?php

class ControllerModuleLanguage extends Controller
{
    protected function index()
    {
        if (isset($this->request->post['language_code'])) {
            $this->session->data['language'] = $this->request->post['language_code'];
            if (isset($this->request->post['redirect'])) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language");
                foreach ($query->rows as $language) {
                    $this->request->post['redirect'] = str_replace('/' . $language['code'] . '/', '/' . $this->request->post['language_code'] . '/', $this->request->post['redirect']);
                }
                $query = $this->db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE code = '" . $this->request->post['language_code'] . "'");
                $this->config->set('config_language_id', $query->row['language_id']);

                if ((isset($this->session->data['proute'])) && ($this->session->data['proute'] == 'product/product')) {
                    $this->redirect($this->url->link('product/product', 'product_id=' . $this->session->data['product_id']));
                } elseif ((isset($this->session->data['proute'])) && ($this->session->data['proute'] == 'product/category')) {
                    $this->redirect($this->url->link('product/category', 'path=' . $this->session->data['path']));
                } elseif ((isset($this->session->data['proute'])) && ($this->session->data['proute'] == 'product/manufacturer/info')) {
                    $this->redirect($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->session->data['manufacturer_id']));
                } elseif ((isset($this->session->data['proute'])) && ($this->session->data['proute'] == 'information/information')) {
                    $this->redirect($this->url->link('information/information', 'information_id=' . $this->session->data['information_id']));
                } elseif (isset($this->session->data['proute'])) {
                    $this->redirect($this->url->link($this->session->data['proute']));
                } else {
                    $this->redirect($this->request->post['redirect']);
                }
            } else {
                $this->redirect($this->url->link('common/home'));
            }
        }

        $this->language->load('module/language');

        $this->data['text_language'] = $this->language->get('text_language');

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $connection = 'SSL';
        } else {
            $connection = 'NONSSL';
        }

        $this->data['action'] = $this->url->link('module/language', '', $connection);

        $this->data['language_code'] = $this->session->data['language'];

        $this->load->model('localisation/language');

        $this->data['languages'] = array();

        $results = $this->model_localisation_language->getLanguages();

        foreach ($results as $result) {
            if ($result['status']) {
                $this->data['languages'][] = array(
                    'name' => $result['name'],
                    'code' => $result['code'],
                    'image' => $result['image']
                );
            }
        }

        if (!isset($this->request->get['route'])) {
            $this->data['redirect'] = $this->url->link('common/home');
        } else {
            $data = $this->request->get;

            unset($data['_route_']);

            $route = $data['route'];

            unset($data['route']);

            $url = '';

            if ($data) {
                $url = '&' . urldecode(http_build_query($data, '', '&'));
            }

            Debug::log($route);
            Debug::log($url);
            Debug::log($connection);
            $this->data['redirect'] = $this->url->link($route, $url, $connection);
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/language.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/language.tpl';
        } else {
            $this->template = 'default/template/module/language.tpl';
        }

        $this->render();
    }
}

?>
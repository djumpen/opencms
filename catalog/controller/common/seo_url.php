<?php

class ControllerCommonSeoUrl extends Controller
{
    public function index()
    {
        // Add rewrite to url class
        if ($this->config->get('config_seo_url')) {
            $this->url->addRewrite($this);
        }
        if (isset($this->request->get['_route_'])) {
            $lquery = $this->db->query("SELECT * FROM " . DB_PREFIX . "language;");
            foreach ($lquery->rows as $language) {
                if ((strpos($this->request->get['_route_'], $language['code'] . '/')) === 0) {
                    $this->session->data['language'] = $language['code'];
                    $this->language = new Language($language['directory']);
                    $this->language->load($language['filename']);
                    $this->registry->set('language', $this->language);
                    $this->config->set('config_language_id', $language['language_id']);
                    $this->request->get['_route_'] = substr($this->request->get['_route_'], strlen($language['code'] . '/'));

                }
            }
            if ($this->request->get['_route_'] == '') {
                unset($this->request->get['_route_']);
                $this->session->data['proute'] = 'common/home';
            }

        } elseif (isset($this->request->get['route'])
            && !$this->request->isXhr()
            && !substr_count($this->request->get['route'], 'module')
            && !substr_count($this->request->get['route'], 'captcha')
        ) {
            $this->session->data['proute'] = str_replace('route=', '', $_SERVER['QUERY_STRING']);
        }
        // Decode URL
        if (isset($this->request->get['_route_'])) {
            $parts = explode('/', $this->request->get['_route_']);

            foreach ($parts as $part) {
                $query = $this->db->query("SELECT u.query, u.keyword, u.language_id as lid, l.code, l.filename, l.directory FROM " . DB_PREFIX . "url_alias u left join " . DB_PREFIX . "language l on u.language_id = l.language_id WHERE u.keyword = '" . $this->db->escape($part) . "'");

                if ($query->num_rows) {
                    $url = explode('=', $query->row['query']);

                    if ($url[0] == 'information_id') {
                        if (($this->session->data['language'] <> $query->row['code']) || (!isset($this->session->data['language']))) {
                            $this->session->data['language'] = $query->row['code'];
                            $this->language = new Language($query->row['directory']);
                            $this->language->load($query->row['filename']);
                            $this->registry->set('language', $this->language);
                            $this->config->set('config_language_id', $query->row['lid']);
                        }
                        $this->request->get['information_id'] = $url[1];
                    }
                } else {
                    if (!empty($this->request->post)) {
                        die;
                    }
                    $this->request->get['route'] = 'error/not_found';
                }
            }

           if ($this->request->get['_route_'] == 'contact') {
                $this->request->get['route'] = 'information/contact';
            } elseif ($this->request->get['_route_'] == 'account') {
                $this->request->get['route'] = 'account/account';
            } elseif ($this->request->get['_route_'] == 'login') {
                $this->request->get['route'] = 'account/login';
            } elseif ($this->request->get['_route_'] == 'logout') {
                $this->request->get['route'] = 'account/logout';
            } elseif ($this->request->get['_route_'] == 'register') {
               $this->request->get['route'] = 'account/register/ajax2register';
            } elseif ($this->request->get['_route_'] == 'activate') {
                $this->request->get['route'] = 'account/register/activate';
            } elseif ($this->request->get['_route_'] == 'profile') {
                $this->request->get['route'] = 'account/profile';
            }

            if (isset($this->request->get['route']) && !$this->request->isXhr()) {
                $this->session->data['proute'] = $this->request->get['route'];
            }
            if (isset($this->request->get['route'])) {
                return $this->forward($this->request->get['route']);
            }
        } /*else {
            unset($this->session->data['proute']);
        }*/
    }

    public function rewrite($link)
    {

        $url_info = parse_url(str_replace('&amp;', '&', $link));

        $squery = $this->db->query("SELECT `value` FROM `" . DB_PREFIX . "setting` WHERE `key` = 'config_language'");

        if (isset($this->session->data['language']) && ($this->session->data['language'] <> $squery->row['value'])) {
            $url = '/' . $this->session->data['language'];
        } else {
            $url = '';
        }

        $data = array();
        parse_str($url_info['query'], $data);
        foreach ($data as $key => $value) {
            if (isset($data['route'])) {
                if (
                    ($data['route'] == 'product/product' && $key == 'product_id') ||
                    (
                        ($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id'
                    ) ||
                    (
                        $data['route'] == 'information/information' && $key == 'information_id'
                    )
                ) {
                    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE language_id = " . (int)$this->config->get('config_language_id') . " AND `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

                    if ($query->num_rows) {
                        $url .= '/' . $query->row['keyword'];

                        unset($data[$key]);
                    }
                } elseif (isset($data['route']) && $data['route'] == 'common/home') {
                    $url .= '/';

                } elseif (isset($data['route']) && $data['route'] == 'information/contact') {
                    $url .= '/contact';
                } elseif (isset($data['route']) && $data['route'] == 'account/account') {
                    $url .= '/account';
                } elseif (isset($data['route']) && $data['route'] == 'account/login') {
                    $url .= '/login';
                } elseif (isset($data['route']) && $data['route'] == 'account/logout') {
                    $url .= '/logout';
                } elseif (isset($data['route']) && $data['route'] == 'account/register/ajax2register') {
                    $url .= '/register';
                } elseif (isset($data['route']) && $data['route'] == 'account/register/activate') {
                    $url .= '/activate';
                    break;
                } elseif (isset($data['route']) && $data['route'] == 'account/profile') {
                    $url .= '/profile';
                    break;
                }

            }
        }

        /* Save filter on change page */

        if (($url) && ($url <> '/' . $this->session->data['language'])) {
            unset($data['route']);
            $query = '';
            if ($data) {
                foreach ($data as $key => $value) {
                    $query .= '&' . $key . '=' . $value;
                }
                if ($query) {
                    $query = '?' . trim($query, '&');
                }
            }
            return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
        } else {
            return $link;
        }
    }
}
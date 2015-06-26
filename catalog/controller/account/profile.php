<?php
class ControllerAccountProfile extends Controller {
    public function index() {

//      $this->session->data['proute'] = 'account/profile';

        $this->language->load('account/profile');

        $titles = $this->config->get('config_title');
        $this->document->setTitle($titles[$this->config->get('config_language_id')] . ' - ' . $this->language->get('heading_title'));
        $this->document->addLink($this->config->get('config_url'), 'canonical');
        $this->document->setKeywords($this->config->get('config_meta_keywords'));
        $meta_descriptions = $this->config->get('config_meta_description');
        $this->document->setDescription($meta_descriptions[$this->config->get('config_language_id')]);

        $this->data['heading_title'] = $titles[$this->config->get('config_language_id')];

        $this->template = 'default/template/account/profile.tpl';

        $this->children = array(
            'common/account_top',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());

    }
}
?>
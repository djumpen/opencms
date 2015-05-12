<?php  
class ControllerCommonHomeTop extends Controller {

    public function index() {

        $this->data['register_action'] = $this->url->link('account/register/ajax2register');
        $this->data['forgot_action'] = $this->url->link('account/forgot');
        $this->data['login_action'] = $this->url->link('account/login');

        $this->language->load('common/home_top');
        $this->applyLangVars();

        $this->template = 'default/template/common/home_top.tpl';
		$this->response->setOutput($this->render());
	}
}
?>
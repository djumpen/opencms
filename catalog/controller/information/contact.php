<?php 
class ControllerInformationContact extends Controller {
	private $error = array(); 

	public function index() {
		$this->language->load('information/contact');

		$this->document->setTitle($this->language->get('heading_title'));
        $this->document->addScript(SCRIPT_FOLDER . 'contactPage.js', true);
        // !exit if not valid and is xhr
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->request->post['email']);
			$mail->setSender($this->request->post['name']);
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('email_subject'), $this->request->post['name']), ENT_QUOTES, 'UTF-8'));
			$mail->setText(strip_tags(html_entity_decode($this->request->post['enquiry'], ENT_QUOTES, 'UTF-8')));
			$mail->send();
            if($this->request->isXhr()) {
                exit(json_encode(array('ok' => $this->language->get('text_contact_success'))));
            }
			$this->redirect($this->url->link('information/contact/success'));
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
			'separator' => false
			);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/contact'),
			'separator' => $this->language->get('text_separator')
			);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_location'] = $this->language->get('text_location');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_address'] = $this->language->get('text_address');
		$this->data['text_telephone'] = $this->language->get('text_telephone');
		$this->data['text_fax'] = $this->language->get('text_fax');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_enquiry'] = $this->language->get('entry_enquiry');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');
        
		$this->data['title_management'] = $this->language->get('title_management');
        
		$this->data['title_director'] = $this->language->get('title_director');
		$this->data['title_director_name'] = $this->language->get('title_director_name');
        
        
		$this->data['title_com_director'] = $this->language->get('title_com_director');
		$this->data['title_com_director_name'] = $this->language->get('title_com_director_name');
        
		$this->data['title_head_sale'] = $this->language->get('title_head_sale');
        $this->data['title_head_sale_name'] = $this->language->get('title_head_sale_name');
        
		$this->data['title_engineer'] = $this->language->get('title_engineer');
		$this->data['title_engineer_name'] = $this->language->get('title_engineer_name');
        
		$this->data['title_sale'] = $this->language->get('title_sale');
		$this->data['title_division'] = $this->language->get('title_division');
		$this->data['title_accounting'] = $this->language->get('title_accounting');
		$this->data['title_desing'] = $this->language->get('title_desing');
        
		$this->data['text_rep'] = $this->language->get('text_rep');
		$this->data['text_rep_address'] = $this->language->get('text_rep_address');
		$this->data['text_rep_address_m'] = $this->language->get('text_rep_address_m');
        
		$this->data['text_req_uk'] = $this->language->get('text_req_uk');
		$this->data['text_req_uk_text'] = $this->language->get('text_req_uk_text');
        
		$this->data['text_req_abroad'] = $this->language->get('text_req_abroad');
		$this->data['text_req_abroad_text'] = $this->language->get('text_req_abroad_text');

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}

		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}		

		if (isset($this->error['enquiry'])) {
			$this->data['error_enquiry'] = $this->error['enquiry'];
		} else {
			$this->data['error_enquiry'] = '';
		}		

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['action'] = $this->url->link('information/contact');
		$this->data['store'] = $this->config->get('config_name');
		$this->data['address'] = nl2br($this->config->get('config_address'));
		$this->data['telephone'] = $this->config->get('config_telephone');
		$this->data['fax'] = $this->config->get('config_fax');

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} else {
			$this->data['name'] = $this->customer->getFirstName();
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = $this->customer->getEmail();
		}

		if (isset($this->request->post['enquiry'])) {
			$this->data['enquiry'] = $this->request->post['enquiry'];
		} else {
			$this->data['enquiry'] = '';
		}

		
		
		$config_contacts = $this->config->get('config_contacts');
		if(isset($config_contacts[$this->config->get('config_language_id')])) {
			$this->data['config_contacts'] = $config_contacts[$this->config->get('config_language_id')];
		} else {
			$this->data['config_contacts'] = array();
		}
		
		/* layout patch - choose template by path */
		$this->load->model ( 'design/layout' );
		if (isset ( $this->request->get ['route'] )) {
			$route = ( string ) $this->request->get ['route'];
		} else {
			$route = 'common/home';
		}
		$layout_template = $this->model_design_layout->getLayoutTemplate($route);
		if(!$layout_template){
			$layout_template = 'contact';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/' . $layout_template . '.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/' . $layout_template . '.tpl';
		} else {
			$this->template = 'default/template/information/' . $layout_template . '.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
			);

		$this->response->setOutput($this->render());
	}
	
	public function callme() {
		if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
			$this->load->language('information/callme');
			if(isset($this->request->post) && !empty($this->request->post)) {
				if($this->validateCallme($this->request->post)) {
					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->hostname = $this->config->get('config_smtp_host');
					$mail->username = $this->config->get('config_smtp_username');
					$mail->password = $this->config->get('config_smtp_password');
					$mail->port = $this->config->get('config_smtp_port');
					$mail->timeout = $this->config->get('config_smtp_timeout');
					$mail->setTo($this->config->get('config_email'));
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender($this->config->get('config_email'));
					$mail->setSubject($this->language->get('email_subject'));
					$mail->setText(
						strip_tags(
							html_entity_decode(
								$this->language->get('entry_name') . ": " . $this->request->post['name'] . "\n" . 
								$this->language->get('entry_phone') . ": " . $this->request->post['phone'] . "\n" . 
								$this->language->get('entry_comment') . ": " . $this->request->post['comment'] . "\n", 
								ENT_QUOTES, 
								'UTF-8'
								)
							)
						);
					$mail->send();
					$this->data['status'] = true;
					$this->data['text']   = $this->language->get('text_submited');
					exit(json_encode($this->data));
				} else {
					$this->data['errors'] = $this->error;
					exit(json_encode($this->data));
				}
				
			} else {
				$this->data['entry_name']    = $this->language->get('entry_name');
				$this->data['entry_phone']   = $this->language->get('entry_phone');
				$this->data['entry_comment'] = $this->language->get('entry_comment');
				$this->data['entry_captcha'] = $this->language->get('entry_captcha');
				$this->data['entry_send'] = $this->language->get('entry_send');
				$this->data['entry_title_call'] = $this->language->get('entry_title_call');
			}
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/callme.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/information/callme.tpl';
			} else {
				$this->template = 'default/template/information/callme.tpl';
			}
			$this->response->setOutput($this->render());
		}
	}
	
	private function validateCallme($post) {
		$this->error = array();
		if(!isset($post['phone']) || strlen($post['phone']) < 6) {
			$this->error = array('phone');
		}
		if(!isset($post['name']) || strlen($post['name']) < 3) {
			$this->error = array('name');
		}
		
		return empty($this->error);
	}

	public function success() {
		$this->language->load('information/contact');

		$this->document->setTitle($this->language->get('heading_title')); 

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
			);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/contact'),
			'separator' => $this->language->get('text_separator')
			);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_message'] = $this->language->get('text_message');

		$this->data['button_continue'] = $this->language->get('button_continue');
		
		$this->data['entry_send'] = $this->language->get('entry_send');
		$this->data['entry_title_call'] = $this->language->get('entry_title_call');

		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/success.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/success.tpl';
		} else {
			$this->template = 'default/template/common/success.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
			);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (!preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['enquiry']) < 10) || (utf8_strlen($this->request->post['enquiry']) > 3000)) {
			$this->error['enquiry'] = $this->language->get('error_enquiry');
		}

		if (!$this->error) {
			return true;
		} else {
            if($this->request->isXhr()) {
                $errors = array();
                foreach ($this->error as $error) {
                    $errors[] = $error;
                }

                exit(json_encode(array('errors' =>$errors)));
            }
			return false;
		}  	  
	}

	public function captcha() {
		$this->load->library('captcha');

		$captcha = new Captcha();

		$this->session->data['captcha'] = $captcha->getCode();

		$captcha->showImage();
	}	
}
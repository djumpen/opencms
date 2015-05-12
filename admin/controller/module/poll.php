<?php
class ControllerModulePoll extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->model_fido_poll->checkPolls();

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('poll', $this->request->post);		

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getModule();
	}

	public function insert() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) {
			$this->model_fido_poll->addPoll($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validateForm())) {
			$this->model_fido_poll->editPoll($this->request->get['poll_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->document->setTitle($this->language->get('heading_title'));

		if ((isset($this->request->post['selected'])) && ($this->validateDelete())) {
			foreach ($this->request->post['selected'] as $poll_id) {
				$this->model_fido_poll->deletePoll($poll_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getList();
	}

	public function listing() {
		$this->load->language('module/poll');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->getList();
	}

	private function getModule() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_polls'] = $this->language->get('button_polls');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
			'separator' => FALSE
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_module'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('heading_title'),
			'separator' => ' :: '
		);

		$this->data['polls']  = $this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action']  = $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel']  = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();
		
		if (isset($this->request->post['poll_module'])) {
			$this->data['modules'] = $this->request->post['poll_module'];
		} elseif ($this->config->get('poll_module')) { 
			$this->data['modules'] = $this->config->get('poll_module');
		}				
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/poll.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function getList() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_question'] = $this->language->get('column_question');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_active'] = $this->language->get('column_active');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_module'] = $this->language->get('button_module');
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');

		$this->data['tab_general']  = $this->language->get('tab_general');
		$this->data['tab_data']  = $this->language->get('tab_data');

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
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
			'separator' => FALSE
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('heading_title'),
			'separator' => ' :: '
		);

		$this->data['module'] = $this->url->link('module/poll', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['newpoll'] = $this->url->link('module/poll/new_poll', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['results'] = $this->url->link('module/poll/results', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['change']  = $this->url->link('module/poll/change', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['insert'] = $this->url->link('module/poll/insert', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('module/poll/delete', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['questions'] = array();

		$results = $this->model_fido_poll->getPolls();

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('module/poll/update', 'token=' . $this->session->data['token'] . '&poll_id=' . $result['poll_id'], 'SSL')
			);

			$this->data['questions'][] = array(
				'poll_id'    => $result['poll_id'],
				'question'   => $result['question'],
				'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'active'     => ($result['active'] ? $this->language->get('text_active') : $this->language->get('text_inactive')),
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'selected'   => isset($this->request->post['selected']) && in_array($result['poll_id'], $this->request->post['selected']),
				'action'     => $action
			);
		}

		$this->template = 'module/poll/list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function getForm() {
		$this->load->language('module/poll');
		$this->load->model('fido/poll');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_active'] = $this->language->get('text_active');
		$this->data['text_inactive'] = $this->language->get('text_inactive');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_new_poll'] = $this->language->get('text_new_poll');
		$this->data['text_no_votes'] = $this->language->get('text_no_votes');
		$this->data['text_default'] = $this->language->get('text_default');

		$this->data['entry_question'] = $this->language->get('entry_question');
		$this->data['entry_store'] = $this->language->get('entry_store');

		for ($i = 1; $i <= 8; $i++) {
			$this->data['entry_answer_' . $i] = $this->language->get('entry_answer_' . $i);
		}

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_active'] = $this->language->get('entry_active');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_data'] = $this->language->get('tab_data');
		$this->data['tab_results'] = $this->language->get('tab_results');

		// Extract results
		if (isset($this->request->get['poll_id'])) {
			$poll_id = $this->request->get['poll_id'];

			$poll_data = $this->model_fido_poll->getPollData($poll_id);

			$reactions = $this->model_fido_poll->getPollResults($poll_id);

			$total_votes = $this->model_fido_poll->getTotalResults($poll_id);

			if ($reactions) {
				$this->data['reactions'] = TRUE;

				$percent = array(0, 0, 0, 0, 0, 0, 0, 0);

				$totals  = array(0, 0, 0, 0, 0, 0, 0, 0);

				foreach($reactions as $reaction) {
					$totals[$reaction['answer'] - 1]++;
				}

				for($i = 0; $i < 8; $i++) {
					$percent[$i] = round(100 * ($totals[$i]/$total_votes));
				}

				$this->data['poll_data'] = $poll_data;
				$this->data['percent'] = $percent;
				$this->data['total_votes'] = $total_votes;

				$this->data['text_poll_results'] = $this->language->get('text_poll_results');
				$this->data['text_percent'] = $this->language->get('text_percent');
				$this->data['text_answer'] = $this->language->get('text_answer');
			}
		}
		// End extraction of results

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['question'])) {
			$this->data['error_question'] = $this->error['question'];
		} else {
			$this->data['error_question'] = '';
		}

		for ($i = 1; $i <= 8; $i++) {
			if (isset($this->error['answer_' . $i])) {
				$this->data['error_answer_' . $i] = $this->error['answer_' . $i];
			} else {
				$this->data['error_answer_' . $i] = '';
			}
		}

		if (isset($this->error['active_poll'])) {
			$this->data['error_active_poll'] = $this->error['active_poll'];
		} else {
			$this->data['error_active_poll'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('text_home'),
			'separator' => FALSE
		);

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL'),
			'text'      => $this->language->get('heading_title'),
			'separator' => ' :: '
		);

		if (!isset($this->request->get['poll_id'])) {
    		$this->data['new_poll'] = TRUE;

			$this->data['action'] = $this->url->link('module/poll/insert', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['action'] = $this->url->link('module/poll/update', 'token=' . $this->session->data['token'] . '&poll_id=' . $this->request->get['poll_id'], 'SSL');
		}

		$this->data['cancel'] = $this->url->link('module/poll/listing', 'token=' . $this->session->data['token'], 'SSL');

		if ((isset($this->request->get['poll_id'])) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
     		$poll_info = $this->model_fido_poll->getPoll($this->request->get['poll_id']);
    	}

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['poll_description'])) {
			$this->data['poll_description'] = $this->request->post['poll_description'];
		} elseif (isset($poll_info)) {
			$this->data['poll_description'] = $this->model_fido_poll->getPollDescriptions($this->request->get['poll_id']);
		} else {
			$this->data['poll_description'] = array();
		}

		$this->load->model('setting/store');

		$this->data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['poll_store'])) {
			$this->data['poll_store'] = $this->request->post['poll_store'];
		} elseif (isset($poll_info)) {
			$this->data['poll_store'] = $this->model_fido_poll->getPollStores($this->request->get['poll_id']);
		} else {
			$this->data['poll_store'] = array(0);
		}			

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (isset($poll_info)) {
			$this->data['status'] = $poll_info['status'];
		} else {
			$this->data['status'] = '';
		}

		if (isset($this->request->post['active'])) {
			$this->data['active'] = $this->request->post['active'];
		} elseif (isset($poll_info)) {
			$this->data['active'] = $poll_info['active'];
		} else {
			$this->data['active'] = '';
		}

		$this->template = 'module/poll/form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/poll')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'module/poll')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['poll_description'] as $language_id => $value) {
			if ((strlen(utf8_decode($value['question'])) < 2) || (strlen(utf8_decode($value['question'])) > 255)) {
				$this->error['question'][$language_id] = $this->language->get('error_question');
			}

			for ($i = 1; $i <= 8; $i++) {
				if ((strlen(utf8_decode($value['answer_' . $i])) > 0) && ((strlen(utf8_decode($value['answer_' . $i])) < 2) || (strlen(utf8_decode($value['answer_' . $i])) > 255))) {
					$this->error['answer_' . $i][$language_id] = $this->language->get('error_answer');
				}
			}

			if ($this->request->post['active'] == 1) {
				$check_active_poll = $this->model_fido_poll->checkActivePoll();

				if ($check_active_poll) {
					$active_poll = $this->model_fido_poll->getActivePoll();

					if ($active_poll['poll_id'] != $this->request->get['poll_id']) {
						$this->error['active_poll'][$language_id] = $this->language->get('error_active_poll');
					}
				}
			}
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'module/poll')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE; 
		} else {
			return FALSE;
		}
	}
}
?>

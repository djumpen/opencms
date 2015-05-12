<?php
class ControllerInformationPoll extends Controller {
	public function index() {
		$this->load->language('information/poll');
		$this->load->model('fido/poll');

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['poll_answer'])) {
			$this->model_fido_poll->addReaction($this->request->post);

			// Set a cookie:
			setcookie('poll_answered', $this->request->post['poll_id'], time()+60*60*24*7); // Can only vote once a week

			// Return to the referer page, the page from which the vote was cast:
			$this->redirect(html_entity_decode($this->request->server['HTTP_REFERER']));
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'href'      => $this->url->link('common/home'),
			'text'      => $this->language->get('text_home'),
			'separator' => FALSE
		);

		$active_poll = $this->model_fido_poll->getActivePoll();

		if ($active_poll) {
			$poll_id = $active_poll['poll_id'];
		} else {
			$poll_id = 0;
		}

		if ($poll_id != 0) {
			$this->document->setTitle($this->language->get('heading_title'));

			$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('information/poll'),
				'text'      => $this->language->get('heading_title'),
				'separator' => $this->language->get('text_separator')
			);

			$this->data['heading_title'] = $this->language->get('heading_title');

			$this->data['text_no_votes'] = $this->language->get('text_no_votes');
			$this->data['text_total_votes'] = $this->language->get('text_total_votes');
			$this->data['text_enlargement'] = $this->language->get('text_enlargement');

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

				$this->data['percent'] = $percent;
				$this->data['total_votes'] = $total_votes;
				$this->data['poll_data'] = $this->model_fido_poll->getPollData($poll_id);

				$this->data['text_poll_results'] = $this->language->get('text_poll_results');
				$this->data['text_percent'] = $this->language->get('text_percent');
				$this->data['text_answer'] = $this->language->get('text_answer');
			}

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['enlargement'] = $this->url->link('information/poll/get_chart', 'poll_id=' . $poll_id);
			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/poll.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/information/poll.tpl';
			} else {
				$this->template = 'default/template/information/poll.tpl';
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
    	} else {
			$this->document->setTitle($this->language->get('text_error'));

			$this->data['breadcrumbs'][] = array(
				'href'      => $this->url->link('information/poll'),
				'text'      => $this->language->get('text_error'),
				'separator' => $this->language->get('text_separator')
			);

			$this->data['heading_title'] = $this->language->get('text_error');

			$this->data['text_error'] = $this->language->get('text_error');

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
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
	}

	public function get_chart() {
		$this->load->model('fido/poll');

		if (isset($this->request->get['poll_id'])) {
			$poll_id = $this->request->get['poll_id'];
		} else {
			$poll_id = 0;
		}

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
		}

		$labels = array();
		$values = array();

		for($i = 0; $i < 8; $i++) {
			if (!empty($poll_data['answer_' . ($i + 1)])) {
				array_push($labels, $poll_data['answer_' . ($i + 1)]);
				array_push($values, $percent[$i]);
			}
		}

		$labels = implode('|', $labels);
		$values = implode(',', $values);

		$output  = '<div class="big_chart">';
		$output .= '<img src="http://chart.apis.google.com/chart?cht=p3&chco=303F4A,E4EEF7,849721&chd=t:' . $values . '&chs=770x200&chl=' . $labels . '" style="width: 100%; height: 200px;" alt="chart" />';
		$output .= '</div>';

		$this->response->setOutput($output);
	}
}
?>

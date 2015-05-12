<?php
class ModelFidoPoll extends Model {
	public function addPoll($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "poll SET status = '" . (int)$this->request->post['status'] . "', active = '" . (int)$this->request->post['active'] . "', date_added = now()");
		$poll_id = $this->db->getLastId();
		foreach ($data['poll_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "poll_description SET poll_id = '" . (int)$poll_id . "', language_id = '" . (int)$language_id . "', question = '" . $this->db->escape($value['question']) . "', answer_1 = '" . $this->db->escape($value['answer_1']) . "', answer_2 = '" . $this->db->escape($value['answer_2']) . "', answer_3 = '" . $this->db->escape($value['answer_3']) . "', answer_4 = '" . $this->db->escape($value['answer_4']) . "', answer_5 = '" . $this->db->escape($value['answer_5']) . "', answer_6 = '" . $this->db->escape($value['answer_6']) . "', answer_7 = '" . $this->db->escape($value['answer_7']) . "', answer_8 = '" . $this->db->escape($value['answer_8']) . "'");
		}
		if (isset($data['poll_store'])) {
			foreach ($data['poll_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "poll_to_store SET poll_id = '" . (int)$poll_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		$this->cache->delete('poll');
	}

	public function editPoll($poll_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "poll SET status = '" . (int)$data['status'] . "', active = '" . (int)$this->request->post['active'] . "' WHERE poll_id = '" . (int)$poll_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "poll_description WHERE poll_id = '" . (int)$poll_id . "'");
		foreach ($data['poll_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "poll_description SET poll_id = '" . (int)$poll_id . "', language_id = '" . (int)$language_id . "', question = '" . $this->db->escape($value['question']) . "', answer_1 = '" . $this->db->escape($value['answer_1']) . "', answer_2 = '" . $this->db->escape($value['answer_2']) . "', answer_3 = '" . $this->db->escape($value['answer_3']) . "', answer_4 = '" . $this->db->escape($value['answer_4']) . "', answer_5 = '" . $this->db->escape($value['answer_5']) . "', answer_6 = '" . $this->db->escape($value['answer_6']) . "', answer_7 = '" . $this->db->escape($value['answer_7']) . "', answer_8 = '" . $this->db->escape($value['answer_8']) . "'");
		}
		$this->db->query("DELETE FROM " . DB_PREFIX . "poll_to_store WHERE poll_id = '" . (int)$poll_id . "'");
		if (isset($data['poll_store'])) {
			foreach ($data['poll_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "poll_to_store SET poll_id = '" . (int)$poll_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		$this->cache->delete('poll');
	}

	public function deletePoll($poll_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "poll WHERE poll_id = '" . (int)$poll_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "poll_description WHERE poll_id = '" . (int)$poll_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "poll_to_store WHERE poll_id = '" . (int)$poll_id . "'");
		$this->cache->delete('poll');
	}	

	public function getPoll($poll_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "poll WHERE poll_id = '" . (int)$poll_id . "'");
		return $query->row;
	}

	public function getPollDescriptions($poll_id) {
		$poll_description_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll_description WHERE poll_id = '" . (int)$poll_id . "'");
		foreach ($query->rows as $result) {
			$poll_description_data[$result['language_id']] = array(
				'question' => $result['question'],
				'answer_1' => $result['answer_1'],
				'answer_2' => $result['answer_2'],
				'answer_3' => $result['answer_3'],
				'answer_4' => $result['answer_4'],
				'answer_5' => $result['answer_5'],
				'answer_6' => $result['answer_6'],
				'answer_7' => $result['answer_7'],
				'answer_8' => $result['answer_8']
			);
		}
		return $poll_description_data;
	}

	public function getPolls() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll p LEFT JOIN " . DB_PREFIX . "poll_description pd ON (p.poll_id = pd.poll_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY p.date_added");
		return $query->rows;
	}

	public function getTotalPolls() {
     	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "poll");
		return $query->row['total'];
	}

	public function checkActivePoll() {
     	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "poll WHERE active = '1'");
		return $query->row['total'];
	}

	public function getActivePoll() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll WHERE active = '1'");
		return $query->row;
	}

	public function getPollData($poll_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll p LEFT JOIN " . DB_PREFIX . "poll_description pd ON (p.poll_id = pd.poll_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.poll_id = '" . (int)$poll_id . "'");
		return $query->row;
	}

	public function getPollResults($poll_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll_reactions WHERE poll_id = '" . (int)$poll_id . "'");
		return $query->rows;
	}

	public function getTotalResults($poll_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "poll_reactions WHERE poll_id = '" . (int)$poll_id . "'");
		return $query->row['total'];
	}

	public function getPollStores($poll_id) {
		$poll_store_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "poll_to_store WHERE poll_id = '" . (int)$poll_id . "'");
		foreach ($query->rows as $result) {
			$poll_store_data[] = $result['store_id'];
		}
		return $poll_store_data;
	}

	public function checkPolls() {
		$create_poll = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "poll` (`poll_id` int(11) NOT NULL auto_increment, `status` int(1) NOT NULL default '1', `active` int(1) NOT NULL default '1', `date_added` datetime NOT NULL default '0000-00-00 00:00:00', PRIMARY KEY  (`poll_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;";
		$this->db->query($create_poll);
		$create_poll_descriptions = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "poll_description` (`poll_id` int(11) NOT NULL, `language_id` int(11) NOT NULL, `question` varchar(255) collate utf8_bin NOT NULL default '', `answer_1` varchar(255) collate utf8_bin NOT NULL default '', `answer_2` varchar(255) collate utf8_bin NOT NULL default '', `answer_3` varchar(255) collate utf8_bin NOT NULL default '', `answer_4` varchar(255) collate utf8_bin NOT NULL default '', `answer_5` varchar(255) collate utf8_bin NOT NULL default '', `answer_6` varchar(255) collate utf8_bin NOT NULL default '', `answer_7` varchar(255) collate utf8_bin NOT NULL default '', `answer_8` varchar(255) collate utf8_bin NOT NULL default '', PRIMARY KEY  (`poll_id`,`language_id`), KEY `question` (`question`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;";
		$this->db->query($create_poll_descriptions);
		$create_poll_reactions = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "poll_reactions` (`poll_reaction_id` int(11) NOT NULL auto_increment, `poll_id` int(11) NOT NULL, `answer` int(11) NOT NULL, PRIMARY KEY  (`poll_reaction_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;";
		$this->db->query($create_poll_reactions);
		$create_poll_to_store = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "poll_to_store` (`poll_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, PRIMARY KEY  (`poll_id`, `store_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;";
		$this->db->query($create_poll_to_store);
	}
}
?>

<?php
class ModelAccountCustomer extends Model {
	public function addCustomer($data) {
		if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $data['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

        $no_required_fields = [
            'firstname',
            'lastname',
            'password',
            'telephone',
            'company',
            'company_id',
            'address_1',
            'address_2',
            'city',
            'postcode',
            'country_id',
            'postcode',
            'country_id',
            'zone_id'
        ];
        foreach($no_required_fields as $field){
            if(!isset($data[$field])) $data[$field] = '';
        }

        //TODO: generate password
        $data['password'] = $this->generateRefCode(6);
        $data['activation_code'] = $this->generateRefCode(10);

		$this->load->model('account/customer_group');

		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET
		            store_id = '" . (int)$this->config->get('config_store_id') . "',
		            email = '" . $this->db->escape($data['email']) . "',
		            salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "',
		            password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "',
		            newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "',
		            customer_group_id = '" . (int)$customer_group_id . "',
		            ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "',
		            status = '1',
		            approved = '" . (int)!$customer_group_info['approval'] . "',
		            ref_code = '" . $data['ref_code'] . "',
		            activation_code = '" . $data['activation_code'] . "',
		            parent_id = '" . $data['parent_id'] . "',
		            date_added = NOW()");

		$customer_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " . DB_PREFIX . "address SET
		            customer_id = '" . (int)$customer_id . "'
		            country_id = '" . (int)$data['country_id'] . "',
		            zone_id = '" . (int)$data['zone_id'] . "'");

		$this->language->load('mail/customer');

		$subject = $this->language->get('registration_subject');

        $activation_url = $this->url->link('account/register/activate', 'code=' . $data['activation_code']);

        $html = $this->renderTemplate(DIR_MAIL . 'registration.html', [
            'text_hello' => $this->language->get('text_hello'),
            'text_activation' => sprintf($this->language->get('text_activation'), $activation_url, $activation_url),
            'text_password' => sprintf($this->language->get('text_password'), $data['password'])
        ]);
        file_put_contents(DIR_ROOT . "pagecache/cachefiles/mail.html", $html);
		$mail = new Mail();


        $mail->protocol = $this->config->get('config_mail_protocol');
        $mail->parameter = $this->config->get('config_mail_parameter');
        $mail->hostname = $this->config->get('config_smtp_host');
        $mail->username = $this->config->get('config_smtp_username');
        $mail->password = $this->config->get('config_smtp_password');
        $mail->port = $this->config->get('config_smtp_port');


		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
        $mail->setHtml(html_entity_decode($html), ENT_QUOTES, 'UTF-8');
		$mail->send();

	}

    public function generateRefCode($length){
        $characters = '0123456789abcdefghijkmnopqrstuvwxyz';
        $code = '';
        for ($i = 0; $i < $length; $i++) {
            $code .= $characters[rand(0, utf8_strlen($characters) - 1)];
        }
        if(!$this->getCustomerIdByRefCode($code)){
            return $code;
        } else {
            $this->generateRefCode($length);
        }
    }

    public function getCustomerIdByRefCode($code){
        if(utf8_strlen($code) < 2)
            return false;
        $query = $this->db->query("SELECT customer_id FROM customer WHERE ref_code = '" . $this->db->escape($code) . "'");
        if($query->num_rows)
            return $query->row['customer_id'];
        else
            return false;
    }


    public function editCustomer($data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET
		firstname = '" . $this->db->escape($data['firstname']) . "',
		lastname = '" . $this->db->escape($data['lastname']) . "',
		email = '" . $this->db->escape($data['email']) . "',
		telephone = '" . $this->db->escape($data['telephone']) . "'
		WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	}

	public function editPassword($email, $password) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}

	public function editNewsletter($newsletter) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = '" . (int)$newsletter . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	}

	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->row;
	}

	public function getCustomerByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getCustomerByToken($token) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND token != ''");

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = ''");

		return $query->row;
	}

	public function getCustomers($data = array()) {
		$sql = "SELECT *, CONCAT(c.firstname, ' ', c.lastname) AS name, cg.name AS customer_group FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id) ";

		$implode = array();

		if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
			$implode[] = "LCASE(CONCAT(c.firstname, ' ', c.lastname)) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		if (isset($data['filter_email']) && !is_null($data['filter_email'])) {
			$implode[] = "LCASE(c.email) = '" . $this->db->escape(utf8_strtolower($data['filter_email'])) . "'";
		}

		if (isset($data['filter_customer_group_id']) && !is_null($data['filter_customer_group_id'])) {
			$implode[] = "cg.customer_group_id = '" . $this->db->escape($data['filter_customer_group_id']) . "'";
		}	

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	

		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "c.approved = '" . (int)$data['filter_approved'] . "'";
		}	

		if (isset($data['filter_ip']) && !is_null($data['filter_ip'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer_ip WHERE ip = '" . $this->db->escape($data['filter_ip']) . "')";
		}	

		if (isset($data['filter_date_added']) && !is_null($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$sort_data = array(
			'name',
			'c.email',
			'customer_group',
			'c.status',
			'c.ip',
			'c.date_added'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}		

		$query = $this->db->query($sql);

		return $query->rows;	
	}

	public function getIps($customer_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ip` WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->rows;
	}	

	public function isBanIp($ip) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ban_ip` WHERE ip = '" . $this->db->escape($ip) . "'");

		return $query->num_rows;
	}

    public function activateByCode($code){
        $query = $this->db->query("SELECT * FROM customer WHERE activation_code = '" . $this->db->escape($code) . "'");
        if($query->num_rows && $query->row['customer_id']){
            $this->db->query("UPDATE customer SET approved = '1' WHERE customer_id = '" . $query->row['customer_id'] . "'");
            return true;
        }
        return false;
    }
}
?>

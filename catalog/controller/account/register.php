<?php 
class ControllerAccountRegister extends Controller {
	private $error = array();

    public function ajax2register(){
        $this->language->load('account/register');

        if ($this->customer->isLogged()) {

            //TODO: delete on production
            $this->customer->logout(); // dev

            // TODO: uncomment on production
/*            die(json_encode([
                'error' => true,
                'messages' => [$this->language->get('text_already_logged')]
            ]));*/
        }

        if($this->validate()){
            $this->load->model('account/customer');

            $data = $this->request->post;
            $data['parent_id'] = 0;

            $data['ref_code'] = $this->model_account_customer->generateRefCode(5);

            if(isset($this->session->data['ref_code'])){
                if($pid = $this->model_account_customer->getCustomerIdByRefCode($this->session->data['ref_code'])){
                    $data['parent_id'] = $pid;
                }
            }

            $this->model_account_customer->addCustomer($data);

            $this->customer->login($this->request->post['email'], '', true);

            unset($this->session->data['guest']);

            die(json_encode([
                'error' => false,
                'messages' => [$this->language->get('text_success')]
            ]));
        }

        die(json_encode([
            'error' => true,
            'messages' => $this->error
        ]));

    }

	protected function validate() {

        if (!isset($this->request->post['email']) || (utf8_strlen(trim($this->request->post['email'])) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', trim($this->request->post['email']))) {
            $this->error['email'] = $this->language->get('error_email');
        }

        $this->load->model('account/customer');
        $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

        if (!isset($this->request->get['customer_id'])) {
            if ($customer_info) {
                $this->error['email'] = $this->language->get('error_exists');
            }
        } else {
            if ($customer_info && ($this->request->get['customer_id'] != $customer_info['customer_id'])) {
                $this->error['email'] = $this->language->get('error_exists');
            }
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }

	}

	public function country() {
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}

		$this->response->setOutput(json_encode($json));
	}	
}
?>
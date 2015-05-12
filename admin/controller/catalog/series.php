<?php 
/*
 * Product to series
 * */
class ControllerCatalogSeries extends Controller {
	private $error = array();
	private $messages = array();

	/**/
	public function index() {
		$this->load->model('catalog/series');
		$this->getList();
	}

	public function insert() {
		$this->load->model('catalog/series');
		if(isset($this->request->post['name']) && $this->request->post['name']) {
			$series_id = $this->model_catalog_series->addSeries($this->request->post['name']);
			if($series_id) {
				$this->messages[] = 'Серия успешно создана!';
				exit(
					json_encode(array(
						'error' => $this->error,
						'message' => $this->messages,
						'series_id' => $series_id,
					))
				);
			} else {
				$this->error[] = 'Серия с таким именем уже существует!';
			}
		} else {
			$this->error[] = 'Заполните имя серии.';
		}
		exit(
			json_encode(array(
				'error' => $this->error,
				'message' => $this->messages,
			))
		);
	}

	public function update() {
		$this->load->model('catalog/series');
		$this->getForm();
	}

	public function delete() {
		$this->load->model('catalog/series');
		if(isset($this->request->get['series_id'])) {
			$this->model_catalog_series->deleteSeries($this->request->get['series_id']);
			$this->messages[] = 'Серия успешно удалена, все продукты откреплены!';
		} else {
			$this->error[] = 'Не удалось удалить серию!';
		}
		exit(
			json_encode(array(
				'error' => $this->error,
				'message' => $this->messages,
			))
		);
	}
	
	public function unlink() {
		if(isset($this->request->get['product_id']) && isset($this->request->get['series_id'])) {
			$this->load->model('catalog/series');
			$this->model_catalog_series->deleteProductFromSeries($this->request->get['product_id'], $this->request->get['series_id']);
			$this->messages[] = 'Продукт успешно откреплен!';
		} else {
			$this->error[] = 'Не удалось открепить продукт!';
		}
		exit(
			json_encode(array(
				'error' => $this->error,
				'message' => $this->messages,
			))
		);
	}
	
	public function link() {
		if(isset($this->request->post['product_id']) && isset($this->request->post['series_id'])) {
			$this->load->model('catalog/series');
			$link_id = $this->model_catalog_series->addProductToSeriesById($this->request->post['product_id'], $this->request->post['series_id']);
			if($link_id) {
				$this->messages[] = 'Продукт успешно привязан!';
			} else {
				$this->error[] = 'Данный продукт уже есть в этой серии!';
			}
		} else {
			$this->error[] = 'Выберите продукт.';
		}
		exit(
			json_encode(array(
				'error' => $this->error,
				'message' => $this->messages,
			))
		);
	}

	public function autocomplete() {
		if(isset($this->request->get['series_name']) && $this->request->get['series_name']) {
			$this->load->model('catalog/series');
			$series = $this->model_catalog_series->getSeriesByName($this->request->get['series_name']);
			exit(json_encode($series));
		}
	}
	
	protected function getList() {
		$this->data['add_series_href'] = $this->url->link('catalog/series/insert', 'token=' . $this->session->data['token']);
		
		$series = $this->model_catalog_series->getSeries();
		foreach ($series as $single) {
			$this->data['series'][] = array(
				'name' => $single['name'],
				'href' => $this->url->link(
					'catalog/series/update', 
					'series_id=' . $single['series_id'] . '&token=' . $this->session->data['token']
				),
				'series_id' => $single['series_id'],
				'delete' => $this->url->link(
					'catalog/series/delete', 
					'series_id=' . $single['series_id'] . '&token=' . $this->session->data['token']
				),
			);
		}
		
		$this->template = 'catalog/series_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function getForm() {
		if(isset($this->request->get['series_id']) && (int)$this->request->get['series_id']) {
			$series = $this->model_catalog_series->getSeries($this->request->get['series_id']);
			$this->data['series_name'] = $series['name'];
			$this->data['add_product_href'] = $this->url->link('catalog/series/link', 'token=' . $this->session->data['token']);
			
			$products = $this->model_catalog_series->getSeriesProducts($this->request->get['series_id']);
			$this->load->model('tool/image');
			foreach ($products as $product) {
				if(!empty($product['product_id'])) {
					$this->data['products'][] = array(
						'name' => $product['name'],
						'model' => $product['model'],
						'product_id' => $product['product_id'],
						'image' => $this->model_tool_image->resize(($product['image'] ? $product['image'] : 'no_image.jpg'), 40, 40),
						'href' => $this->url->link(
							'catalog/product/update',
							'product_id=' . $product['product_id'] . '&token=' . $this->session->data['token']
						),
						'delete' => $this->url->link(
							'catalog/series/unlink',
							'series_id=' . (int)$this->request->get['series_id']  
								. '&product_id=' . $product['product_id'] 
								. '&token=' . $this->session->data['token']
						),
					);
				} 
			}
		} else {
			$this->response->redirect($this->url->link('catalog/series', 'token=' . $this->session->data['token']));
		}
		$this->template = 'catalog/series_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}
}
?>
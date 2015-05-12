<?php 
class ControllerInformationInformation extends Controller {
	public function index() {  
		$this->language->load('information/information');

		$this->load->model('catalog/information');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
			'separator' => false
			);  

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			($information_info['custom_title'] == '')?$this->document->setTitle($information_info['title']):$this->document->setTitle($information_info['custom_title']);
			$this->document->addLink($this->url->link('information/information', 'information_id=' .  $information_id), 'canonical');
			$this->document->setKeywords($information_info['meta_keyword']);
			$this->document->setDescription($information_info['meta_description']);
			$this->data['breadcrumbs'][] = array(
				'text'      => $information_info['title'],
				'href'      => $this->url->link('information/information', 'information_id=' .  $information_id),      		
				'separator' => $this->language->get('text_separator')
				);

			$this->data['heading_title'] = $information_info['title'];

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');

			$autolinks = $this->config->get('autolinks');
			
			if (isset($autolinks) && (strpos($this->data['description'], 'iframe') == false) && (strpos($this->data['description'], 'object') == false)){
				$xdescription = mb_convert_encoding(html_entity_decode($this->data['description'], ENT_COMPAT, "UTF-8"), 'HTML-ENTITIES', "UTF-8");
				
				libxml_use_internal_errors(true);
				$dom = new DOMDocument;
				$dom->loadHTML('<div>'.$xdescription.'</div>');
				libxml_use_internal_errors(false);
				
				
				$xpath = new DOMXPath($dom);
				
				foreach ($autolinks as $autolink)
				{
					$keyword = $autolink['keyword'];
					$xlink = mb_convert_encoding(html_entity_decode($autolink['link'], ENT_COMPAT, "UTF-8"), 'HTML-ENTITIES', "UTF-8");
					$target = $autolink['target'];
					$tooltip = isset($autolink['tooltip']);
					
					$pTexts = $xpath->query(
						sprintf('///text()[contains(., "%s")]', $keyword)
						);
					
					foreach ($pTexts as $pText) {
						$this->parseText($pText, $keyword, $dom, $xlink, $target, $tooltip);
					}
					
					
				}
				
				$this->data['description'] = $dom->saveXML($dom->documentElement);
			}
			
			$this->data['continue'] = $this->url->link('common/home');
			
			/* layout patch - choose template by path */
			$this->load->model ( 'design/layout' );
			if (isset ( $this->request->get ['route'] )) {
				$route = ( string ) $this->request->get ['route'];
			} else {
				$route = 'common/home';
			}
			$layout_template = $this->model_design_layout->getLayoutTemplate($route);
			$isLayoutRoute = true;
			if(!$layout_template){
				$layout_template = 'information';
				$isLayoutRoute = false;
			}
			// get general layout template
			if(!$isLayoutRoute){
				$layout_id = $this->model_catalog_information->getInformationLayoutId($information_id);
				if($layout_id){
					$tmp_layout_template = $this->model_design_layout->getGeneralLayoutTemplate($layout_id);
					if($tmp_layout_template)
						$layout_template = $tmp_layout_template;
				}
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
		} else {
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('information/information', 'information_id=' . $information_id),
				'separator' => $this->language->get('text_separator')
				);

			$this->document->setTitle($this->language->get('text_error'));

			$this->data['heading_title'] = $this->language->get('text_error');

			$this->data['text_error'] = $this->language->get('text_error');

			$this->data['button_continue'] = $this->language->get('button_continue');

			$this->data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');
			
			

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

	private function parseText($node, $keyword, $dom, $link, $target='', $tooltip = 0)
	{
		if (mb_strpos($node->nodeValue, $keyword) !== false)
		{
			$keywordOffset = mb_strpos($node->nodeValue, $keyword, 0, 'UTF-8');
			$newNode = $node->splitText($keywordOffset);
			$newNode->deleteData(0, mb_strlen($keyword, 'UTF-8'));
			$span = $dom->createElement('a', $keyword);
			if ($tooltip)
			{
				$span->setAttribute('href', '#');
				$span->setAttribute('style', 'text-decoration:none');
				$span->setAttribute('class', 'title');
				$span->setAttribute('title', $keyword.'|'.$link);
			}
			else
			{
				$span->setAttribute('href', $link);
				$span->setAttribute('target', $target);
				$span->setAttribute('style', 'text-decoration:none');
			}
			
			$node->parentNode->insertBefore($span, $newNode);
			$this->parseText($newNode ,$keyword, $dom, $link, $target, $tooltip);
		}
	}
	
	public function info() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}      

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output  = '<html dir="ltr" lang="en">' . "\n";
			$output .= '<head>' . "\n";
			$output .= '  <title>' . $information_info['title'] . '</title>' . "\n";
			$output .= '  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
			$output .= '  <meta name="robots" content="noindex">' . "\n";
			$output .= '</head>' . "\n";
			$output .= '<body>' . "\n";
			$output .= '  <h1>' . $information_info['title'] . '</h1>' . "\n";
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
			$output .= '  </body>' . "\n";
			$output .= '</html>' . "\n";			

			$this->response->setOutput($output);
		}
	}
}
?>
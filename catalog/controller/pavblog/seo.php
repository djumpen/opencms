<?php 


/**
 * class ControllerPavblogSeo inherit core functions of SEO URL class (in common/seo_url.php)
 * Then improving detections to process SEO for pavo blog modules. 
 * To use this you should disable Opencart SEO by comment $controller->addPreAction(new Action('common/seo_url')); in index.php file
 * And Then add This in next line: $controller->addPreAction(new Action('pavblog/seo'));
 */
	class ControllerPavblogSeo extends Controller {
		
		/**
		 * Add Hanlder to detect url getting parameters to build real url of category and blog page. 
		 * 
		 */
		 public function index() {
			// Add rewrite to url class
			if ($this->config->get('config_seo_url')) {
				$this->url->addRewrite($this);
			}

			// Decode URL
			if (isset($this->request->get['_route_'])) {
				$parts = explode('/', $this->request->get['_route_']);
				
				/** BEGIN PROCESSING TO DECORD REQUET SEO URL FOR  PAVO BLOG MODULE **/
				$blogConfig = $this->config->get('pavblog');
			 	$seo = isset($blogConfig['keyword_listing_blogs_page'])?trim($blogConfig['keyword_listing_blogs_page']):"blogs"; 

				if( $this->request->get['_route_'] ==  $seo ){
					$this->request->get['route'] =  'pavblog/blogs';
					return $this->forward($this->request->get['route']);
				} 
				/** END OF PROCESSING TO DECORD REQUET SEO URL FOR  PAVO BLOG MODULE **/

				foreach ($parts as $part) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
					
					if ($query->num_rows) {
						$url = explode('=', $query->row['query']);
						
						if ($url[0] == 'product_id') {
							$this->request->get['product_id'] = $url[1];
						}
						
						if ($url[0] == 'category_id') {
							if (!isset($this->request->get['path'])) {
								$this->request->get['path'] = $url[1];
							} else {
								$this->request->get['path'] .= '_' . $url[1];
							}
						}	
						
						if ($url[0] == 'manufacturer_id') {
							$this->request->get['manufacturer_id'] = $url[1];
						}
						
						if ($url[0] == 'information_id') {
							$this->request->get['information_id'] = $url[1];
						}

					 	/** BEGIN PROCESSING TO DECORD REQUET SEO URL FOR  PAVO BLOG MODULE **/
						if( count($url) == 2 && ( preg_match( "#pavblog#", $url[0] ))  ){
						 	$this->request->get['route'] =  $url[0];
						 	$this->request->get['id'] = $url[1];
						}
						/** END OF PROCESSING TO DECORD REQUET SEO URL FOR  PAVO BLOG MODULE **/
					} else {
						$this->request->get['route'] = 'error/not_found';	
					}
				}
				
				if (isset($this->request->get['product_id'])) {
					$this->request->get['route'] = 'product/product';
				} elseif (isset($this->request->get['path'])) {
					$this->request->get['route'] = 'product/category';
				} elseif (isset($this->request->get['manufacturer_id'])) {
					$this->request->get['route'] = 'product/manufacturer/info';
				} elseif (isset($this->request->get['information_id'])) {
					$this->request->get['route'] = 'information/information';
				}
				
				if (isset($this->request->get['route'])) {
					return $this->forward($this->request->get['route']);
				}
			}
		}
		
		public function rewrite($link) {
			$url_info = parse_url(str_replace('&amp;', '&', $link));
			$url = ''; 
			$data = array();
			
			parse_str($url_info['query'], $data);
	 
			foreach ($data as $key => $value) {
				if (isset($data['route'])) {
					if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
					
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
							
							unset($data[$key]);
						}					
					} elseif ($key == 'path') {
						$categories = explode('_', $value);
						
						foreach ($categories as $category) {
							$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
					
							if ($query->num_rows) {
								$url .= '/' . $query->row['keyword'];
							}							
						}
						
						unset($data[$key]);
					}
					
				}
			}

			/** BEGIN PROCESSING TO REWRITE SEO URL FOR  PAVO BLOG MODULE **/
			if ( ( preg_match( "#pavblog#", $data['route'] ))  && isset($data['id']) ) { 
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape( $data['route'] . '=' .$data['id']) . "'");
				if ($query->num_rows) {
					$url .= '/' . $query->row['keyword'];
					unset($data[$key]);
					unset($data['id']);
				}					
			}  else if( $data['route'] == 'pavblog/blogs' ){ 
				$blogConfig = $this->config->get('pavblog');
				$seo = isset($blogConfig['keyword_listing_blogs_page'])?trim($blogConfig['keyword_listing_blogs_page']):"blogs"; 
				$url .= '/'.$seo;
			}
			/** END OF PROCESSING SEO URL FOR PAVO BLOG MODULE **/
			if ($url) {
				unset($data['route']);
			
				$query = '';
			
				if ($data) {
					foreach ($data as $key => $value) {
						$query .= '&' . $key . '=' . $value;
					}
					
					if ($query) {
						$query = '?' . trim($query, '&');
					}
				}

				return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
			} else {
				return $link;
			}
		}	
	}

?>
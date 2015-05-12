<?php
class ModelCatalogInformation extends Model {
	public function addInformation($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "information SET sort_order = '" . (int)$data['sort_order'] . "', bottom = '" . (isset($data['bottom']) ? (int)$data['bottom'] : 0) . "', status = '" . (int)$data['status'] . "'");

		$information_id = $this->db->getLastId(); 

		foreach ($data['information_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "information_description SET information_id = '" . (int)$information_id . "', language_id = '" . (int)$language_id . "', custom_title = '" . ((isset($value['custom_title']))?($this->db->escape($value['custom_title'])):'') . "', title = '" . $this->db->escape($value['title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "',  description = '" . $this->db->escape($value['description']) . "'");
		}

		if (isset($data['information_store'])) {
			foreach ($data['information_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "information_to_store SET information_id = '" . (int)$information_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['information_layout'])) {
			foreach ($data['information_layout'] as $store_id => $layout) {
				if ($layout) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "information_to_layout SET information_id = '" . (int)$information_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'information_id=" . (int)$information_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);}
			}
		}

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seopack'");
			
		foreach ($query->rows as $result) {
		    if (!$result['serialized']) {
		        $data[$result['key']] = $result['value'];
		    } else {
		        $data[$result['key']] = unserialize($result['value']);
		    }
		}
			
		if (isset($data)) {$parameters = $data['parameters'];}
		
		if (isset($parameters['ext'])) { $ext = $parameters['ext'];}
		else {$ext = '';}
		
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT id.information_id, id.title, id.language_id, l.code FROM ".DB_PREFIX."information i
							inner join ".DB_PREFIX."information_description id on i.information_id = id.information_id
							inner join ".DB_PREFIX."language l on l.language_id = id.language_id
							where i.information_id = '" . (int)$information_id . "';");
		
		    foreach ($query->rows as $info_row){
		        	
		        if( strlen($info_row['title']) > 1 ){
		
		            $slug = $seo->generateSlug($info_row['title']).$ext;
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'information_id=" . $info_row['information_id'] . "'  and language_id=".$info_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'information_id=" . $info_row['information_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($info_row['title']).'-'.rand();
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($info_row['title']).'-'.$info_row['code'];
		                    }
		                }
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword, language_id) VALUES ('information_id=" . $info_row['information_id'] . "', '" . $slug . "', " . $info_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		
		$this->cache->delete('information');
	}

	public function editInformation($information_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "information SET sort_order = '" . (int)$data['sort_order'] . "', bottom = '" . (isset($data['bottom']) ? (int)$data['bottom'] : 0) . "', status = '" . (int)$data['status'] . "' WHERE information_id = '" . (int)$information_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "information_description WHERE information_id = '" . (int)$information_id . "'");

		foreach ($data['information_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "information_description SET information_id = '" . (int)$information_id . "', language_id = '" . (int)$language_id . "', custom_title = '" . ((isset($value['custom_title']))?($this->db->escape($value['custom_title'])):'') . "', title = '" . $this->db->escape($value['title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "',  description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_store WHERE information_id = '" . (int)$information_id . "'");

		if (isset($data['information_store'])) {
			foreach ($data['information_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "information_to_store SET information_id = '" . (int)$information_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "'");

		if (isset($data['information_layout'])) {
			foreach ($data['information_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "information_to_layout SET information_id = '" . (int)$information_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'information_id=" . (int)$information_id. "'");

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'information_id=" . (int)$information_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);}
			}
		}

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seopack'");
			
		foreach ($query->rows as $result) {
		    if (!$result['serialized']) {
		        $data[$result['key']] = $result['value'];
		    } else {
		        $data[$result['key']] = unserialize($result['value']);
		    }
		}
			
		if (isset($data)) {$parameters = $data['parameters'];}
		
		if (isset($parameters['ext'])) { $ext = $parameters['ext'];}
		else {$ext = '';}
		
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT id.information_id, id.title, id.language_id, l.code FROM ".DB_PREFIX."information i
							inner join ".DB_PREFIX."information_description id on i.information_id = id.information_id
							inner join ".DB_PREFIX."language l on l.language_id = id.language_id
							where i.information_id = '" . (int)$information_id . "';");
		
		    foreach ($query->rows as $info_row){
		        	
		        if( strlen($info_row['title']) > 1 ){
		
		            $slug = $seo->generateSlug($info_row['title']).$ext;
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'information_id=" . $info_row['information_id'] . "'  and language_id=".$info_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'information_id=" . $info_row['information_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($info_row['title']).'-'.rand();
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($info_row['title']).'-'.$info_row['code'];
		                    }
		                }
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword, language_id) VALUES ('information_id=" . $info_row['information_id'] . "', '" . $slug . "', " . $info_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		
		$this->cache->delete('information');
	}

	public function deleteInformation($information_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "information WHERE information_id = '" . (int)$information_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "information_description WHERE information_id = '" . (int)$information_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_store WHERE information_id = '" . (int)$information_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'information_id=" . (int)$information_id . "'");

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seopack'");
			
		foreach ($query->rows as $result) {
		    if (!$result['serialized']) {
		        $data[$result['key']] = $result['value'];
		    } else {
		        $data[$result['key']] = unserialize($result['value']);
		    }
		}
			
		if (isset($data)) {$parameters = $data['parameters'];}
		
		if (isset($parameters['ext'])) { $ext = $parameters['ext'];}
		else {$ext = '';}
		
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT id.information_id, id.title, id.language_id, l.code FROM ".DB_PREFIX."information i
							inner join ".DB_PREFIX."information_description id on i.information_id = id.information_id
							inner join ".DB_PREFIX."language l on l.language_id = id.language_id
							where i.information_id = '" . (int)$information_id . "';");
		
		    foreach ($query->rows as $info_row){
		        	
		        if( strlen($info_row['title']) > 1 ){
		
		            $slug = $seo->generateSlug($info_row['title']).$ext;
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'information_id=" . $info_row['information_id'] . "'  and language_id=".$info_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'information_id=" . $info_row['information_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($info_row['title']).'-'.rand();
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($info_row['title']).'-'.$info_row['code'];
		                    }
		                }
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword, language_id) VALUES ('information_id=" . $info_row['information_id'] . "', '" . $slug . "', " . $info_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		$this->cache->delete('information');
	}	

	public function getKeyWords($information_id) {
	    $keywords = array();
	
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'information_id=" . (int)$information_id . "'");
	
	    foreach ($query->rows as $result) {
	        $keywords[$result['language_id']] = $result['keyword'];
	    }
	
	    return $keywords;
	}
	
	public function getInformation($information_id) {
		$sql = "
			SELECT DISTINCT * 
			FROM 
				" . DB_PREFIX . "information i 
			Left Join 
				" . DB_PREFIX . "information_description id
				On (i.information_id = id.information_id)
			WHERE 
				i.information_id = '" . (int)$information_id . "'
			And 
				id.language_id = " . (int)$this->config->get('config_language_id') . "
		";
		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getInformations($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

			$sort_data = array(
				'id.title',
				'i.sort_order'
			);		

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY id.title";	
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
		} else {
			$information_data = $this->cache->get('information.' . (int)$this->config->get('config_language_id'));

			if (!$information_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

				$information_data = $query->rows;

				$this->cache->set('information.' . (int)$this->config->get('config_language_id'), $information_data);
			}	

			return $information_data;			
		}
	}

	public function getInformationDescriptions($information_id) {
		$information_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_description WHERE information_id = '" . (int)$information_id . "'");

		foreach ($query->rows as $result) {
			$information_description_data[$result['language_id']] = array(
				'custom_title'     => $result['custom_title'],
                'title'            => $result['title'],
                'meta_description' => $result['meta_description'], 
                'meta_keyword'     => $result['meta_keyword'], 
				'description'      => $result['description']
			);
		}

		return $information_description_data;
	}

	public function getInformationStores($information_id) {
		$information_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_store WHERE information_id = '" . (int)$information_id . "'");

		foreach ($query->rows as $result) {
			$information_store_data[] = $result['store_id'];
		}

		return $information_store_data;
	}

	public function getInformationLayouts($information_id) {
		$information_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "'");

		foreach ($query->rows as $result) {
			$information_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $information_layout_data;
	}

	public function getTotalInformations() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "information");

		return $query->row['total'];
	}	

	public function getTotalInformationsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "information_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}	
}
?>
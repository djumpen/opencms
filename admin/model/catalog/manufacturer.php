<?php
class ModelCatalogManufacturer extends Model {
	public function addManufacturer($data) {
		$this->db->query("
			INSERT INTO " . DB_PREFIX . "manufacturer 
			SET 
				name = '" . $this->db->escape($data['name']) . "', sort_order = '" . (int)$data['sort_order'] . "'");

		$manufacturer_id = $this->db->getLastId();
		foreach ($data['manufacturer_description'] as $language_id => $value) {
		    $this->db->query("
	    		INSERT INTO " . DB_PREFIX . "manufacturer_description 
	    		SET 
		    		manufacturer_id = '" . (int)$manufacturer_id . "', 
	    			language_id = '" . (int)$language_id . "', 
		    		custom_title = '" . (isset($value['custom_title'])?$this->db->escape($value['custom_title']):'') . "', 
		    		meta_keyword = '" . (isset($value['meta_keyword'])?$this->db->escape($value['meta_keyword']):'') . "', 
		    		meta_description = '" . (isset($value['meta_description'])?$this->db->escape($value['meta_description']):'') . "', 
		    		description = '" . $this->db->escape($value['description']) . "'
    		");
		}
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "manufacturer SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
		}

		if (isset($data['manufacturer_store'])) {
			foreach ($data['manufacturer_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer_to_store SET manufacturer_id = '" . (int)$manufacturer_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'manufacturer_id=" . (int)$manufacturer_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);}
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
		
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT l.language_id, m.name, m.manufacturer_id, l.code from ".DB_PREFIX."manufacturer m
						join ".DB_PREFIX."language l
						where m.manufacturer_id = '" . (int)$manufacturer_id . "';");
		
		
		    foreach ($query->rows as $manufacturer_row){
		
		        	
		        if( strlen($manufacturer_row['name']) > 1 ){
		
		            $slug = $seo->generateSlug($manufacturer_row['name'].'-'.$manufacturer_row['code']);
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'manufacturer_id=" . $manufacturer_row['manufacturer_id'] . "' and language_id=".$manufacturer_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){ $slug = $seo->generateSlug($manufacturer_row['name']).'-'.rand();}
		
		
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword,language_id) VALUES ('manufacturer_id=" . $manufacturer_row['manufacturer_id'] . "', '" . $slug . "', " . $manufacturer_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		
		$this->cache->delete('manufacturer');
	}

	public function editManufacturer($manufacturer_id, $data) {
	    $this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer_description WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
	    	
	    foreach ($data['manufacturer_description'] as $language_id => $value) {
	        $this->db->query("
        		INSERT INTO " . DB_PREFIX . "manufacturer_description 
        		SET 
	        		manufacturer_id = '" . (int)$manufacturer_id . "', 
	        		language_id = '" . (int)$language_id . "', 
	        		custom_title = '" . (isset($value['custom_title'])?$this->db->escape($value['custom_title']):'') . "', 
	        		meta_keyword = '" . (isset($value['meta_keyword'])?$this->db->escape($value['meta_keyword']):'') . "', 
	        		meta_description = '" . (isset($value['meta_description'])?$this->db->escape($value['meta_description']):'') . "', 
	        		description = '" . $this->db->escape($value['description']) . "'
        	");
	    }
		$this->db->query("UPDATE " . DB_PREFIX . "manufacturer SET name = '" . $this->db->escape($data['name']) . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "manufacturer SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer_to_store WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		if (isset($data['manufacturer_store'])) {
			foreach ($data['manufacturer_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer_to_store SET manufacturer_id = '" . (int)$manufacturer_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'manufacturer_id=" . (int)$manufacturer_id. "'");

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'manufacturer_id=" . (int)$manufacturer_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);}
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
		
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT l.language_id, m.name, m.manufacturer_id, l.code from ".DB_PREFIX."manufacturer m
						join ".DB_PREFIX."language l
						where m.manufacturer_id = '" . (int)$manufacturer_id . "';");
		
		
		    foreach ($query->rows as $manufacturer_row){
		
		        	
		        if( strlen($manufacturer_row['name']) > 1 ){
		
		            $slug = $seo->generateSlug($manufacturer_row['name'].'-'.$manufacturer_row['code']);
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'manufacturer_id=" . $manufacturer_row['manufacturer_id'] . "' and language_id=".$manufacturer_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){ $slug = $seo->generateSlug($manufacturer_row['name']).'-'.rand();}
		
		
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword,language_id) VALUES ('manufacturer_id=" . $manufacturer_row['manufacturer_id'] . "', '" . $slug . "', " . $manufacturer_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		
		$this->cache->delete('manufacturer');
	}

	public function deleteManufacturer($manufacturer_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer_to_store WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'manufacturer_id=" . (int)$manufacturer_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer_description WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seopack'");
			
		foreach ($query->rows as $result) {
		    if (!$result['serialized']) {
		        $data[$result['key']] = $result['value'];
		    } else {
		        $data[$result['key']] = unserialize($result['value']);
		    }
		}
			
		if (isset($data)) {$parameters = $data['parameters'];}
		
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT l.language_id, m.name, m.manufacturer_id, l.code from ".DB_PREFIX."manufacturer m
						join ".DB_PREFIX."language l
						where m.manufacturer_id = '" . (int)$manufacturer_id . "';");
		
		
		    foreach ($query->rows as $manufacturer_row){
		
		        	
		        if( strlen($manufacturer_row['name']) > 1 ){
		
		            $slug = $seo->generateSlug($manufacturer_row['name'].'-'.$manufacturer_row['code']);
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'manufacturer_id=" . $manufacturer_row['manufacturer_id'] . "' and language_id=".$manufacturer_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){ $slug = $seo->generateSlug($manufacturer_row['name']).'-'.rand();}
		
		
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword,language_id) VALUES ('manufacturer_id=" . $manufacturer_row['manufacturer_id'] . "', '" . $slug . "', " . $manufacturer_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		
		$this->cache->delete('manufacturer');
	}	

	public function getManufacturerDescriptions($manufacturer_id) {
	    $manufacturer_description_data = array();
	
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer_description WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");
	
	    foreach ($query->rows as $result) {
	        $manufacturer_description_data[$result['language_id']] = array(
	                        'meta_keyword'     => $result['meta_keyword'],
	                        'meta_description' => $result['meta_description'],
	                        'description'      => $result['description'],
	                        'custom_title'     => $result['custom_title']
	        );
	    }
	
	    return $manufacturer_description_data;
	}
	
	public function getKeyWords($manufacturer_id) {
	    $keywords = array();
	
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'manufacturer_id=" . (int)$manufacturer_id . "'");
	
	    foreach ($query->rows as $result) {
	        $keywords[$result['language_id']] = $result['keyword'];
	    }
	
	    return $keywords;
	}
	
	public function getManufacturer($manufacturer_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "manufacturer WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		return $query->row;
	}

	public function getManufacturers($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "manufacturer";

		if (!empty($data['filter_name'])) {
			$sql .= " WHERE name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sort_data = array(
			'name',
			'sort_order'
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

	public function getManufacturerStores($manufacturer_id) {
		$manufacturer_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer_to_store WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		foreach ($query->rows as $result) {
			$manufacturer_store_data[] = $result['store_id'];
		}

		return $manufacturer_store_data;
	}

	public function getTotalManufacturersByImageId($image_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "manufacturer WHERE image_id = '" . (int)$image_id . "'");

		return $query->row['total'];
	}

	public function getTotalManufacturers() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "manufacturer");

		return $query->row['total'];
	}	
}
?>
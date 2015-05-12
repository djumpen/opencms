<?php
class ModelCatalogPOGalleryAlbum extends Model {
	public function getAlbum($album_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'album_id=" . (int)$album_id . "') AS keyword FROM po_gallery_album WHERE album_id = '" . (int)$album_id . "'");
		
		return $query->row;
	} 
	
	/*
	public function getAlbums($parent_id = 0) {
	
		$po_gallery_album_data = array();
		
		$sql = "SELECT * FROM po_gallery_album c LEFT JOIN po_gallery_album_description cd ON (c.album_id = cd.album_id) WHERE  cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
		//$query = $this->db->query("SELECT * FROM po_gallery_album c LEFT JOIN po_gallery_album_description cd ON (c.album_id = cd.album_id) WHERE  cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
		if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(c.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		$query = $this->db->query($sql);
		
		foreach ($query->rows as $result) {
			$po_gallery_album_data[] = array(
				'album_id' => $result['album_id'],
				'name'        => $result['name'],
				'status'  	  => $result['status'],
				'sort_order'  => $result['sort_order']
			);
			
			//$po_gallery_album_data = array_merge($po_gallery_album_data, $this->getAlbums($result['album_id']));
		}	
	
		
		return $po_gallery_album_data;
	}
	*/
	
	public function getAlbums($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM po_gallery_album p LEFT JOIN po_gallery_album_description pd ON (p.album_id = pd.album_id)";
			
			$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}
			
			$sql .= " GROUP BY p.album_id";
						
			$sort_data = array(
				'pd.name',
				'p.sort_order'
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY pd.name";	
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
			//$product_data = $this->cache->get('product.' . (int)$this->config->get('config_language_id'));
		
			//if (!$product_data) {
				$query = $this->db->query("SELECT * FROM po_gallery_album c LEFT JOIN po_gallery_album_description cd ON (c.album_id = cd.album_id) WHERE  cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
	
				$product_data = $query->rows;
			
				//$this->cache->set('product.' . (int)$this->config->get('config_language_id'), $product_data);
			//}	
	
			return $product_data;
		}
	}
	
	
	
	public function addAlbum($data) {
		$this->db->query("INSERT INTO po_gallery_album SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW(), date_added = NOW()");
	
		$album_id = $this->db->getLastId();
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE po_gallery_album SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE album_id = '" . (int)$album_id . "'");
		}
		
		foreach ($data['album_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO po_gallery_album_description SET album_id = '" . (int)$album_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		if (isset($data['album_store'])) {
			foreach ($data['album_store'] as $store_id) {
				$this->db->query("INSERT INTO po_gallery_album_to_store SET album_id = '" . (int)$album_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
						
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'album_id=" . (int)$album_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('photo_album');
	}
	
	public function editAlbum($album_id, $data) {
		$this->db->query("UPDATE po_gallery_album SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "', date_modified = NOW() WHERE album_id = '" . (int)$album_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE po_gallery_album SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE album_id = '" . (int)$album_id . "'");
		}

		$this->db->query("DELETE FROM po_gallery_album_description WHERE album_id = '" . (int)$album_id . "'");

		foreach ($data['album_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO po_gallery_album_description SET album_id = '" . (int)$album_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}
		
		$this->db->query("DELETE FROM po_gallery_album_to_store WHERE album_id = '" . (int)$album_id . "'");
		
		if (isset($data['album_store'])) {		
			foreach ($data['album_store'] as $store_id) {
				$this->db->query("INSERT INTO po_gallery_album_to_store SET album_id = '" . (int)$album_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'album_id=" . (int)$album_id. "'");
		
		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'album_id=" . (int)$album_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}
		
		$this->cache->delete('photo_album');
	}
	
	public function deleteAlbum($album_id) {
		$this->db->query("DELETE FROM po_gallery_album WHERE album_id = '" . (int)$album_id . "'");
		$this->db->query("DELETE FROM po_gallery_album_description WHERE album_id = '" . (int)$album_id . "'");
		$this->db->query("DELETE FROM po_gallery_album_to_store WHERE album_id = '" . (int)$album_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'album_id=" . (int)$album_id . "'");
		
		$query = $this->db->query("SELECT album_id FROM po_gallery_album WHERE parent_id = '" . (int)$album_id . "'");

		foreach ($query->rows as $result) {
			$this->deleteAlbum($result['album_id']);
		}
		
		$this->cache->delete('photo_album');
	} 

	
	
	public function getPath($album_id) {
		$query = $this->db->query("SELECT name, parent_id FROM po_gallery_album c LEFT JOIN po_gallery_album_description cd ON (c.album_id = cd.album_id) WHERE c.album_id = '" . (int)$album_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
		
		if ($query->row['parent_id']) {
			return $this->getPath($query->row['parent_id'], $this->config->get('config_language_id')) . $this->language->get('text_separator') . $query->row['name'];
		} else {
			return $query->row['name'];
		}
	}
	
	public function getAlbumDescriptions($album_id) {
		$photo_album_description_data = array();
		
		$query = $this->db->query("SELECT * FROM po_gallery_album_description WHERE album_id = '" . (int)$album_id . "'");
		
		foreach ($query->rows as $result) {
			$photo_album_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
				'meta_keyword'     => $result['meta_keyword'],
				'meta_description' => $result['meta_description'],
				'description'      => $result['description']
			);
		}
		
		return $photo_album_description_data;
	}	
	
	public function getAlbumStores($album_id) {
		$photo_album_store_data = array();
		
		$query = $this->db->query("SELECT * FROM po_gallery_album_to_store WHERE album_id = '" . (int)$album_id . "'");

		foreach ($query->rows as $result) {
			$photo_album_store_data[] = $result['store_id'];
		}
		
		return $photo_album_store_data;
	}
		
	public function getTotalAlbum() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM po_gallery_album");
		
		return $query->row['total'];
	}	
	
}
?>
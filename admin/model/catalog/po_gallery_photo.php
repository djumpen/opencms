<?php
class ModelCatalogPOGalleryPhoto extends Model {
	public function addPhoto($data) {
		$this->db->query("INSERT INTO po_gallery_photo SET status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "', date_added = NOW()");
		
		$photo_id = $this->db->getLastId();
		
		if (isset($data['image'])) {
			$this->db->query("UPDATE po_gallery_photo SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE photo_id = '" . (int)$photo_id . "'");
		}
		
		foreach ($data['photo_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO po_gallery_photo_description SET photo_id = '" . (int)$photo_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
		
		if (isset($data['photo_store'])) {
			foreach ($data['photo_store'] as $store_id) {
				$this->db->query("INSERT INTO po_gallery_photo_to_store SET photo_id = '" . (int)$photo_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		if (isset($data['photo_album'])) {
			foreach ($data['photo_album'] as $album_id) {
				$this->db->query("INSERT INTO po_gallery_photo_to_album SET photo_id = '" . (int)$photo_id . "', album_id = '" . (int)$album_id . "'");
			}
		}
						
		$this->cache->delete('photo');
	}
	
	public function editPhoto($photo_id, $data) {
		$this->db->query("UPDATE po_gallery_photo SET status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "' WHERE photo_id = '" . (int)$photo_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE po_gallery_photo SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE photo_id = '" . (int)$photo_id . "'");
		}
		
		$this->db->query("DELETE FROM po_gallery_photo_description WHERE photo_id = '" . (int)$photo_id . "'");
		
		foreach ($data['photo_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO po_gallery_photo_description SET photo_id = '" . (int)$photo_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}

		$this->db->query("DELETE FROM po_gallery_photo_to_store WHERE photo_id = '" . (int)$photo_id . "'");

		if (isset($data['photo_store'])) {
			foreach ($data['photo_store'] as $store_id) {
				$this->db->query("INSERT INTO po_gallery_photo_to_store SET photo_id = '" . (int)$photo_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM po_gallery_photo_to_album WHERE photo_id = '" . (int)$photo_id . "'");
		
		if (isset($data['photo_album'])) {
			foreach ($data['photo_album'] as $album_id) {
				$this->db->query("INSERT INTO po_gallery_photo_to_album SET photo_id = '" . (int)$photo_id . "', album_id = '" . (int)$album_id . "'");
			}		
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'po_photo_id=" . (int)$photo_id. "'");
						
		$this->cache->delete('photo');
	}
	
	public function copyPhoto($photo_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM po_gallery_photo p LEFT JOIN po_gallery_photo_description pd ON (p.photo_id = pd.photo_id) WHERE p.photo_id = '" . (int)$photo_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		if ($query->num_rows) {
			$data = array();
			
			$data = $query->row;

			$data['status'] = '0';
						
			$data = array_merge($data, array('photo_description' => $this->getPhotoDescriptions($photo_id)));			
			$data = array_merge($data, array('photo_album' => $this->getPhotoAlbums($photo_id)));
			$data = array_merge($data, array('photo_store' => $this->getPhotoStores($photo_id)));
			
			$this->addPhoto($data);
		}
	}
	
	public function deletePhoto($photo_id) {
		$this->db->query("DELETE FROM po_gallery_photo WHERE photo_id = '" . (int)$photo_id . "'");
		$this->db->query("DELETE FROM po_gallery_photo_description WHERE photo_id = '" . (int)$photo_id . "'");
		$this->db->query("DELETE FROM po_gallery_photo_to_album WHERE photo_id = '" . (int)$photo_id . "'");
		$this->db->query("DELETE FROM po_gallery_photo_to_store WHERE photo_id = '" . (int)$photo_id . "'");
		
		$this->cache->delete('photo');
	}
	
	public function getPhoto($photo_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM po_gallery_photo p LEFT JOIN po_gallery_photo_description pd ON (p.photo_id = pd.photo_id) WHERE p.photo_id = '" . (int)$photo_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
				
		return $query->row;
	}
	
	public function getPhotos($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM po_gallery_photo p LEFT JOIN po_gallery_photo_description pd ON (p.photo_id = pd.photo_id)";
			
			if (!empty($data['filter_album_id'])) {
				$sql .= " LEFT JOIN po_gallery_photo_to_album p2c ON (p.photo_id = p2c.photo_id)";			
			}
					
			$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}
			
			if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
				$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
			}
					
			if (!empty($data['filter_album_id'])) {
				if (!empty($data['filter_sub_album'])) {
					$implode_data = array();
					
					$implode_data[] = "album_id = '" . (int)$data['filter_album_id'] . "'";
					
					$this->load->model('catalog/po_album');
					
					$albums = $this->model_catalog_po_album->getAlbums($data['filter_album_id']);
					
					foreach ($albums as $album) {
						$implode_data[] = "p2c.album_id = '" . (int)$album['album_id'] . "'";
					}
					
					$sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
				} else {
					$sql .= " AND p2c.album_id = '" . (int)$data['filter_album_id'] . "'";
				}
			}
			
			$sql .= " GROUP BY p.photo_id";
						
			$sort_data = array(
				'pd.name',
				'p.status',
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
			$photo_data = $this->cache->get('photo.' . (int)$this->config->get('config_language_id'));
		
			if (!$photo_data) {
				$query = $this->db->query("SELECTf * FROM po_gallery_photo p LEFT JOIN po_gallery_photo_description pd ON (p.photo_id = pd.photo_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");
	
				$photo_data = $query->rows;
			
				$this->cache->set('photo.' . (int)$this->config->get('config_language_id'), $photo_data);
			}	
	
			return $photo_data;
		}
	}
	
	public function getPhotosByAlbumId($album_id) {
		$query = $this->db->query("SELECT * FROM po_gallery_photo p LEFT JOIN po_gallery_photo_description pd ON (p.photo_id = pd.photo_id) LEFT JOIN po_gallery_photo_to_album p2c ON (p.photo_id = p2c.photo_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2c.album_id = '" . (int)$album_id . "' ORDER BY pd.name ASC");
								  
		return $query->rows;
	} 
	
	public function getPhotoDescriptions($photo_id) {
		$photo_description_data = array();
		
		$query = $this->db->query("SELECT * FROM po_gallery_photo_description WHERE photo_id = '" . (int)$photo_id . "'");
		
		foreach ($query->rows as $result) {
			$photo_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
			);
		}
		
		return $photo_description_data;
	}
		
	public function getPhotoStores($photo_id) {
		$photo_store_data = array();
		
		$query = $this->db->query("SELECT * FROM po_gallery_photo_to_store WHERE photo_id = '" . (int)$photo_id . "'");

		foreach ($query->rows as $result) {
			$photo_store_data[] = $result['store_id'];
		}
		
		return $photo_store_data;
	}
		
	public function getPhotoAlbums($photo_id) {
		$photo_album_data = array();
		
		$query = $this->db->query("SELECT * FROM po_gallery_photo_to_album WHERE photo_id = '" . (int)$photo_id . "'");
		
		foreach ($query->rows as $result) {
			$photo_album_data[] = $result['album_id'];
		}

		return $photo_album_data;
	}

	public function getTotalPhotos($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.photo_id) AS total FROM po_gallery_photo p LEFT JOIN po_gallery_photo_description pd ON (p.photo_id = pd.photo_id)";

		if (!empty($data['filter_album_id'])) {
			$sql .= " LEFT JOIN po_gallery_photo_to_album p2c ON (p.photo_id = p2c.photo_id)";			
		}
		 
		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		 			
		if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(pd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_album_id'])) {
			if (!empty($data['filter_sub_album'])) {
				$implode_data = array();
				
				$implode_data[] = "p2c.album_id = '" . (int)$data['filter_album_id'] . "'";
				
				$this->load->model('catalog/po_photo_album');
				
				$albums = $this->model_catalog_po_photo_album->getAlbums($data['filter_album_id']);
				
				foreach ($albums as $album) {
					$implode_data[] = "p2c.album_id = '" . (int)$album['album_id'] . "'";
				}
				
				$sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
			} else {
				$sql .= " AND p2c.album_id = '" . (int)$data['filter_album_id'] . "'";
			}
		}
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}		
}
?>
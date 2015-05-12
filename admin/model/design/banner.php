<?php
class ModelDesignBanner extends Model {
	public function addBanner($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "banner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");

		$banner_id = $this->db->getLastId();

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $row_id => $banner_lang_group) {
				foreach($banner_lang_group as $language_id => $banner_image){
					$this->db->query("INSERT INTO " . DB_PREFIX . "banner_image 
										SET banner_id = '" . (int)$banner_id . "', 
											link = '" .  $this->db->escape($banner_image['link']) . "',
											title = '" .  $this->db->escape($banner_image['title']) . "', 
											row_id = '" .  (int)$row_id . "', 
											image = '" .  $this->db->escape($banner_image['image']) . "',
											language_id = '" .  (int)$language_id . "'");
				}
			}
		}
	}

	public function editBanner($banner_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "banner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' WHERE banner_id = '" . (int)$banner_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $row_id => $banner_lang_group) {
				foreach($banner_lang_group as $language_id => $banner_image){
					$sql = "INSERT INTO " . DB_PREFIX . "banner_image 
										SET banner_id = '" . (int)$banner_id . "', 
											link = '" .  $this->db->escape($banner_image['link']) . "',
											title = '" .  $this->db->escape($banner_image['title']) . "', 
											row_id = '" .  (int)$row_id . "', 
											image = '" .  $this->db->escape($banner_image['image']) . "',
											language_id = '" .  (int)$language_id . "'";
					$this->db->query($sql);
				}
			}
		}
	}

	public function deleteBanner($banner_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner WHERE banner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");
	}

	public function getBanner($banner_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "banner WHERE banner_id = '" . (int)$banner_id . "'");

		return $query->row;
	}

	public function getBanners($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "banner";

		$sort_data = array(
			'name',
			'status'
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

	public function getBannerImages($banner_id) {
		$banner_image_data = array();

		$banner_image_groups = $this->db->query("SELECT row_id FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "' GROUP BY row_id");

		foreach ($banner_image_groups->rows as $row => $group) {
			$banner_image_group = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image WHERE row_id = '" . (int)$group['row_id'] . "' AND banner_id = '" . (int)$banner_id . "'");
			foreach($banner_image_group->rows as $group_by_lang){
				$banner_image_data[$row][$group_by_lang['language_id']] = $group_by_lang;
			}
		}

		return $banner_image_data;
	}

	public function getTotalBanners() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "banner");

		return $query->row['total'];
	}	
}





























?>
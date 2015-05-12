<?php
class ModelCatalogPOGalleryAlbumReview extends Model {
	public function addReview($data) {
		$this->db->query("INSERT INTO po_gallery_album_review SET author = '" . $this->db->escape($data['author']) . "', album_id = '" . $this->db->escape($data['album_id']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = NOW()");
	
		$this->cache->delete('album');
	}
	
	public function editReview($review_id, $data) {
		$this->db->query("UPDATE po_gallery_album_review SET author = '" . $this->db->escape($data['author']) . "', album_id = '" . $this->db->escape($data['album_id']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = NOW() WHERE review_id = '" . (int)$review_id . "'");
	
		$this->cache->delete('album');
	}
	
	public function deleteReview($review_id) {
		$this->db->query("DELETE FROM po_gallery_album_review WHERE review_id = '" . (int)$review_id . "'");
		
		$this->cache->delete('album');
	}
	
	public function getReview($review_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT pd.name FROM po_gallery_album_description pd WHERE pd.album_id = r.album_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS album FROM po_gallery_album_review r WHERE r.review_id = '" . (int)$review_id . "'");
		
		return $query->row;
	}

	public function getReviews($data = array()) {
		$sql = "SELECT r.review_id, pd.name, r.author, r.rating, r.status, r.date_added FROM po_gallery_album_review r LEFT JOIN po_gallery_album_description pd ON (r.album_id = pd.album_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";																																					  
		
		$sort_data = array(
			'pd.name',
			'r.author',
			'r.rating',
			'r.status',
			'r.date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY r.date_added";	
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
	
	public function getTotalReviews() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM po_gallery_album_review");
		
		return $query->row['total'];
	}
	
	public function getTotalReviewsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM po_gallery_album_review WHERE status = '0'");
		
		return $query->row['total'];
	}	
}
?>
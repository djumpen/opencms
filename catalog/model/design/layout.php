<?php
class ModelDesignLayout extends Model {	
	public function getLayout($route) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout_route WHERE '" . $this->db->escape($route) . "' LIKE CONCAT(route, '%') AND store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY route DESC LIMIT 1");
		
		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;	
		}
	}
	
	public function getLayoutForAllPages() {
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout WHERE name like '%all pages%' LIMIT 1");
	    if ($query->num_rows) {
	        return $query->row['layout_id'];
	    } else {
	        return 0;
	    }
	}
	
	public function getLayoutTemplate($route){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout_route WHERE '" . $this->db->escape($route) . "' LIKE CONCAT(route, '%') AND CHAR_LENGTH(TRIM(route)) > 1 AND store_id = '" . (int)$this->config->get('config_store_id') . "' AND template IS NOT NULL ORDER BY route DESC LIMIT 1");
		if ($query->num_rows) {
			return $query->row['template'];
		} else {
			return 0;
		}
	}
	
	public function getGeneralLayoutTemplate($layout_id){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout_route WHERE layout_id = '" . $this->db->escape($layout_id) . "' AND (TRIM(route) = '' OR TRIM(route) = NULL) AND store_id = '" . (int)$this->config->get('config_store_id') . "' AND template IS NOT NULL ORDER BY route DESC LIMIT 1");
// 		echo "SELECT * FROM " . DB_PREFIX . "layout_route WHERE layout_id = '" . $this->db->escape($layout_id) . "' AND (TRIM(route) = '' OR TRIM(route) = NULL) AND store_id = '" . (int)$this->config->get('config_store_id') . "' AND template IS NOT NULL ORDER BY route DESC LIMIT 1";
		if ($query->num_rows) {
			return $query->row['template'];
		} else {
			return 0;
		}
	}
}
?>
<?php
/*
 * Products series
 * Add posibility to link product to product
 * This used in fornt product/product tpl
 * Methods to get product series and products by series placed in front catalog/product model 
 * */
class ModelCatalogSeries extends Model {
	
	/*
	 * Create empty series
	 * */
	public function addSeries($name = '') {
		if(!$name) {
			$sql = "Select count(*) as quantity From " . DB_PREFIX . "series";
			$qu = $this->db->query($sql);
			$new_quantity = $qu->row['quantity'] + 1; 
			$name = 'unnamed_' . $new_quantity;
		}
		/* Check if series exists */
		$sql = "
			Select 
				series_id 
			From 
				" . DB_PREFIX . "series
			Where
				name = '{$this->db->escape($name)}'
		";
		$exists = $this->db->query($sql);
		if($exists->num_rows) {
			return false;
		}
		/* Check if series exists */
		$sql = "
			Insert into " . DB_PREFIX . "series
			Set 
				name = '" . $this->db->escape($name) . "'
		";
		$this->db->query($sql);
		$series_id = $this->db->getLastId();
		
		return $series_id;
	}
	
	/*
	 * Delete series and unlink all products from it
	 * */
	public function deleteSeries($series_id) {
		$sql = "
			Delete From " . DB_PREFIX . "series Where series_id = " . (int)$series_id . "
		";
		$this->db->query($sql);
		$sql = "
			Delete From " . DB_PREFIX . "product_to_series Where series_id = " . (int)$series_id . "
		";
		$this->db->query($sql);
		
		return true;
	}
	
	/*
	 * Add product series and create it if not exists
	 * */
	public function addProductToSeries($product_id, $series_name) {
		$sql = "
			Select * From " . DB_PREFIX . "series
			Where name = '" . $this->db->escape($series_name) . "'
		";
		$series = $this->db->query($sql);
		if($series->num_rows) {
			$series_id = $series->row['series_id'];
		} else {
			$sql = "
				Insert Into " . DB_PREFIX . "series
				Set name = '{$this->db->query($series_name)}';
			";
			$series = $this->db->query($sql);
			$series_id = $this->db->getLastId();
		}
		/* Check if product exists in this series */
		$sql = "
				Select
					product_id
				From
					" . DB_PREFIX . "product_to_series
				Where
					product_id = " . (int)$product_id . "
				And
					series_id = " . (int)$series_id . "
			";
		$exists = $this->db->query($sql);
		if($exists->num_rows) {
			return false;
		}
		$sql = "
			Insert Into " . DB_PREFIX . "product_to_series
			Set 
				product_id = " . (int)$product_id . ",
				series_id = " . (int)$series_id . "
		";
		$this->db->query($sql);
		$link_id = $this->db->getLastId();
		
		return $link_id;
	}
	/*
	 * Add product series by id
	 * */
	public function addProductToSeriesById($product_id, $series_id) {
		$sql = "
			Select * From " . DB_PREFIX . "series
			Where series_id = '" . (int)$series_id . "'
		";
		$series = $this->db->query($sql);
		if(!$series->num_rows) {
			return false;
		} else {
			/* Check if product exists in this series */
			$sql = "
				Select 
					product_id 
				From
					" . DB_PREFIX . "product_to_series
				Where 
					product_id = " . (int)$product_id . "
				And
					series_id = " . (int)$series_id . " 
			";
			$exists = $this->db->query($sql);
			if($exists->num_rows) {
				return false;
			}
			$sql = "
			Insert Into " . DB_PREFIX . "product_to_series
			Set 
				product_id = " . (int)$product_id . ",
				series_id = " . (int)$series_id . "
			";
			$this->db->query($sql);
			$link_id = $this->db->getLastId();
			
			return $link_id;
		}	
	}
	
	/*
	 * Remove product From series
	 * */
	public function deleteProductFromSeries($product_id, $series_id) {
		$sql = "
			Delete From " . DB_PREFIX . "product_to_series
			Where product_id = " . (int)$product_id . " 
			And series_id = " . (int)$series_id . "
		";
		$this->db->query($sql);
		
		return true;
	}
	
	/*
	 * Get all product in target series
	 * */
	public function getSeriesProducts($series_id) {
		$sql = "
			Select 
				product_id 
			From 
				" . DB_PREFIX . "product_to_series
			Where
				series_id = " . (int)$series_id . " 
		";
		$products_id = $this->db->query($sql);
		
		if($products_id->num_rows) {
			$products = array();
			$this->load->model('catalog/product');
			foreach ($products_id->rows as $product_id) {
				$products[] = $this->model_catalog_product->getProduct($product_id['product_id']);
			}
			return $products;
		} else {
			return array();
		}
	}
	
	/*
	 * Get all series
	 * */
	public function getSeries($series_id = 0) {
		
		$sql = "
			Select * From " . DB_PREFIX . "series
		";
		if($series_id) {
			$sql .= " Where series_id = " . (int)$series_id;
			
		}
		$series = $this->db->query($sql);
		
		if($series->num_rows) {
			if($series_id) {
				return $series->row;
			} else {
				return $series->rows;
			}
		} else {
			return array();
		}
	}
	
	/*
	 * Get series id and name by product id
	 * */
	public function getProductSeries($product_id) {
		$sql = "
			Select * From " . DB_PREFIX . "product_to_series p2se
			Left Join " . DB_PREFIX . "series s
				On (s.series_id = p2se.series_id)
			Where p2se.product_id = " . (int)$product_id . "
		";
		$series = $this->db->query($sql);
		
		if($series->num_rows) {
			return $series->row;
		} else {
			return array();
		}
		
	}
	
	/*
	 * Return series by part of name 
	 * Created for autocomplete
	 * */
	public function getSeriesByName($series_name) {
		$sql = "
			Select * 
			From 
				" . DB_PREFIX . "series 
			Where 
				name Like ('%{$this->db->escape($series_name)}%')
		";
		$series = $this->db->query($sql);
		
		if($series->num_rows) {
			return $series->rows;
		} else {
			return array();
		}
	}
}
?>

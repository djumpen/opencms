<?php

/*******************************************************************************
*                                 Opencart SEO Pack                            *
*                             � Copyright Ovidiu Fechete                       *
*                              email: ovife21@gmail.com                        *
*                Below source-code or any part of the source-code              *
*                          cannot be resold or distributed.                    *
*******************************************************************************/


class ModelCatalogSEOReport extends Model {
	
	public function gettotalSEOs($data = array()) {
	
			$query = $this->db->query("SELECT * FROM INFORMATION_SCHEMA.STATISTICS 
						 WHERE `TABLE_SCHEMA` = DATABASE() AND
						`TABLE_NAME` = '" . DB_PREFIX . "url_alias' AND `INDEX_NAME` = 'iquery'");

				$exists = 0;
				foreach ($query->rows as $index) {
					$exists++;
					}

				if (!$exists) {$this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` ADD INDEX `iquery` ( `query` )  ");}
		
			$sql = "select count(*) as total from (
				select 'Product' as type, p.product_id  from " . DB_PREFIX . "product p
				  inner join " . DB_PREFIX . "product_description pd on p.product_id = pd.product_id
				  left join " . DB_PREFIX . "url_alias u on u.language_id = pd.language_id and CONCAT('product_id=', CAST(p.product_id as CHAR)) = u.query
				  
				  where pd.language_id = '" . (int)$this->session->data['language_id'] . "' ";
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(u.keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND LCASE(pd.meta_description) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_description'])) . "%'";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND LCASE(pd.meta_keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_tags'])) {
				$sql .= " AND LCASE(pd.tag) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_tags'])) . "%'";
			}
			
			$sql .= "
			group by p.product_id";
			
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
			$sql.="	  				 				  
				union

				select 'Category' as type,  c.category_id from " . DB_PREFIX . "category c
				  inner join " . DB_PREFIX . "category_description cd on c.category_id = cd.category_id				  
				  left join " . DB_PREFIX . "url_alias u on u.language_id = cd.language_id and CONCAT('category_id=', CAST(c.category_id as CHAR)) = u.query
				  where cd.language_id = '" . (int)$this->session->data['language_id'] . "'";
			if (!empty($data['filter_tags'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(cd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND LCASE(cd.meta_description) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_description'])) . "%'";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND LCASE(cd.meta_keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_keyword'])) . "%'";
			}
			
			
						
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
				  
			$sql .=	"
				union

				select 'Information' as type,  i.information_id from " . DB_PREFIX . "information i
				  inner join " . DB_PREFIX . "information_description id on id.information_id = i.information_id				  
				  left join " . DB_PREFIX . "url_alias u on u.language_id = id.language_id and CONCAT('information_id=', CAST(i.information_id as CHAR)) = u.query
				  where id.language_id = '" . (int)$this->session->data['language_id'] . "'";
			
			if (!empty($data['filter_tags'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(id.title) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND 1=2";
			}
			
					
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
			
			$sql .= "	  
				union

				select 'Manufacturer' as type, m.manufacturer_id from " . DB_PREFIX . "manufacturer m				 
				   left join " . DB_PREFIX . "url_alias u on u.language_id = '" . (int)$this->session->data['language_id'] . "' and CONCAT('manufacturer_id=', CAST(m.manufacturer_id as CHAR)) = u.query WHERE 1=1";
			
			if (!empty($data['filter_tags'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(m.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND 1=2";
			}
			
						
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
			
			$sql .= "			
				)x ";
								
			
				
					
			$query = $this->db->query($sql);
			
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` DROP INDEX `iquery`");
		
			return $query->row['total'];
		 
	}
	
	public function getSEOs($data = array()) {
	
			$query = $this->db->query("SELECT * FROM INFORMATION_SCHEMA.STATISTICS 
						 WHERE `TABLE_SCHEMA` = DATABASE() AND
						`TABLE_NAME` = '" . DB_PREFIX . "url_alias' AND `INDEX_NAME` = 'iquery'");

				$exists = 0;
				foreach ($query->rows as $index) {
					$exists++;
					}

				if (!$exists) {$this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` ADD INDEX `iquery` ( `query` )  ");}
		
			$sql = "select * from (
				
				select 'Product' as type, pd.name as name, p.product_id as id, u.keyword, pd.meta_description, pd.meta_keyword, pd.tag AS tags from " . DB_PREFIX . "product p
				  inner join " . DB_PREFIX . "product_description pd on p.product_id = pd.product_id
				  left join " . DB_PREFIX . "url_alias u on u.language_id = pd.language_id and CONCAT('product_id=', CAST(p.product_id as CHAR)) = u.query
				  
				  
				  where pd.language_id = '" . (int)$this->session->data['language_id'] . "' ";
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND LCASE(meta_description) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_description'])) . "%'";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND LCASE(meta_keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_keyword'])) . "%'";
			}
			
				
			
			$sql .= "
			GROUP BY p.product_id HAVING 1=1";
			
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " AND LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
			if (!empty($data['filter_tags'])) {
				$sql .= " AND LCASE(tags) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_tags'])) . "%'";
			}	
			
			
			$sql.="
				 				  
				union

				select 'Category' as type, cd.name, c.category_id, u.keyword, cd.meta_description, cd.meta_keyword, -1 from " . DB_PREFIX . "category c
				  inner join " . DB_PREFIX . "category_description cd on c.category_id = cd.category_id				  
				  left join " . DB_PREFIX . "url_alias u on u.language_id = cd.language_id and CONCAT('category_id=', CAST(c.category_id as CHAR)) = u.query
				  where cd.language_id = '" . (int)$this->session->data['language_id'] . "'";
			
			if (!empty($data['filter_tags'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(cd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND LCASE(meta_description) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_description'])) . "%'";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND LCASE(meta_keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_meta_keyword'])) . "%'";
			}
			
			
			
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
				  
			$sql .=	"
				union

				select 'Information' as type, id.title, i.information_id, u.keyword, -1, -1, -1 from " . DB_PREFIX . "information i
				  inner join " . DB_PREFIX . "information_description id on id.information_id = i.information_id				  
				  left join " . DB_PREFIX . "url_alias u on u.language_id = id.language_id and CONCAT('information_id=', CAST(i.information_id as CHAR)) = u.query
				  where id.language_id = '" . (int)$this->session->data['language_id'] . "'";
			
			if (!empty($data['filter_tags'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(id.title) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND 1=2";
			}
			
			
			
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
			
			$sql .= "	  
				union

				select 'Manufacturer' as type, m.name, m.manufacturer_id, u.keyword, -1, -1, -1 from " . DB_PREFIX . "manufacturer m				 
				   left join " . DB_PREFIX . "url_alias u on u.language_id = '" . (int)$this->session->data['language_id'] . "' and CONCAT('manufacturer_id=', CAST(m.manufacturer_id as CHAR)) = u.query WHERE 1=1";
			
			if (!empty($data['filter_tags'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(m.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_keyword'])) {
				$sql .= " AND LCASE(keyword) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_keyword'])) . "%'";
			}
			
			if (!empty($data['filter_meta_description'])) {
				$sql .= " AND 1=2";
			}
			
			if (!empty($data['filter_meta_keyword'])) {
				$sql .= " AND 1=2";
			}
			
						
			if (isset($data['filter_type']) && !is_null($data['filter_type'])) {
			$sql .= " HAVING LCASE(type) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_type'])) . "%'";
			}
			
			$sql .= "
				  
				)x ";
			
			
						
			$sort_data = array(
				'type',
				'name',
				'keyword',
				'meta_description',
				'meta_keyword',
				'tags'
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY type desc, name";	
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
			
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "url_alias` DROP INDEX `iquery`");
		
			return $query->rows;
		 
	}
	
			
}
?>
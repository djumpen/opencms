<?php
class ModelCatalogCategory extends Model {

	private function eventEditCategory($category_id, $is_delete = false){

		$this->load->model('catalog/product');

		$filename = DIR_ROOT . 'sitemaps/category_' . $category_id . '.zip';
		if(file_exists($filename)){
			unlink($filename);
		}

		if($is_delete) {
			return;
		}

		$output = '<?xml version="1.0" encoding="UTF-8"?>
						<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
								xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
								xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">';

		$output .= $this->model_catalog_product->getCategoriesSitemap($category_id);
		$output .= '</urlset>';

		$zip = new ZipArchive();
		if ($zip->open($filename, ZipArchive::CREATE)!==TRUE) {
			exit("Невозможно открыть <$filename>\n");
		}
		$zip->addFromString('category_ ' . $category_id . '.xml', $output);
		$zip->close();
	}

	public function addCategory($data) {
		$this->db->query("
			INSERT INTO " . DB_PREFIX . "category 
			SET 
				parent_id = '" . (int)$data['parent_id'] . "', 
				`top` = '" . (isset($data['top']) ? (int)$data['top'] : 0) . "', 
				`is_information` = '" . (isset($data['is_information']) ? (int)$data['is_information'] : 0) . "', 
				`column` = '" . (isset($data['column'])?(int)$data['column']:1) . "',
				sort_order = '" . (int)$data['sort_order'] . "', 
				status = '" . (int)$data['status'] . "', 
				date_modified = NOW(), 
				date_added = NOW()
		");

		$category_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("
				UPDATE " . DB_PREFIX . "category 
				SET 
					image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' 
				WHERE 
					category_id = '" . (int)$category_id . "'
			");
		}

		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("
				INSERT INTO " . DB_PREFIX . "category_description 
				SET 
					category_id = '" . (int)$category_id . "', 
					language_id = '" . (int)$language_id . "', 
					name = '" . $this->db->escape($value['name']) . "', 
					meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', 
					custom_title = '" . ((isset($value['custom_title']))?($this->db->escape($value['custom_title'])):'') . "', 
					meta_description = '" . $this->db->escape($value['meta_description']) . "', 
					custom_h1 = '" . $this->db->escape($value['custom_h1']) . "', 
					short_description = '" . $this->db->escape($value['short_description']) . "', 
					additional_description = '" . (isset($value['additional_description'])?$this->db->escape($value['additional_description']):'') . "', 
					description = '" . $this->db->escape($value['description']) . "'
			");
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$level = 0;

		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY `level` ASC");

		foreach ($query->rows as $result) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . (int)$category_id . "', `path_id` = '" . (int)$result['path_id'] . "', `level` = '" . (int)$level . "'");

			$level++;
		}

		$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . (int)$category_id . "', `path_id` = '" . (int)$category_id . "', `level` = '" . (int)$level . "'");

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		} else {
			$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '0'");
		}

		// Set which layout to use with this category
		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);}
			}
		}

		require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		$seo = new ControllerCatalogSeoPack($this->registry);
		
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
		
		    $query = $this->db->query("SELECT cd.category_id, cd.name, cd.language_id, l.code FROM ".DB_PREFIX."category c
								inner join ".DB_PREFIX."category_description cd on c.category_id = cd.category_id
								inner join ".DB_PREFIX."language l on l.language_id = cd.language_id
								where c.category_id = '" . (int)$category_id . "'");
		
		
		    foreach ($query->rows as $category_row){
		
		        	
		        if( strlen($category_row['name']) > 1 ){
		            	
		            $slug = $seo->generateSlug($category_row['name']);
		            $exist_query =  $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'category_id=" . $category_row['category_id'] . "' and language_id=".$category_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'category_id=" . $category_row['category_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($category_row['name']).'-'.rand();
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($category_row['name']).'-'.$category_row['code'];
		                    }
		                }
		                	
		
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword,language_id) VALUES ('category_id=" . $category_row['category_id'] . "', '" . $slug . "', " . $category_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		$this->cache->delete('category');

		$this->eventEditCategory($category_id);
	}

	public function editCategory($category_id, $data) {
		$this->db->query("
			UPDATE 
				" . DB_PREFIX . "category 
			SET 
				parent_id = '" . (int)$data['parent_id'] . "', 
				`top` = '" . (isset($data['top']) ? (int)$data['top'] : 0) . "', 
				`is_information` = '" . (isset($data['is_information']) ? (int)$data['is_information'] : 0) . "', 
				`column` = '" . (isset($data['column'])?(int)$data['column']:1) . "', 
				sort_order = '" . (int)$data['sort_order'] . "', 
				status = '" . (int)$data['status'] . "', 
				date_modified = NOW() 
			WHERE 
				category_id = '" . (int)$category_id . "'
		");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "category SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE category_id = '" . (int)$category_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");

		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("
				INSERT INTO " . DB_PREFIX . "category_description 
				SET 
					category_id = '" . (int)$category_id . "', 
					language_id = '" . (int)$language_id . "', 
					name = '" . $this->db->escape($value['name']) . "', 
					meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', 
					custom_title = '" . ((isset($value['custom_title']))?($this->db->escape($value['custom_title'])):'') . "', 
					meta_description = '" . $this->db->escape($value['meta_description']) . "', 
					custom_h1= '" . $this->db->escape($value['custom_h1']) . "', 
					short_description = '" . $this->db->escape($value['short_description']) . "', 
					additional_description = '" . (isset($value['additional_description'])?$this->db->escape($value['additional_description']):'') . "', 
					description = '" . $this->db->escape($value['description']) . "'
			");
		}

		// MySQL Hierarchical Data Closure Table Pattern
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE path_id = '" . (int)$category_id . "' ORDER BY level ASC");

		if ($query->rows) {
			foreach ($query->rows as $category_path) {
				// Delete the path below the current one
				$this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category_path['category_id'] . "' AND level < '" . (int)$category_path['level'] . "'");

				$path = array();

				// Get the nodes new parents
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Get whats left of the nodes current path
				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category_path['category_id'] . "' ORDER BY level ASC");

				foreach ($query->rows as $result) {
					$path[] = $result['path_id'];
				}

				// Combine the paths with a new level
				$level = 0;

				foreach ($path as $path_id) {
					$this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category_path['category_id'] . "', `path_id` = '" . (int)$path_id . "', level = '" . (int)$level . "'");

					$level++;
				}
			}
		} else {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category_id . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$data['parent_id'] . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category_id . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category_id . "', `path_id` = '" . (int)$category_id . "', level = '" . (int)$level . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_store'])) {		
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		} else {
			$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_store SET category_id = '" . (int)$category_id . "', store_id = '0'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");

		if (isset($data['category_layout'])) {
			foreach ($data['category_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "category_to_layout SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id. "'");

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);
				}
			}
		}

		require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		$seo = new ControllerCatalogSeoPack($this->registry);
		
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
		
		    $query = $this->db->query("SELECT cd.category_id, cd.name, cd.language_id, l.code FROM ".DB_PREFIX."category c
								inner join ".DB_PREFIX."category_description cd on c.category_id = cd.category_id
								inner join ".DB_PREFIX."language l on l.language_id = cd.language_id
								where c.category_id = '" . (int)$category_id . "'");
		
		
		    foreach ($query->rows as $category_row){
		
		        	
		        if( strlen($category_row['name']) > 1 ){
		            	
		            $slug = $seo->generateSlug($category_row['name']);
		            $exist_query =  $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'category_id=" . $category_row['category_id'] . "' and language_id=".$category_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'category_id=" . $category_row['category_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($category_row['name']).'-'.rand();
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($category_row['name']).'-'.$category_row['code'];
		                    }
		                }
		                	
		
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword,language_id) VALUES ('category_id=" . $category_row['category_id'] . "', '" . $slug . "', " . $category_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		$this->cache->delete('category');

		$this->eventEditCategory($category_id);
	}

	public function deleteCategory($category_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_path WHERE category_id = '" . (int)$category_id . "'");

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_path WHERE path_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {	
			$this->deleteCategory($result['category_id']);
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "'");

		require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		$seo = new ControllerCatalogSeoPack($this->registry);
		
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
		
		    $query = $this->db->query("SELECT cd.category_id, cd.name, cd.language_id, l.code FROM ".DB_PREFIX."category c
								inner join ".DB_PREFIX."category_description cd on c.category_id = cd.category_id
								inner join ".DB_PREFIX."language l on l.language_id = cd.language_id
								where c.category_id = '" . (int)$category_id . "'");
		
		
		    foreach ($query->rows as $category_row){
		
		        	
		        if( strlen($category_row['name']) > 1 ){
		            	
		            $slug = $seo->generateSlug($category_row['name']);
		            $exist_query =  $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'category_id=" . $category_row['category_id'] . "' and language_id=".$category_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'category_id=" . $category_row['category_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($category_row['name']).'-'.rand();
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($category_row['name']).'-'.$category_row['code'];
		                    }
		                }
		                	
		
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword,language_id) VALUES ('category_id=" . $category_row['category_id'] . "', '" . $slug . "', " . $category_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		$this->cache->delete('category');

		$this->eventEditCategory($category_id, true);
	} 

	// Function to repair any erroneous categories that are not in the category path table.
	public function repairCategories($parent_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int)$parent_id . "'");

		foreach ($query->rows as $category) {
			// Delete the path below the current one
			$this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$category['category_id'] . "'");

			// Fix for records with no paths
			$level = 0;

			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int)$parent_id . "' ORDER BY level ASC");

			foreach ($query->rows as $result) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category['category_id'] . "', `path_id` = '" . (int)$result['path_id'] . "', level = '" . (int)$level . "'");

				$level++;
			}

			$this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int)$category['category_id'] . "', `path_id` = '" . (int)$category['category_id'] . "', level = '" . (int)$level . "'");

			$this->repairCategories($category['category_id']);
		}
	}

	public function getKeyWords($category_id) {
	    $keywords = array();
	
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . (int)$category_id . "'");
	
	    foreach ($query->rows as $result) {
	        $keywords[$result['language_id']] = $result['keyword'];
	    }
	
	    return $keywords;
	}
	
	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT GROUP_CONCAT(cd1.name ORDER BY level SEPARATOR ' &gt; ') FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id AND cp.category_id != cp.path_id) WHERE cp.category_id = c.category_id AND cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY cp.category_id) AS path FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (c.category_id = cd2.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	} 
	
	public function getPath($category_id) {
	    $query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
	
	    if ($query->row['parent_id']) {
	        return $this->getPath($query->row['parent_id'], $this->config->get('config_language_id')) . $this->language->get('text_separator') . $query->row['name'];
	    } else {
	        return $query->row['name'];
	    }
	}
	

	public function getCategories($data) {
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR ' &gt; ') AS name, c.parent_id, c.sort_order FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c ON (cp.path_id = c.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (c.category_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND cd2.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}
		
		if (!empty($data['filter_id'])) {
		    $sql .= " And cp.category_id = " . (int)$data['filter_id'];
		}

		if (!empty($data['exclude_category'])) {
			$childs = $this->getCategoryChilds($data['exclude_category']);
			if($childs) {
				$childs .= ', ' . (int)$data['exclude_category'];
				$sql .= " And c.category_id not in (" . $childs . ") ";
				$sql .= " And cp.path_id not in (" . $childs . ") ";
				$sql .= " And cp.category_id not in (" . $childs . ") ";
			} else {
				$sql .= " And cp.path_id <> " . (int)$data['exclude_category'] . " ";
				$sql .= " And cp.category_id <> " . (int)$data['exclude_category'] . " ";
				$sql .= " And c.category_id <> " . (int)$data['exclude_category'] . " ";
			}
		}
		
		$sql .= " GROUP BY cp.category_id ORDER BY name";

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
	

	public function getCategoryChilds($category_id) {
		$childs = array();
		$sql = "
			Select category_id
			From " . DB_PREFIX . "category_path
			Where
				path_id = " . (int)$category_id . "
		";
		$categories = $this->db->query($sql);
		if($categories->num_rows) {
			foreach ($categories->rows as $category) {
				if($category['category_id']) {
					$childs[] = $category['category_id'];
				}
			}
			return implode(', ', $childs);
		} else {
			return false;
		}
	}

	public function getCategoriesByParentId($data) {
		if(isset($data['parent_id'])) {
			$parent_id = (int)$data['parent_id'];
		} else {
			$parent_id = 0;
		}
		if(isset($data['start']) && isset($data['limit'])) {
			$start  = (int)$data['start'];
			$limit  = (int)$data['limit'];
		} else {
			$start  = 0;
			$limit  = 0;
		}
		$sql = "
			Select * From " . DB_PREFIX . "category c
			Left Join " . DB_PREFIX. "category_description cd
				On (cd.category_id = c.category_id)
			Where
				c.parent_id = {$parent_id}
			And
				cd.language_id = {$this->config->get('config_language_id')}
			Order by c.category_id
			
		";
		if($limit) {
			$sql .= " Limit {$start}, {$limit}";
		}
		$categories = $this->db->query($sql);
		
		if($categories->num_rows) {
			return $categories->rows;
		} else {
			return false;
		}
	}
	
	public function getCategoryDescriptions($category_id) {
		$category_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_description WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_description_data[$result['language_id']] = array(
				'name'                   => $result['name'],
				'meta_keyword'           => $result['meta_keyword'],
				'custom_title'           => $result['custom_title'],
                'meta_description'       => $result['meta_description'],
                'custom_h1'              => $result['custom_h1'],
				'description'            => $result['description'],
				'short_description'      => $result['short_description'],
				'additional_description' => $result['additional_description'],
			);
		}

		return $category_description_data;
	}	

	public function getCategoryFilters($category_id) {
		$category_filter_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_filter_data[] = $result['filter_id'];
		}

		return $category_filter_data;
	}

	public function getCategoryStores($category_id) {
		$category_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_store WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_store_data[] = $result['store_id'];
		}

		return $category_store_data;
	}

	public function getCategoryLayouts($category_id) {
		$category_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$category_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $category_layout_data;
	}
	
	public function getCategoryFullName($category_id) {
	    $sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR ' &gt; ') AS name, c.parent_id, c.sort_order FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c ON (cp.path_id = c.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (c.category_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";
	    $sql .= " And cp.category_id = " . (int)$category_id;
	    $sql .= " GROUP BY cp.category_id ORDER BY name";
	    
	    $query = $this->db->query($sql);
	     
	    if($query->num_rows) {
	        return $query->row['name'];
	    } else {
	        return '';
	    }
	}

	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category");

		return $query->row['total'];
	}	

	public function getTotalCategoriesByImageId($image_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category WHERE image_id = '" . (int)$image_id . "'");

		return $query->row['total'];
	}

	public function getTotalCategoriesByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
	
	public function getTotalCategoriesByParent($parent_id) {
		$sql = 'Select count(*) as quantity From ' . DB_PREFIX . 'category Where parent_id = ' . (int)$parent_id;
		$total = $this->db->query($sql);
		
		if($total->num_rows) {
			return $total->row['quantity'];
		} else {
			return 0;
		}
	}
	
	public function categoryHasChilds($category_id) {
		$sql = 'Select category_id From ' . DB_PREFIX . 'category Where parent_id = ' . (int)$category_id;
		$childs = $this->db->query($sql);
		if($childs->num_rows) {
			return true;
		} else {
			return false;
		}
	}
	
	public function getCategoryLevel($category_id) {
		$sql = 'Select max(level) as level From ' . DB_PREFIX . 'category_path Where category_id = ' . (int)$category_id;
		$level = $this->db->query($sql);
		if($level->num_rows) {
			return $level->row['level'];
		} else {
			return 0;
		}
	}
}
?>

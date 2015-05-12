<?php
class ModelCatalogProduct extends Model {

	/****************************** Sitemap generator *******************************/
	var $used_products = array();

	private function eventEditProduct($product_id){
		$this->load->model('catalog/category');

		// get categories by product_id
		$categories = $this->getProductCategories($product_id);

		foreach($categories as $category_id){
			$output = '<?xml version="1.0" encoding="UTF-8"?>
						<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
								xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
								xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">';

			$output .= $this->getCategoriesSitemap($category_id);
			$output .= '</urlset>';

			$filename = DIR_ROOT . 'sitemaps/category_' . $category_id . '.zip';
			if(file_exists($filename)){
				unlink($filename);
			}

			$zip = new ZipArchive();
			if ($zip->open($filename, ZipArchive::CREATE)!==TRUE) {
				exit("Невозможно открыть <$filename>\n");
			}
			$zip->addFromString('category_ ' . $category_id . '.xml', $output);
			$zip->close();
		}
	}

	public function getCategoriesSitemap($category_id, $current_path = '') {
		$output = '';

		$results = $this->getCategories($category_id);
		foreach ($results as $result) {
			if (!$current_path) {
				$new_path = $result['category_id'];
			} else {
				$new_path = $current_path . '_' . $result['category_id'];
			}

			$output .= '<url>';
			$output .= '<loc>' . $this->url->link('product/category', 'path=' . $new_path, 'NOSSL', true) . '</loc>';
			$output .= '<changefreq>weekly</changefreq>';
			$output .= '<priority>0.7</priority>';
			$output .= '</url>';

			$products = $this->model_catalog_product->getProducts(array('filter_category_id' => $result['category_id']));

			foreach ($products as $product) {
				if(in_array($product['product_id'], $this->used_products)){
					continue;
				} else {
					$this->used_products[] = $product['product_id'];
				}
				$output .= '<url>';
				$output .= '<loc>' . $this->url->link('product/product', 'product_id=' . $product['product_id'], 'NOSSL', true) . '</loc>';
				$output .= '<changefreq>weekly</changefreq>';
				$output .= '<priority>1.0</priority>';
				$output .= '</url>';
			}

			//$output .= $this->getCategoriesSitemap($result['category_id'], $new_path);
		}

		return $output;
	}

	public function getCategories($category_id = 0) {
		$sql = "
    		SELECT *
    		FROM " . DB_PREFIX . "category c
    		LEFT JOIN " . DB_PREFIX . "category_description cd
    			ON (c.category_id = cd.category_id)
    		LEFT JOIN " . DB_PREFIX . "category_to_store c2s
    			ON (c.category_id = c2s.category_id)
    		WHERE c.category_id = '" . (int)$category_id . "'
    		AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'
    		AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
    		AND c.status = '1'
    		ORDER BY c.sort_order = 0, c.sort_order, LCASE(cd.name)";
		$query = $this->db->query($sql);
		return $query->rows;
	}
	/****************************** END of Sitemap generator *******************************/




	public function addProduct($data) {
	    $sql = "
            INSERT INTO " . DB_PREFIX . "product 
            SET model = '" . $this->db->escape($data['model']) . "', 
            sku = '" . (isset($data['sku'])?$this->db->escape($data['sku']):'') . "', 
            upc = '" . (isset($data['upc'])?$this->db->escape($data['upc']):'') . "', 
            ean = '" . (isset($data['ean'])?$this->db->escape($data['ean']):'') . "', 
            jan = '" . (isset($data['jan'])?$this->db->escape($data['jan']):'') . "', 
            isbn = '" . (isset($data['isbn'])?$this->db->escape($data['isbn']):'') . "', 
            mpn = '" . (isset($data['mpn'])?$this->db->escape($data['mpn']):'') . "', 
            location = '" . (isset($data['location'])?$this->db->escape($data['location']):'') . "', 
            quantity = '" . (int)$data['quantity'] . "', 
            minimum = '" . (int)$data['minimum'] . "', 
            subtract = '" . (isset($data['subtract'])?(int)$data['subtract']:0) . "', 
            stock_status_id = '" . (int)$data['stock_status_id'] . "', 
            date_available = '" . $this->db->escape($data['date_available']) . "', 
            manufacturer_id = '" . (int)$data['manufacturer_id'] . "', 
            shipping = '" . (isset($data['shipping'])?(int)$data['shipping']:1) . "', 
            price = '" . (float)$data['price'] . "', 
            whole_sale_price = '" . ((isset($data['whole_sale_price']))?($this->db->escape((float)$data['whole_sale_price'])):0) . "',
            whole_sale_price_quantity = '" . ((isset($data['whole_sale_price_quantity']))?($this->db->escape((float)$data['whole_sale_price_quantity'])):0) . "',
            promo_top_right = '" . (int)$data['promo_top_right'] . "', 
            promo_top_left = '', 
            promo_bottom_right = '', 
            promo_bottom_left = '', 
            promo_date_start = '" . $this->db->escape($data['promo_date_start']) . "', 
            promo_date_end = '" . $this->db->escape($data['promo_date_end']) . "', 
            points = '" . (isset($data['points'])?(int)$data['points']:0) . "', 
            weight = '" . (float)$data['weight'] . "', 
            weight_class_id = '" . (int)$data['weight_class_id'] . "', 
            length = '" . (float)$data['length'] . "', 
            width = '" . (float)$data['width'] . "', 
            height = '" . (float)$data['height'] . "', 
            length_class_id = '" . (int)$data['length_class_id'] . "', 
            status = '" . (int)$data['status'] . "', 
            tax_class_id = '" . $this->db->escape($data['tax_class_id']) . "', 
            sort_order = '" . (int)$data['sort_order'] . "', 
            video = '" . (isset($data['video'])?$this->db->escape($data['video']):'') . "',
            date_added = NOW()
        ";
		$this->db->query($sql);

		$product_id = $this->db->getLastId();

		if (isset($data['def_img']) && $data['def_img'] != "") {
		    $q="
    			UPDATE " . DB_PREFIX . "product 
    			SET 
    				image = '" . $this->db->escape($data['def_img']) . "' 
    			WHERE 
    				product_id = '" . (int)$product_id . "'
    		";
		    $this->db->query($q);
		} else {
			$q="
    			UPDATE " . DB_PREFIX . "product
    			SET
    				image = ''
    			WHERE
    				product_id = '" . (int)$product_id . "'
    		";
			$this->db->query($q);
		}


		foreach ($data['product_description'] as $language_id => $value) {
			$this->db->query("
				INSERT INTO 
					" . DB_PREFIX . "product_description 
				SET 
					product_id = '" . (int)$product_id . "', 
					language_id = '" . (int)$language_id . "', 
					name = '" . $this->db->escape($value['name']) . "', 
					description = '" . $this->db->escape($value['description']) . "', 
					meta_keyword = '" . (isset($value['meta_keyword'])?$this->db->escape($value['meta_keyword']):'') . "', 
					custom_title = '" . (isset($value['custom_title'])?$this->db->escape($value['custom_title']):'') . "', 
					custom_h1 = '" . (isset($value['custom_h1'])?$this->db->escape($value['custom_h1']):'') . "', 
					custom_alt = '" . (isset($value['custom_alt'])?$this->db->escape($value['custom_alt']):'') . "', 
					meta_description = '" . (isset($value['meta_description'])?$this->db->escape($value['meta_description']):'') . "', 
					short_description = '" . (isset($value['short_description'])?$this->db->escape($value['short_description']):'') . "', 
					tag = '" . (isset($value['tag'])?$this->db->escape($value['tag']):'') . "'
			");
		}

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		} else {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '0'");
		}
		if (isset($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					$this->db->query("
						DELETE FROM 
							" . DB_PREFIX . "product_attribute 
						WHERE 
							product_id = '" . (int)$product_id . "' 
						AND 
							attribute_id = '" . (int)$product_attribute['attribute_id'] . "'
					");

					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {				
						$this->db->query("
							INSERT INTO 
								" . DB_PREFIX . "product_attribute 
							SET 
								product_id = '" . (int)$product_id . "', 
								attribute_id = '" . (int)$product_attribute['attribute_id'] . "', 
								language_id = '" . (int)$language_id . "', 
								text = '" .  $this->db->escape($product_attribute_description['text']) . "'
						");
					}
				}
			}
		}

		if (isset($data['product_option'])) {
		    // Dependent Options
		    $dependent_option = array();
		    $dependent_option_value = array();
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'radiocolor' || $product_option['type'] == 'radiolabel' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'checkboxcolor' || $product_option['type'] == 'checkboxlabel' || $product_option['type'] == 'image' || $product_option['type'] == 'custom_text') {
					$this->db->query("
						INSERT INTO 
							" . DB_PREFIX . "product_option 
						SET 
							product_id = '" . (int)$product_id . "', 
							option_id = '" . (int)$product_option['option_id'] . "', 
							required = '" . (int)$product_option['required'] . "'
					");

					$product_option_id = $this->db->getLastId();
					$dependent_option[$product_option['option_id']] = $product_option_id; // Dependent Options
					if (isset($product_option['product_option_value']) && count($product_option['product_option_value']) > 0 ) {
						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("
								INSERT INTO 
									" . DB_PREFIX . "product_option_value 
								SET 
									product_option_id = '" . (int)$product_option_id . "', 
									product_id = '" . (int)$product_id . "', 
									option_id = '" . (int)$product_option['option_id'] . "', 
									option_value_id = '" . (int)$product_option_value['option_value_id'] . "', 
									quantity = '" . (int)$product_option_value['quantity'] . "', 
									subtract = '" . (int)$product_option_value['subtract'] . "', 
									price = '" . (float)$product_option_value['price'] . "', 
									price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', 
									points = '" . (int)$product_option_value['points'] . "', 
									points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', 
									weight = '" . (float)$product_option_value['weight'] . "', 
									weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'
							");
							// Dependent Options
							$product_option_value_id = $this->db->getLastId();
							$dependent_option_value[$product_option_value['option_value_id']] = $product_option_value_id;
						} 
					}else{
						$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_option_id = '".$product_option_id."'");
					}
				} else { 
					$this->db->query("
						INSERT INTO 
							" . DB_PREFIX . "product_option 
						SET 
							product_id = '" . (int)$product_id . "', 
							option_id = '" . (int)$product_option['option_id'] . "', 
							option_value = '" . $this->db->escape($product_option['option_value']) . "', 
							required = '" . (int)$product_option['required'] . "'
					");
				}
			}
			// Dependent Options
			$this->checkDependentOptionDb();
			$this->checkDependentOptionValueDb();
			
			if (!empty($dependent_option)) {
			    foreach ($data['product_option'] as $product_option) {
			        if (isset($product_option['parent_option_id']) && !empty($product_option['parent_option_id'])) {
			            $this->db->query("
			            	INSERT INTO 
			            		`" . DB_PREFIX . "dependent_option` 
			            	SET 
			            		product_id = '" . (int)$product_id . "', 
			            		parent_option_id = '" . (int)$product_option['parent_option_id'] . "', 
			            		child_option_id = '" . (int)$product_option['option_id'] . "', 
			            		parent_product_option_id = '" . (int)$dependent_option[$product_option['parent_option_id']] . "', 
			            		child_product_option_id = '" . (int)$dependent_option[$product_option['option_id']] . "'
			            ");
			        }
			
			        if (isset($product_option['product_option_value'])) {
			            foreach ($product_option['product_option_value'] as $product_option_value) {
			                if (isset($product_option_value['parent_option_value']) && !empty($product_option_value['parent_option_value'])) {
			                    foreach ($product_option_value['parent_option_value'] as $parent_option_value_id) {
			                        $this->db->query("
			                        	INSERT INTO 
			                        		`" . DB_PREFIX . "dependent_option_value` 
			                        	SET 
			                        		product_id = '" . (int)$product_id . "', 
			                        		parent_option_id = '" . (int)$product_option['parent_option_id'] . "', 
			                        		child_option_id = '" . (int)$product_option['option_id'] . "', 
			                        		parent_option_value_id = '" . (int)$parent_option_value_id . "', 
			                        		child_option_value_id = '" . (int)$product_option_value['option_value_id'] . "', 
			                        		parent_product_option_value_id = '" . (int)$dependent_option_value[$parent_option_value_id] . "', 
			                        		child_product_option_value_id = '" . (int)$dependent_option_value[$product_option_value['option_value_id']] . "'
			                        ");
			                    }
			                }
			            }
			        }
			    }
			}
		}

		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("
					INSERT INTO 
						" . DB_PREFIX . "product_discount 
					SET 
						product_id = '" . (int)$product_id . "', 
						customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', 
						quantity = '" . (int)$product_discount['quantity'] . "', 
						priority = '" . (int)$product_discount['priority'] . "', 
						price = '" . (float)$product_discount['price'] . "', 
						date_start = '" . $this->db->escape($product_discount['date_start']) . "', 
						date_end = '" . $this->db->escape($product_discount['date_end']) . "'
				");
			}
		}

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("
					INSERT INTO 
						" . DB_PREFIX . "product_special 
					SET 
						product_id = '" . (int)$product_id . "', 
						customer_group_id = '" . (int)$product_special['customer_group_id'] . "', 
						priority = '" . (int)$product_special['priority'] . "', 
						price = '" . (float)$product_special['price'] . "', 
						date_start = '" . $this->db->escape($product_special['date_start']) . "', 
						date_end = '" . $this->db->escape($product_special['date_end']) . "'
				");
			}
		}

		if (isset($data['product_image'])) {
			foreach ($data['product_image'] as $product_image) {
				$this->db->query("
					INSERT INTO 
						" . DB_PREFIX . "product_image 
					SET 
						product_id = '" . (int)$product_id . "', 
						image = '" . $this->db->escape(html_entity_decode($product_image['image'], ENT_QUOTES, 'UTF-8')) . "', 
						sort_order = '" . (int)$product_image['sort_order'] . "'
				");
			}
		}

		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("
					INSERT INTO 
						" . DB_PREFIX . "product_to_download 
					SET 
						product_id = '" . (int)$product_id . "', 
						download_id = '" . (int)$download_id . "'
				");
			}
		}

		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("
					INSERT INTO 
						" . DB_PREFIX . "product_to_category 
					SET 
						product_id = '" . (int)$product_id . "', 
						category_id = '" . (int)$category_id . "'
				");
			}
		}

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $product_reward) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$product_reward['points'] . "'");
			}
		}

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		if ($data['keyword']) {
			foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {
					$this->db->query("
						INSERT INTO 
							" . DB_PREFIX . "url_alias 
						SET 
							query = 'product_id=" . (int)$product_id . "', 
							keyword = '" . $this->db->escape($keyword) . "', 
							language_id = " . $language_id
		   			);
				}
			}
		}

		if (isset($data['product_profiles'])) {
			foreach ($data['product_profiles'] as $profile) {
				$this->db->query("
						INSERT INTO 
							`" . DB_PREFIX . "product_profile` 
						SET 
							`product_id` = " . (int)$product_id . ", 
							customer_group_id = " . (int)$profile['customer_group_id'] . ", 
							`profile_id` = " . (int)$profile['profile_id']
		    	);
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
		else {
		    $parameters['keywords'] = '%c%p';
		    $parameters['tags'] = '%c%p';
		    $parameters['metas'] = '%p - %f';
		}
		
		
		if (isset($parameters['ext'])) { $ext = $parameters['ext'];}
		else {$ext = '';}
			
		if ((isset($parameters['autokeywords'])) && ($parameters['autokeywords']))
		{
		    $query = $this->db->query("
	    		select 
		    		pd.name as pname, 
		    		cd.name as cname, 
		    		pd.language_id as language_id, 
		    		pd.product_id as product_id, 
		    		p.sku as sku, 
		    		p.model as model, 
		    		p.upc as upc, 
		    		m.name as brand  
		    	from 
		    		" . DB_PREFIX . "product_description pd
				left join 
		    		" . DB_PREFIX . "product_to_category pc 
	    		on 
		    		pd.product_id = pc.product_id
				inner join 
		    		" . DB_PREFIX . "product p on pd.product_id = p.product_id
				left join 
		    		" . DB_PREFIX . "category_description cd 
	    		on 
		    		cd.category_id = pc.category_id 
	    			and 
		    		cd.language_id = pd.language_id
				left join 
		    		" . DB_PREFIX . "manufacturer m 
	    		on 
		    		m.manufacturer_id = p.manufacturer_id
				where 
		    		p.product_id = '" . (int)$product_id . "';
    		");
		    foreach ($query->rows as $product) {
		
		        $bef = array("%", "_","\"","'","\\");
		        $aft = array("", " ", " ", " ", "");
		        	
		        $included = explode('%', str_replace(array(' ',','), '', $parameters['keywords']));
		        	
		        $tags = array();
		        	
		        if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
		        if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
		        if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
		        if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
		        if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
		        if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
		        	
		        $keywords = '';
		        	
		        foreach ($tags as $tag)
		        {
		            if (strlen($tag) > 2)
		            {
		                	
		                $keywords = $keywords.' '.strtolower($tag);
		                	
		            }
		        }
		
		        	
		        $exists = $this->db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_keyword like '%".$keywords."%';");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $count = $exist['times'];
		        }
		        $exists = $this->db->query("select length(meta_keyword) as leng from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $leng = $exist['leng'];
		        }
		
		        if (($count == 0) && ($leng < 255)) {$this->db->query("update " . DB_PREFIX . "product_description set meta_keyword = concat(meta_keyword, '". htmlspecialchars($keywords) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}
		
		
		    }
		}
		if ((isset($parameters['autometa'])) && ($parameters['autometa']))
		{
		    $query = $this->db->query("select pd.name as pname, p.price as price, cd.name as cname, pd.description as pdescription, pd.language_id as language_id, pd.product_id as product_id, p.model as model, p.sku as sku, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
								left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
								inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
								left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
								left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
								where p.product_id = '" . (int)$product_id . "';");
		
		    foreach ($query->rows as $product) {
		
		        $bef = array("%", "_","\"","'","\\", "\r", "\n");
		        $aft = array("", " ", " ", " ", "", "", "");
		        	
		        $ncategory = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))));
		        $nproduct = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))));
		        $model = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))));
		        $sku = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))));
		        $upc = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))));
		        $content = strip_tags(html_entity_decode($product['pdescription']));
		        $pos = strpos($content, '.');
		        if($pos === false) {}
		        else { $content =  substr($content, 0, $pos+1);	}
		        $sentence = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft, $content))));
		        $brand = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))));
		        $price = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft, number_format($product['price'], 2)))));
		        	
		        $bef = array("%c", "%p", "%m", "%s", "%u", "%f", "%b", "%$");
		        $aft = array($ncategory, $nproduct, $model, $sku, $upc, $sentence, $brand, $price);
		        	
		        $meta_description = str_replace($bef, $aft,  $parameters['metas']);
		        	
		        $exists = $this->db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_description not like '%".htmlspecialchars($meta_description)."%';");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $count = $exist['times'];
		        }
		        	
		        if ($count) {$this->db->query("update " . DB_PREFIX . "product_description set meta_description = concat(meta_description, '". htmlspecialchars($meta_description) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}
		
		    }
		}
		if ((isset($parameters['autotags'])) && ($parameters['autotags']))
		{
		    $query = $this->db->query("select pd.name as pname, pd.tag, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
							inner join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
							inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
							inner join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
							left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
							where p.product_id = '" . (int)$product_id . "';");
		    	
		    foreach ($query->rows as $product) {
		
		        $newtags ='';
		
		        $included = explode('%', str_replace(array(' ',','), '', $parameters['tags']));
		
		        $tags = array();
		
		
		        $bef = array("%", "_","\"","'","\\");
		        $aft = array("", " ", " ", " ", "");
		
		        if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
		        if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
		        if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
		        if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
		        if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
		        if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
		        	
		        foreach ($tags as $tag)
		        {
		            if (strlen($tag) > 2)
		            {
		                if ((strpos($product['tag'], strtolower($tag)) === false) && (strpos($newtags, strtolower($tag)) === false))
		                {
		                    $newtags .= ' '.strtolower($tag).',';
		                }
		            }
		        }
		        	
		
		        if ($product['tag']) {
		            $newtags = trim($this->db->escape($product['tag']) . $newtags,' ,');
		            $this->db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
		        }
		        else {
		            $newtags = trim($newtags,' ,');
		            $this->db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
		        }
		
		    }
		
		}
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT pd.product_id, pd.name, pd.language_id ,l.code FROM ".DB_PREFIX."product p
								inner join ".DB_PREFIX."product_description pd ON p.product_id = pd.product_id
								inner join ".DB_PREFIX."language l on l.language_id = pd.language_id
								where p.product_id = '" . (int)$product_id . "';");
		
		
		    foreach ($query->rows as $product_row ){
		
		        	
		        if( strlen($product_row['name']) > 1 ){
		            	
		            $slug = $seo->generateSlug($product_row['name']).$ext;
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'product_id=" . $product_row['product_id'] . "' and language_id=".$product_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'product_id=" . $product_row['product_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($product_row['name']).'-'.rand().$ext;
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($product_row['name']).'-'.$product_row['code'].$ext;
		                    }
		                }
		
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword, language_id) VALUES ('product_id=" . $product_row['product_id'] . "', '" . $slug . "', " . $product_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
// 		$this->linkOptionToFilter($product_id);
		$this->cache->delete('product');

		$this->eventEditProduct($product_id);
	}

	public function editProduct($product_id, $data) {
	    if(!isset($data['points'])) {
	        $data['points'] = 0;
	    }
		$this->db->query("
			UPDATE 
				" . DB_PREFIX . "product 
			SET 
				model = '" . $this->db->escape($data['model']) . "', 
				sku = '" . (isset($data['sku'])?$this->db->escape($data['sku']):'') . "', 
				upc = '" . (isset($data['upc'])?$this->db->escape($data['upc']):'') . "', 
				ean = '" . (isset($data['ean'])?$this->db->escape($data['ean']):'') . "', 
				jan = '" . (isset($data['jan'])?$this->db->escape($data['jan']):'') . "', 
				isbn = '" . (isset($data['isbn'])?$this->db->escape($data['isbn']):'') . "', 
				mpn = '" . (isset($data['mpn'])?$this->db->escape($data['mpn']):'') . "', 
				location = '" . (isset($data['location'])?$this->db->escape($data['location']):'') . "', 
				quantity = '" . (isset($data['quantity'])?(int)$data['quantity']:1) . "', 
				minimum = '" . (isset($data['minimum'])?(int)$data['minimum']:1) . "', 
				subtract = '" . (isset($data['subtract'])?(int)$data['subtract']:0) . "', 
				stock_status_id = '" . (int)$data['stock_status_id'] . "', 
				date_available = '" . $this->db->escape($data['date_available']) . "', 
				manufacturer_id = '" . (int)$data['manufacturer_id'] . "', 
				shipping = '" . (isset($data['shipping'])?(int)$data['shipping']:1) . "', 
				price = '" . (float)$data['price'] . "', 
				whole_sale_price = '" . (isset($data['whole_sale_price'])?$this->db->escape((float)$data['whole_sale_price']):0) . "',
				whole_sale_price_quantity = '" . (isset($data['whole_sale_price_quantity'])?$this->db->escape((int)$data['whole_sale_price_quantity']):0) . "',
				promo_top_right = '" . (int)$data['promo_top_right'] . "', 
				promo_top_left = '', 
				promo_bottom_right = '', 
				promo_bottom_left = '', 
				promo_date_start = '" . $this->db->escape($data['promo_date_start']) . "', 
				promo_date_end = '" . $this->db->escape($data['promo_date_end']) . "', 
				points = '" . (isset($data['points'])?(int)$data['points']:0) . "', 
				weight = '" . (float)$data['weight'] . "', 
				weight_class_id = '" . (int)$data['weight_class_id'] . "', 
				length = '" . (float)$data['length'] . "', 
				width = '" . (float)$data['width'] . "', 
				height = '" . (float)$data['height'] . "', 
				length_class_id = '" . (int)$data['length_class_id'] . "', 
				status = '" . (int)$data['status'] . "', 
				tax_class_id = '" . $this->db->escape($data['tax_class_id']) . "', 
				sort_order = '" . (int)$data['sort_order'] . "', 
				video = '" . (isset($data['video'])?$this->db->escape($data['video']):'') . "',
				date_modified = NOW() 
			WHERE 
				product_id = '" . (int)$product_id . "'
		");

		if (isset($data['def_img']) && $data['def_img'] != "") {
		    $q="
    			UPDATE " . DB_PREFIX . "product 
    			SET 
    				image = '" . $this->db->escape($data['def_img']) . "' 
    			WHERE 
    				product_id = '" . (int)$product_id . "'
    		";
		    $this->db->query($q);
		} else {
			$q="
    			UPDATE " . DB_PREFIX . "product
    			SET
    				image = ''
    			WHERE
    				product_id = '" . (int)$product_id . "'
    		";
			$this->db->query($q);
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");

		foreach ($data['product_description'] as $language_id => $value) {
			$this->db->query("
				INSERT INTO 
					" . DB_PREFIX . "product_description 
				SET 
					product_id = '" . (int)$product_id . "', 
					language_id = '" . (int)$language_id . "', 
					name = '" . $this->db->escape($value['name']) . "', 
					description = '" . $this->db->escape($value['description']) . "', 
					meta_keyword = '" . (isset($value['meta_keyword'])?$this->db->escape($value['meta_keyword']):'') . "', 
					custom_title = '" . (isset($value['custom_title'])?$this->db->escape($value['custom_title']):'') . "', 
					custom_h1 = '" . (isset($value['custom_h1'])?$this->db->escape($value['custom_h1']):'') . "', 
					custom_alt = '" . (isset($value['custom_alt'])?$this->db->escape($value['custom_alt']):'') . "', 
					meta_description = '" . (isset($value['meta_description'])?$this->db->escape($value['meta_description']):'') . "', 
					short_description = '" . (isset($value['short_description'])?$this->db->escape($value['short_description']):'') . "', 
					tag = '" . (isset($value['tag'])?$this->db->escape($value['tag']):'') . "
			'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		} else {
		    $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '0'");
    		
		}		
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");

		if (!empty($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");

					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {				
						$this->db->query("
							INSERT INTO 
								" . DB_PREFIX . "product_attribute 
							SET 
								product_id = '" . (int)$product_id . "', 
								attribute_id = '" . (int)$product_attribute['attribute_id'] . "', 
								language_id = '" . (int)$language_id . "', 
								text = '" .  $this->db->escape($product_attribute_description['text']) . "'
						");
					}
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "dependent_option WHERE product_id = '" . (int)$product_id . "'"); // Dependent Options
		$this->db->query("DELETE FROM " . DB_PREFIX . "dependent_option_value WHERE product_id = '" . (int)$product_id . "'"); // Dependent Options

		if (isset($data['product_option'])) {
		    // Dependent Options
		    $dependent_option = array();
		    $dependent_option_value = array();
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'radiocolor' || $product_option['type'] == 'radiolabel' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'checkboxcolor' || $product_option['type'] == 'checkboxlabel' || $product_option['type'] == 'image' || $product_option['type'] == 'custom_text') {
					$this->db->query("
						INSERT INTO 
							" . DB_PREFIX . "product_option 
						SET 
							product_option_id = '" . (int)$product_option['product_option_id'] . "', 
							product_id = '" . (int)$product_id . "', 
							option_id = '" . (int)$product_option['option_id'] . "', 
							required = '" . (int)$product_option['required'] . "'
					");

					$product_option_id = $this->db->getLastId();
					$dependent_option[$product_option['option_id']] = $product_option_id; // Dependent Options
					if (isset($product_option['product_option_value'])  && count($product_option['product_option_value']) > 0 ) {
						foreach ($product_option['product_option_value'] as $product_option_value) {
							if(!isset($product_option_value['product_option_image'])){
								$product_option_value['product_option_image'] = '';
							}
							$this->db->query("
								INSERT INTO 
									" . DB_PREFIX . "product_option_value 
								SET 
									product_option_value_id = '" . (int)$product_option_value['product_option_value_id'] . "', 
									product_option_id = '" . (int)$product_option_id . "', 
									product_id = '" . (int)$product_id . "', 
									option_id = '" . (int)$product_option['option_id'] . "', 
									option_value_id = '" . (int)$product_option_value['option_value_id'] . "', 
									quantity = '" . (int)$product_option_value['quantity'] . "', 
									subtract = '" . (int)$product_option_value['subtract'] . "', 
									price = '" . (float)$product_option_value['price'] . "', 
									price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', 
									points = '" . (int)$product_option_value['points'] . "', 
									points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', 
									weight = '" . (float)$product_option_value['weight'] . "', 
									weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "', 
									product_option_image = '" . $this->db->escape($product_option_value['product_option_image']) . "'
							");
							// Dependent Options
							$product_option_value_id = $this->db->getLastId();
							$dependent_option_value[$product_option_value['option_value_id']] = $product_option_value_id;
						}
					}else{
						$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_option_id = '".$product_option_id."'");
					}
				} else { 
					$this->db->query("
						INSERT INTO 
							" . DB_PREFIX . "product_option 
						SET 
							product_option_id = '" . (int)$product_option['product_option_id'] . "', 
							product_id = '" . (int)$product_id . "', 
							option_id = '" . (int)$product_option['option_id'] . "', 
							option_value = '" . $this->db->escape($product_option['option_value']) . "', 
							required = '" . (int)$product_option['required'] . "'
					");
				}					
			}
			// Dependent Options
			if (!empty($dependent_option)) {
			    foreach ($data['product_option'] as $product_option) {
			        if (isset($product_option['parent_option_id']) && !empty($product_option['parent_option_id'])) {
			            $this->db->query("
		            		INSERT INTO 
			            		`" . DB_PREFIX . "dependent_option` 
			            	SET 
			            		product_id = '" . (int)$product_id . "', 
			            		parent_option_id = '" . (int)$product_option['parent_option_id'] . "', 
			            		child_option_id = '" . (int)$product_option['option_id'] . "', 
			            		parent_product_option_id = '" . (int)$dependent_option[$product_option['parent_option_id']] . "', 
			            		child_product_option_id = '" . (int)$dependent_option[$product_option['option_id']] . "'
			            ");
			        }
			
			        if (isset($product_option['product_option_value'])) {
			            foreach ($product_option['product_option_value'] as $product_option_value) {
			                if (isset($product_option_value['parent_option_value']) && !empty($product_option_value['parent_option_value'])) {
			                    foreach ($product_option_value['parent_option_value'] as $parent_option_value_id) {
			                        $this->db->query("
			                        	INSERT INTO 
			                        		`" . DB_PREFIX . "dependent_option_value` 
			                        	SET 
			                        		product_id = '" . (int)$product_id . "', 
			                        		parent_option_id = '" . (int)$product_option['parent_option_id'] . "', 
			                        		child_option_id = '" . (int)$product_option['option_id'] . "', 
			                        		parent_option_value_id = '" . (int)$parent_option_value_id . "', 
			                        		child_option_value_id = '" . (int)$product_option_value['option_value_id'] . "', 
			                        		parent_product_option_value_id = '" . (int)$dependent_option_value[$parent_option_value_id] . "', 
			                        		child_product_option_value_id = '" . (int)$dependent_option_value[$product_option_value['option_value_id']] . "'
			                        ");
			                    }
			                }
			            }
			        }
			    }
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_image'])) {
			foreach ($data['product_image'] as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}		
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_filter'])) {
			foreach ($data['product_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int)$product_id . "', filter_id = '" . (int)$filter_id . "'");
			}		
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$value['points'] . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout) {
				if ($layout['layout_id']) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id. "'");

		if ($data['keyword']) {
		foreach ($data['keyword'] as $language_id => $keyword) {
				if ($keyword) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($keyword) . "', language_id = " . $language_id);
				}
			}
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_profile` WHERE product_id = " . (int)$product_id);
		if (isset($data['product_profiles'])) {
		    foreach ($data['product_profiles'] as $profile) {
		        $this->db->query("
		        	INSERT INTO 
		        		`" . DB_PREFIX . "product_profile` 
		        	SET 
		        		`product_id` = " . (int)$product_id . ", 
		        		customer_group_id = " . (int)$profile['customer_group_id'] . ", 
		        		`profile_id` = " . (int)$profile['profile_id']
		    	);
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
		else {
		    $parameters['keywords'] = '%c%p';
		    $parameters['tags'] = '%c%p';
		    $parameters['metas'] = '%p - %f';
		}
		
		
		if (isset($parameters['ext'])) { $ext = $parameters['ext'];}
		else {$ext = '';}
			
		if ((isset($parameters['autokeywords'])) && ($parameters['autokeywords']))
		{
		    $query = $this->db->query("select pd.name as pname, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand  from " . DB_PREFIX . "product_description pd
								left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
								inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
								left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
								left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
								where p.product_id = '" . (int)$product_id . "';");
		    	
		
		    //die('z');
		    foreach ($query->rows as $product) {
		
		        $bef = array("%", "_","\"","'","\\");
		        $aft = array("", " ", " ", " ", "");
		        	
		        $included = explode('%', str_replace(array(' ',','), '', $parameters['keywords']));
		        	
		        $tags = array();
		        	
		        if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
		        if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
		        if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
		        if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
		        if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
		        if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
		        	
		        $keywords = '';
		        	
		        foreach ($tags as $tag)
		        {
		            if (strlen($tag) > 2)
		            {
		                	
		                $keywords = $keywords.' '.strtolower($tag);
		                	
		            }
		        }
		
		        	
		        $exists = $this->db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_keyword like '%".$keywords."%';");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $count = $exist['times'];
		        }
		        $exists = $this->db->query("select length(meta_keyword) as leng from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $leng = $exist['leng'];
		        }
		
		        if (($count == 0) && ($leng < 255)) {$this->db->query("update " . DB_PREFIX . "product_description set meta_keyword = concat(meta_keyword, '". htmlspecialchars($keywords) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}
		
		
		    }
		}
		if ((isset($parameters['autometa'])) && ($parameters['autometa']))
		{
		    $query = $this->db->query("select pd.name as pname, p.price as price, cd.name as cname, pd.description as pdescription, pd.language_id as language_id, pd.product_id as product_id, p.model as model, p.sku as sku, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
								left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
								inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
								left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
								left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
								where p.product_id = '" . (int)$product_id . "';");
		
		    foreach ($query->rows as $product) {
		
		        $bef = array("%", "_","\"","'","\\", "\r", "\n");
		        $aft = array("", " ", " ", " ", "", "", "");
		        	
		        $ncategory = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))));
		        $nproduct = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))));
		        $model = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))));
		        $sku = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))));
		        $upc = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))));
		        $content = strip_tags(html_entity_decode($product['pdescription']));
		        $pos = strpos($content, '.');
		        if($pos === false) {}
		        else { $content =  substr($content, 0, $pos+1);	}
		        $sentence = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft, $content))));
		        $brand = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))));
		        $price = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft, number_format($product['price'], 2)))));
		        	
		        $bef = array("%c", "%p", "%m", "%s", "%u", "%f", "%b", "%$");
		        $aft = array($ncategory, $nproduct, $model, $sku, $upc, $sentence, $brand, $price);
		        	
		        $meta_description = str_replace($bef, $aft,  $parameters['metas']);
		        	
		        $exists = $this->db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_description not like '%".htmlspecialchars($meta_description)."%';");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $count = $exist['times'];
		        }
		        	
		        if ($count) {$this->db->query("update " . DB_PREFIX . "product_description set meta_description = concat(meta_description, '". htmlspecialchars($meta_description) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}
		
		    }
		}
		if ((isset($parameters['autotags'])) && ($parameters['autotags']))
		{
		    $query = $this->db->query("select pd.name as pname, pd.tag, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
							inner join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
							inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
							inner join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
							left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
							where p.product_id = '" . (int)$product_id . "';");
		    	
		    foreach ($query->rows as $product) {
		
		        $newtags ='';
		
		        $included = explode('%', str_replace(array(' ',','), '', $parameters['tags']));
		
		        $tags = array();
		
		
		        $bef = array("%", "_","\"","'","\\");
		        $aft = array("", " ", " ", " ", "");
		
		        if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
		        if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
		        if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
		        if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
		        if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
		        if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
		        	
		        foreach ($tags as $tag)
		        {
		            if (strlen($tag) > 2)
		            {
		                if ((strpos($product['tag'], strtolower($tag)) === false) && (strpos($newtags, strtolower($tag)) === false))
		                {
		                    $newtags .= ' '.strtolower($tag).',';
		                }
		            }
		        }
		        	
		
		        if ($product['tag']) {
		            $newtags = trim($this->db->escape($product['tag']) . $newtags,' ,');
		            $this->db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
		        }
		        else {
		            $newtags = trim($newtags,' ,');
		            $this->db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
		        }
		
		    }
		
		}
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT pd.product_id, pd.name, pd.language_id ,l.code FROM ".DB_PREFIX."product p
								inner join ".DB_PREFIX."product_description pd ON p.product_id = pd.product_id
								inner join ".DB_PREFIX."language l on l.language_id = pd.language_id
								where p.product_id = '" . (int)$product_id . "';");
		
		
		    foreach ($query->rows as $product_row ){
		
		        	
		        if( strlen($product_row['name']) > 1 ){
		            	
		            $slug = $seo->generateSlug($product_row['name']).$ext;
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'product_id=" . $product_row['product_id'] . "' and language_id=".$product_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'product_id=" . $product_row['product_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($product_row['name']).'-'.rand().$ext;
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($product_row['name']).'-'.$product_row['code'].$ext;
		                    }
		                }
		
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword, language_id) VALUES ('product_id=" . $product_row['product_id'] . "', '" . $slug . "', " . $product_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
// 		$this->linkOptionToFilter($product_id);
		$this->cache->delete('product');

		$this->eventEditProduct($product_id);
	}

	/*code start*/
	public function getPromoTags($data = array()) {
	    if ($data) {
	        $sql = "SELECT * FROM " . DB_PREFIX . "promo_tags";
	        	
	        $sort_data = array(
	                        'promo_text',
	                        'sort_order'
	        );
	        	
	        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
	            $sql .= " ORDER BY " . $data['sort'];
	        } else {
	            $sql .= " ORDER BY promo_tags_id";
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
	        $promotags_data = $this->cache->get('promotags');
	
	        if (!$promotags_data) {
	            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "promo_tags ORDER BY promo_tags_id");
	
	            $promotags_data = $query->rows;
	            	
	            $this->cache->set('promotags', $promotags_data);
	        }
	        	
	        return $promotags_data;
	    }
	}
	/*code end*/
	
	
	public function copyProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		if ($query->num_rows) {
			$data = array();

			$data = $query->row;

			$data['sku'] = '';
			$data['upc'] = '';
			$data['viewed'] = '0';
			$data['keyword'] = array();
			$data['status'] = '0';

			$data = array_merge($data, array('product_attribute' => $this->getProductAttributes($product_id)));
			$data = array_merge($data, array('product_description' => $this->getProductDescriptions($product_id)));			
			$data = array_merge($data, array('product_discount' => $this->getProductDiscounts($product_id)));
			$data = array_merge($data, array('product_filter' => $this->getProductFilters($product_id)));
			$data = array_merge($data, array('product_image' => $this->getProductImages($product_id)));		
			$data = array_merge($data, array('product_option' => $this->getProductOptions($product_id)));
			# Filter start
			$data = array_merge($data, array('product_to_value_id' => $this->getProductFilterValues($product_id)));
			# Filter end
			$data = array_merge($data, array('product_related' => $this->getProductRelated($product_id)));
			$data = array_merge($data, array('product_reward' => $this->getProductRewards($product_id)));
			$data = array_merge($data, array('product_special' => $this->getProductSpecials($product_id)));
			$data = array_merge($data, array('product_category' => $this->getProductCategories($product_id)));
			$data = array_merge($data, array('product_download' => $this->getProductDownloads($product_id)));
			$data = array_merge($data, array('product_layout' => $this->getProductLayouts($product_id)));
			$data = array_merge($data, array('product_store' => $this->getProductStores($product_id)));
			$data = array_merge($data, array('product_profiles' => $this->getProfiles($product_id)));
			$this->addProduct($data);
		}
	}

	public function deleteProduct($product_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
		# Filter start
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_value WHERE product_id = '" . (int)$product_id . "'");
		# Filter end
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "dependent_option WHERE product_id = '" . (int)$product_id . "'"); // Dependent Options
		$this->db->query("DELETE FROM " . DB_PREFIX . "dependent_option_value WHERE product_id = '" . (int)$product_id . "'"); // Dependent Options
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_profile` WHERE `product_id` = " . (int)$product_id);
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id. "'");

		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seopack'");
			
		foreach ($query->rows as $result) {
		    if (!$result['serialized']) {
		        $data[$result['key']] = $result['value'];
		    } else {
		        $data[$result['key']] = unserialize($result['value']);
		    }
		}
			
		if (isset($data)) {$parameters = $data['parameters'];}
		else {
		    $parameters['keywords'] = '%c%p';
		    $parameters['tags'] = '%c%p';
		    $parameters['metas'] = '%p - %f';
		}
		
		
		if (isset($parameters['ext'])) { $ext = $parameters['ext'];}
		else {$ext = '';}
			
		if ((isset($parameters['autokeywords'])) && ($parameters['autokeywords']))
		{
		    $query = $this->db->query("select pd.name as pname, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand  from " . DB_PREFIX . "product_description pd
								left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
								inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
								left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
								left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
								where p.product_id = '" . (int)$product_id . "';");
		    	
		
		    //die('z');
		    foreach ($query->rows as $product) {
		
		        $bef = array("%", "_","\"","'","\\");
		        $aft = array("", " ", " ", " ", "");
		        	
		        $included = explode('%', str_replace(array(' ',','), '', $parameters['keywords']));
		        	
		        $tags = array();
		        	
		        if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
		        if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
		        if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
		        if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
		        if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
		        if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
		        	
		        $keywords = '';
		        	
		        foreach ($tags as $tag)
		        {
		            if (strlen($tag) > 2)
		            {
		                	
		                $keywords = $keywords.' '.strtolower($tag);
		                	
		            }
		        }
		
		        	
		        $exists = $this->db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_keyword like '%".$keywords."%';");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $count = $exist['times'];
		        }
		        $exists = $this->db->query("select length(meta_keyword) as leng from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $leng = $exist['leng'];
		        }
		
		        if (($count == 0) && ($leng < 255)) {$this->db->query("update " . DB_PREFIX . "product_description set meta_keyword = concat(meta_keyword, '". htmlspecialchars($keywords) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}
		
		
		    }
		}
		if ((isset($parameters['autometa'])) && ($parameters['autometa']))
		{
		    $query = $this->db->query("select pd.name as pname, p.price as price, cd.name as cname, pd.description as pdescription, pd.language_id as language_id, pd.product_id as product_id, p.model as model, p.sku as sku, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
								left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
								inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
								left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
								left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
								where p.product_id = '" . (int)$product_id . "';");
		
		    foreach ($query->rows as $product) {
		
		        $bef = array("%", "_","\"","'","\\", "\r", "\n");
		        $aft = array("", " ", " ", " ", "", "", "");
		        	
		        $ncategory = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))));
		        $nproduct = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))));
		        $model = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))));
		        $sku = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))));
		        $upc = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))));
		        $content = strip_tags(html_entity_decode($product['pdescription']));
		        $pos = strpos($content, '.');
		        if($pos === false) {}
		        else { $content =  substr($content, 0, $pos+1);	}
		        $sentence = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft, $content))));
		        $brand = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))));
		        $price = trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft, number_format($product['price'], 2)))));
		        	
		        $bef = array("%c", "%p", "%m", "%s", "%u", "%f", "%b", "%$");
		        $aft = array($ncategory, $nproduct, $model, $sku, $upc, $sentence, $brand, $price);
		        	
		        $meta_description = str_replace($bef, $aft,  $parameters['metas']);
		        	
		        $exists = $this->db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_description not like '%".htmlspecialchars($meta_description)."%';");
		        	
		        foreach ($exists->rows as $exist)
		        {
		            $count = $exist['times'];
		        }
		        	
		        if ($count) {$this->db->query("update " . DB_PREFIX . "product_description set meta_description = concat(meta_description, '". htmlspecialchars($meta_description) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}
		
		    }
		}
		if ((isset($parameters['autotags'])) && ($parameters['autotags']))
		{
		    $query = $this->db->query("select pd.name as pname, pd.tag, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
							inner join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
							inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
							inner join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
							left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id
							where p.product_id = '" . (int)$product_id . "';");
		    	
		    foreach ($query->rows as $product) {
		
		        $newtags ='';
		
		        $included = explode('%', str_replace(array(' ',','), '', $parameters['tags']));
		
		        $tags = array();
		
		
		        $bef = array("%", "_","\"","'","\\");
		        $aft = array("", " ", " ", " ", "");
		
		        if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
		        if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
		        if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
		        if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
		        if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
		        if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim($this->db->escape(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
		        	
		        foreach ($tags as $tag)
		        {
		            if (strlen($tag) > 2)
		            {
		                if ((strpos($product['tag'], strtolower($tag)) === false) && (strpos($newtags, strtolower($tag)) === false))
		                {
		                    $newtags .= ' '.strtolower($tag).',';
		                }
		            }
		        }
		        	
		
		        if ($product['tag']) {
		            $newtags = trim($this->db->escape($product['tag']) . $newtags,' ,');
		            $this->db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
		        }
		        else {
		            $newtags = trim($newtags,' ,');
		            $this->db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
		        }
		
		    }
		
		}
		if ((isset($parameters['autourls'])) && ($parameters['autourls']))
		{
		    require_once(DIR_APPLICATION . 'controller/catalog/seopack.php');
		    $seo = new ControllerCatalogSeoPack($this->registry);
		
		    $query = $this->db->query("SELECT pd.product_id, pd.name, pd.language_id ,l.code FROM ".DB_PREFIX."product p
								inner join ".DB_PREFIX."product_description pd ON p.product_id = pd.product_id
								inner join ".DB_PREFIX."language l on l.language_id = pd.language_id
								where p.product_id = '" . (int)$product_id . "';");
		
		
		    foreach ($query->rows as $product_row ){
		
		        	
		        if( strlen($product_row['name']) > 1 ){
		            	
		            $slug = $seo->generateSlug($product_row['name']).$ext;
		            $exist_query = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.query = 'product_id=" . $product_row['product_id'] . "' and language_id=".$product_row['language_id']);
		
		            if(!$exist_query->num_rows){
		                	
		                $exist_keyword = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "'");
		                if($exist_keyword->num_rows){
		                    $exist_keyword_lang = $this->db->query("SELECT query FROM " . DB_PREFIX . "url_alias WHERE " . DB_PREFIX . "url_alias.keyword = '" . $slug . "' AND " . DB_PREFIX . "url_alias.query <> 'product_id=" . $product_row['product_id'] . "'");
		                    if($exist_keyword_lang->num_rows){
		                        $slug = $seo->generateSlug($product_row['name']).'-'.rand().$ext;
		                    }
		                    else
		                    {
		                        $slug = $seo->generateSlug($product_row['name']).'-'.$product_row['code'].$ext;
		                    }
		                }
		
		                	
		                $add_query = "INSERT INTO " . DB_PREFIX . "url_alias (query, keyword, language_id) VALUES ('product_id=" . $product_row['product_id'] . "', '" . $slug . "', " . $product_row['language_id'] . ")";
		                $this->db->query($add_query);
		                	
		            }
		        }
		    }
		}
		
		
		$this->cache->delete('product');

		$this->eventEditProduct($product_id);
	}
	
	public function getKeyWords($product_id) {
	    $keywords = array();
	
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");
	
	    foreach ($query->rows as $result) {
	        $keywords[$result['language_id']] = $result['keyword'];
	    }
	
	    return $keywords;
	}

	public function getProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getProducts($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

		if (!empty($data['filter_category_id'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";			
		}

		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 

		if (!empty($data['filter_by_id'])) {
			$sql .= " AND p.product_id = " . (int)$data['filter_by_id'];
		}
		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (!empty($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && $data['filter_quantity'] != '') {
			$sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
		}

		if (isset($data['filter_status']) && $data['filter_status'] != '') {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}
		
		if (isset($data['filter_date_added']) && $data['filter_date_added'] != '') {
			$sql .= " AND p.date_added LIKE '" . $this->db->escape($data['filter_date_added']) . "%'";
		}
		/* Apply filter by category */
		if (!empty($data['filter_category_id'])) {
		    $sql .= ' And p2c.category_id = ' . (int)$data['filter_category_id'];
		}
		/* Apply filter by category */
		$sql .= " GROUP BY p.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'p.price',
			'p.quantity',
			'p.status',
			'p.sort_order',
            'p.product_id'
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
	}

	public function getProductsByCategoryId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2c.category_id = '" . (int)$category_id . "' ORDER BY pd.name ASC");

		return $query->rows;
	} 

	public function getProductDescriptions($product_id) {
		$product_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_description_data[$result['language_id']] = array(
				'name'              => $result['name'],
				'description'       => $result['description'],
				'short_description' => $result['short_description'],
				'meta_keyword'      => $result['meta_keyword'],
				'custom_title'      => $result['custom_title'], 
                'custom_h1'         => $result['custom_h1'],
                'custom_alt'        => $result['custom_alt'],
                'meta_description'  => $result['meta_description'],
				'tag'               => $result['tag']
			);
		}

		return $product_description_data;
	}

	public function getProductCategories($product_id) {
		$product_category_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_category_data[] = $result['category_id'];
		}

		return $product_category_data;
	}
	
	# Filter start
	private function getProductFilterValues($product_id) {
	    $product_filter_value_data = array();
	
	    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_value WHERE product_id = '" . (int)$product_id . "'");
	
	    foreach ($query->rows as $result) {
	        $product_filter_value_data[$result['option_id']]['values'][] = $result['value_id'];
	    }
	
	    return $product_filter_value_data;
	}
	# Filter end
	public function getProductFilters($product_id) {
		$product_filter_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_filter_data[] = $result['filter_id'];
		}

		return $product_filter_data;
	}

	public function getProductAttributes($product_id) {
		$product_attribute_data = array();

		$product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' GROUP BY attribute_id");

		foreach ($product_attribute_query->rows as $product_attribute) {
			$product_attribute_description_data = array();

			$product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");

			foreach ($product_attribute_description_query->rows as $product_attribute_description) {
				$product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
			}

			$product_attribute_data[] = array(
				'attribute_id'                  => $product_attribute['attribute_id'],
				'product_attribute_description' => $product_attribute_description_data
			);
		}

		return $product_attribute_data;
	}

	public function getProductOptions($product_id) {
	    $this->checkDependentOptionDb();
	    $this->checkDependentOptionValueDb();
		$product_option_data = array();

		$product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option` po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		foreach ($product_option_query->rows as $product_option) {
			$product_option_value_data = array();	

			$product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int)$product_option['product_option_id'] . "'");

			foreach ($product_option_value_query->rows as $product_option_value) {
			    $parent_option_value_data = $this->getParentOptionValues($product_id, $product_option_value['product_option_value_id']); // Dependent Options
				$product_option_value_data[] = array(
					'product_option_value_id' => $product_option_value['product_option_value_id'],
					'option_value_id'         => $product_option_value['option_value_id'],
					'quantity'                => $product_option_value['quantity'],
					'subtract'                => $product_option_value['subtract'],
					'price'                   => $product_option_value['price'],
					'price_prefix'            => $product_option_value['price_prefix'],
					'points'                  => $product_option_value['points'],
					'points_prefix'           => $product_option_value['points_prefix'],
	                'parent_option_value'     => $parent_option_value_data, // Dependent Options
					'weight'                  => $product_option_value['weight'],
					'weight_prefix'           => $product_option_value['weight_prefix'],
					'product_option_image'	  => $product_option_value['product_option_image']
				);
			}

			$parent_option_id = $this->getParentOption($product_id, $product_option['product_option_id']); // Dependent Options
			
			$product_option_data[] = array(
				'product_option_id'    => $product_option['product_option_id'],
				'option_id'            => $product_option['option_id'],
				'name'                 => $product_option['name'],
				'product_page'         => isset($product_option['product_page']) ? ((int)$product_option['product_page']) : '',
				'type'                 => $product_option['type'],			
				'product_option_value' => $product_option_value_data,
                'parent_option_id'     => $parent_option_id, // Dependent Options
				'option_value'         => $product_option['option_value'],
				'required'             => $product_option['required']				
			);
		}

		return $product_option_data;
	}

	// Dependent Options
	private function checkDependentOptionDb() {
	    $query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "dependent_option'");
	
	    if (!$query->rows) {
	        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "dependent_option` (
								`product_id` int(11) NOT NULL,
								`parent_option_id` int(11) NOT NULL,
								`child_option_id` int(11) NOT NULL,
								`parent_product_option_id` int(11) NOT NULL,
								`child_product_option_id` int(11) NOT NULL,
								KEY `product_id` (`product_id`),
								KEY `child_product_option_id` (`child_product_option_id`))
								ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
	    }
	}
	
	private function checkDependentOptionValueDb() {
	    $query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "dependent_option_value'");
	
	    if (!$query->rows) {
	        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "dependent_option_value` (
								`product_id` int(11) NOT NULL,
								`parent_option_id` int(11) NOT NULL,
								`child_option_id` int(11) NOT NULL,
								`parent_option_value_id` int(11) NOT NULL,
								`child_option_value_id` int(11) NOT NULL,
								`parent_product_option_value_id` int(11) NOT NULL,
								`child_product_option_value_id` int(11) NOT NULL,
								KEY `product_id` (`product_id`),
								KEY `parent_option_id` (`parent_option_id`))
								ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
	    }
	}
	
	public function getParentOption($product_id, $product_option_id) {
	    $this->checkDependentOptionDb();
	
	    $query = $this->db->query("SELECT parent_option_id FROM `" . DB_PREFIX . "dependent_option` WHERE product_id = '" . (int)$product_id . "' AND child_product_option_id = '" . (int)$product_option_id . "'");
	
	    if ($query->rows) {
	        return $query->row['parent_option_id'];
	    } else {
	        return '';
	    }
	}
	
	public function getParentOptionValues($product_id, $product_option_value_id) {
	    $this->checkDependentOptionValueDb();
	
	    $parent_option_values = array();
	
	    $query = $this->db->query("SELECT parent_option_value_id FROM `" . DB_PREFIX . "dependent_option_value` WHERE product_id = '" . (int)$product_id . "' AND child_product_option_value_id = '" . (int)$product_option_value_id . "'");
	
	    if ($query->rows) {
	        foreach ($query->rows as $result) {
	            $parent_option_values[] = $result['parent_option_value_id'];
	        }
	    }
	
	    return $parent_option_values;
	}
	
	public function getProductImages($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");

		return $query->rows;
	}

	public function getProductDiscounts($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' ORDER BY quantity, priority, price");

		return $query->rows;
	}

	public function getProductSpecials($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' ORDER BY priority, price");
		$data = array();
		foreach ($query->rows as $row) {
			if($row['date_end'] == '0000-00-00 00:00:00') {
				$row['date_end'] = '';
			} else {
				$row['date_end'] = $row['date_end'];
			}
			if($row['date_end'] == '0000-00-00 00:00:00') {
				$row['date_end'] = '';
			} else {
				$row['date_end'] = $row['date_end'];
			}
			
			$data[] = $row;
		}

		return $data;
	}

	public function getProductRewards($product_id) {
		$product_reward_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_reward_data[$result['customer_group_id']] = array('points' => $result['points']);
		}

		return $product_reward_data;
	}

	public function getProductDownloads($product_id) {
		$product_download_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_download_data[] = $result['download_id'];
		}

		return $product_download_data;
	}

	public function getProductStores($product_id) {
		$product_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_store_data[] = $result['store_id'];
		}

		return $product_store_data;
	}

	public function getProductLayouts($product_id) {
		$product_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $product_layout_data;
	}

	public function getProductRelated($product_id) {
		$product_related_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_related_data[] = $result['related_id'];
		}

		return $product_related_data;
	}

	public function getProfiles($product_id) {
		return $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_profile` WHERE product_id = " . (int)$product_id)->rows;
	}

	public function getTotalProducts($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

		if (!empty($data['filter_category_id'])) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";			
		}
		
		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}
		if (!empty($data['filter_by_id'])) {
		    $sql .= " AND p.product_id = " . (int)$data['filter_by_id'];
		}
		
		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (!empty($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}
		
		if (isset($data['filter_date_added']) && !is_null($data['filter_date_added'])) {
			$sql .= " AND p.date_added LIKE '" . $this->db->escape($data['filter_date_added']) . "%'";
		}
		
		/* Apply additional filter by category */
		if (!empty($data['filter_category_id'])) {
		    $sql .= ' And p2c.category_id = ' . (int)$data['filter_category_id'];
		}
		/* Apply additional filter by category */
		$query = $this->db->query($sql);

		return $query->row['total'];
	}	

	public function getTotalProductsByTaxClassId($tax_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE tax_class_id = '" . (int)$tax_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByStockStatusId($stock_status_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE stock_status_id = '" . (int)$stock_status_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByWeightClassId($weight_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE weight_class_id = '" . (int)$weight_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByLengthClassId($length_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE length_class_id = '" . (int)$length_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByDownloadId($download_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_download WHERE download_id = '" . (int)$download_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByManufacturerId($manufacturer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByAttributeId($attribute_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = '" . (int)$attribute_id . "'");

		return $query->row['total'];
	}	

	public function getTotalProductsByOptionId($option_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_option WHERE option_id = '" . (int)$option_id . "'");

		return $query->row['total'];
	}	

	public function getTotalProductsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
	
	public function fastUpdate($field, $product_id, $field_value) {
	    switch ($field) {
	        case 'product_name':
	            $sql = "Update " . DB_PREFIX . "product_description Set name = '{$this->db->escape($field_value)}' Where product_id = " . (int)$product_id . " And language_id = " . (int)$this->config->get('config_language_id');
	            break;
	        case 'product_model':
	            $sql = "Update " . DB_PREFIX . "product Set model = '{$this->db->escape($field_value)}' Where product_id = " . (int)$product_id;
	            break;
	        case 'product_price':
	            $sql = "Update " . DB_PREFIX . "product Set price = {$this->db->escape($field_value)} Where product_id = " . (int)$product_id;
	            break;
	        case 'product_special':
	            $sql = "Update " . DB_PREFIX . "product_special Set price = '{$this->db->escape($field_value)}' Where product_id = " . (int)$product_id;
	            break;
	        case 'product_quantity':
	            $sql = "Update " . DB_PREFIX . "product Set quantity = " . (int)$this->db->escape($field_value) . " Where product_id = " . (int)$product_id;
	            break;
	        case 'product_status':
	            $sql = "Update " . DB_PREFIX . "product Set status = " . (int)$this->db->escape($field_value) . " Where product_id = " . (int)$product_id;
	            break;
	        default:
	            $sql = false;
	            break;
        }
        
        $this->db->query($sql);
        return (bool)$this->db->countAffected();
	}
	
	public function updateImage($product_id, $image) {
	    
	    $sql = "Select * From " . DB_PREFIX . "product_image Where product_id = " . (int)$product_id . " And image = '" . $this->db->escape($image) . "'";
	    $images = $this->db->query($sql);
	    
	    if(!$images->num_rows) {
	        $sql = "Insert into " . DB_PREFIX . "product_image Set product_id = '" . (int)$product_id ."', image = '" . $this->db->escape($image) . "', sort_order = 0";
	        $this->db->query($sql);
	    }
	    $sql = "Update " . DB_PREFIX . "product Set image = '" . $this->db->escape($image) . "' Where product_id = " . (int)$product_id;
	    $this->db->query($sql);
	    
	    return (bool)$this->db->countAffected();
	}
	
	public function linkProductCategory($product_id, $category_id) {
	    $sql = "Insert Into " . DB_PREFIX . "product_to_category Set product_id = " . (int)$product_id . ", category_id = " . (int)$category_id;
	    $this->db->query($sql);

		$this->eventEditProduct($product_id);
	    return (bool)$this->db->countAffected();
	}
	
	public function unlinkProductCategory($product_id, $category_id) {
	    $sql = "Delete From " . DB_PREFIX . "product_to_category Where product_id = " . (int)$product_id . " And category_id = " . (int)$category_id;
	    $this->db->query($sql);
	    return true;
	}
	
	private function linkOptionToFilter($product_id) {
	    
// 	    $this->load->model('localisation/language');
// 	    $this->load->model('catalog/filter');
	    
// 	    $languages = $this->model_localisation_language->getLanguages();
	    
// 	    foreach ($languages as $language) {
//     	    $sql = "
//                 Select * From " . DB_PREFIX . "product_option_value as pov 
//                 Left Join " . DB_PREFIX . "product_option po On (pov.product_option_id = po.product_option_id)
//                 Left Join " . DB_PREFIX . "option o On (o.option_id = po.option_id)
//                 Left Join " . DB_PREFIX . "option_description od On (od.option_id = po.option_id)
//                 Left Join " . DB_PREFIX . "option_value ov On (ov.option_value_id = pov.option_value_id)
//                 Left Join " . DB_PREFIX . "option_value_description ovd On (ovd.option_value_id = pov.option_value_id)
//                 Where pov.product_id = 48 And ovd.language_id = {$language['language_id']}        
//             ";
//     	    $product_option_values = $this->db->query($sql);
//     	    if($product_option_values->num_rows) {
//     	        foreach ($product_option_values->rows as $product_option_value) {
//     	            print '<pre>';
//     	            print_r($product_option_value);
//     	            print '</pre>';
//     	            die;
//     	        } 
//     	    }
// 	    }
	}
}
?>

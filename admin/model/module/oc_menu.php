<?php 
class ModelModuleOcmenu extends Model {
	
	public function getGroup($group_id, $parent_id = 0) {
		$sql = "
			Select 
				m.menu_id,
				m.parent_id,
				m.type_id,
				m.group_id,
				m.sort_order,
				md.name as name,
				md.description,
				mt.icon as type_icon,
				mt.type_key,
				mtd.name as type_name
			From
				" . DB_PREFIX . "menu m
			Left Join
				" . DB_PREFIX . "menu_description md
			On
				(
					m.menu_id = md.menu_id 
					And 
					md.language_id = " . $this->config->get('config_language_id') . "
				)
			Left Join
				" . DB_PREFIX . "menu_type mt
			On 
				(m.type_id = mt.type_id)
			Left Join
				" . DB_PREFIX . "menu_type_description mtd
			On
				(
					mtd.type_id = mt.type_id
					And 
					mtd.language_id = " . $this->config->get('config_language_id') . "
				)
			Where 
				m.group_id = " . (int)$group_id . "
			And
				parent_id = " . (int)$parent_id . "
			Order by 
				m.sort_order ASC
		";
		$group = $this->db->query($sql);
		
		return $group->rows;
	}
	
	public function getNodeInfo($node_id) {
		$node_info = array();
		$sql = "
			Select 
				* 
			From
				" . DB_PREFIX . "menu
			Where 
				menu_id = " . (int)$node_id . "
		";
		$node = $this->db->query($sql);
		
		if($node->num_rows) {
			$node_info = $node->row;
			$node_info['columns'] = $this->getNodeColumns($node_id);
			$node_info['descriptions'] = $this->getNodeDescriptions($node_id);
			$node_info['properties'] = $this->getNodeProperties($node_id);
		}
		
		return $node_info;
	}
	
	public function getNodeColumns($node_id) {
		$sql = "
			Select 
				* 
			From
				" . DB_PREFIX . "menu_column 
			Where 
				menu_id = " . (int)$node_id . "
		";
		$columns = $this->db->query($sql);
		
		return $columns->rows;
	}
	
	public function getNodeDescriptions($node_id, $language_id = false) {
		$sql = "
			Select 
				* 
			From
				" . DB_PREFIX . "menu_description 
			Where 
				menu_id = " . (int)$node_id . "
		";
		if($language_id) {
			$sql .= "
				And language_id = " . (int)$language_id . "
			";
		}
		
		$descriptions = $this->db->query($sql);
		if($descriptions->num_rows) {
			return ($language_id ? $descriptions->row : $descriptions->rows);
		} else {
			return array();
		}
	}
	
	public function getNodeProperties($node_id) {
		$data = array();
		$sql = "
			Select 
				mp.menu_id,
				mp.property_id,
				mp.value,
				mtp.name,
				mtp.type_id,
				mt.type_key
			From
				" . DB_PREFIX . "menu_property as mp
			Left Join
				" . DB_PREFIX . "menu_type_property as mtp
			On
				(mtp.type_property_id = mp.property_id)
			Left Join
				" . DB_PREFIX . "menu_type as mt
			On
				(mtp.type_id = mt.type_id)
			Where 
				mp.menu_id = " . (int)$node_id . "
		";
		$properties = $this->db->query($sql);
		$i = 0;
		foreach ($properties->rows as $prop) {
			switch ($prop['type_key']) {
				case 'category':
					$value_name = $this->getPath($prop['value']);
					break;
				case 'information':
					$sql = "
						Select
							title as name
						From
							" . DB_PREFIX . "information_description
						Where
							information_id = " . (int)$prop['value'] . "
						And
							language_id = " . (int)$this->config->get('config_language_id') . "
					";
					$information = $this->db->query($sql);
					if($information->num_rows) {
						$value_name = $information->row['name'];
					} else {
						$value_name = '';
					}
					break;
				case 'blog_category':
					$sql = "
						Select
							title as name
						From
							" . DB_PREFIX . "pavblog_category_description
						Where
							category_id = " . (int)$prop['value'] . "
						And
							language_id = " . (int)$this->config->get('config_language_id') . "
					";
					$pav = $this->db->query($sql);
					if($pav->num_rows) {
						$value_name = $pav->row['name'];
					} else {
						$value_name = '';
					}
					break;
				case 'category_list':
					$value_name = $this->getPath($prop['value']);
					break;
				case 'gallery':
					$sql = "
						Select
							name
						From
							po_gallery_album_description
						Where
							album_id = " . (int)$prop['value'] . "
						And
							language_id = " . (int)$this->config->get('config_language_id') . "
					";
					$album = $this->db->query($sql);
					if($album->num_rows) {
						$value_name = $album->row['name'];
					} else {
						$value_name = '';
					}
					break;
				case 'products_list':
					$products = explode(',', $prop['value']);
					$value_name = array();
					foreach ($products as $product_id) {
						$sql = "
							Select 
								name 
							From 
								" . DB_PREFIX . "product_description
							Where
								product_id = " . (int)$product_id . "
							And
								language_id = " . (int)$this->config->get('config_language_id') . "
						";
						$product_name = $this->db->query($sql);
						if($product_name->num_rows) {
							$value_name[] = $product_name->row['name'];
						} else {
							$value_name[] = '';
						}
					}
					break;
				default:
					$value_name = '';
					break;
			}
			$data[$i] = $prop;
			$data[$i]['value_name'] = $value_name;
			$i++;
		}
			
		return $data;
	}
	
	public function getPath($category_id) {
		$query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
	
		if (!empty($query->row['parent_id'])) {
			return $this->getPath($query->row['parent_id'], $this->config->get('config_language_id')) . ' / ' . $query->row['name'];
		} else {
			if(!empty($query->row['name'])) {
				return $query->row['name'];
			} else {
				return '';
			}
		}
	}
	
	public function getTypes() {
		$types_data = array();
		$sql = "
			Select
				t.type_id,
				t.icon,
				t.type_key,
				td.name
			From
				" . DB_PREFIX . "menu_type t
			Left Join
				" . DB_PREFIX . "menu_type_description td
			On
				(td.type_id = t.type_id)		
			Where 
				td.language_id = " . (int)$this->config->get('config_language_id') . "
		";
		
		$types = $this->db->query($sql);
		$ti = 0;
		foreach ($types->rows as $type) {
			$types_data[$ti] = $type;
			$types_data[$ti]['properties'] = $this->getTypeProperties($type['type_id']);
			$ti++;
		}
		
		return $types_data;
	}
	
	public function getTypeProperties($type_id) {
		$sql = "
			Select
				tp.type_property_id as property_id,
				tp.name as property_key,
				tpd.name as name
			From
				" . DB_PREFIX . "menu_type_property as tp
			Left Join
				" . DB_PREFIX . "menu_type_property_description as tpd
			On
				(tp.type_property_id = tpd.type_property_id)
			Where 
				tp.type_id = " . (int)$type_id . "
			And
				tpd.language_id = " . (int)$this->config->get('config_language_id') . "
		";
		$properties = $this->db->query($sql);
		
		return $properties->rows;
	}
	
	public function getCategoryPath($category_id) {
		$query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");
	
		if ($query->row['parent_id']) {
			return $this->getCategoryPath($query->row['parent_id'], $this->config->get('config_language_id')) . $this->language->get('text_separator') . $query->row['name'];
		} else {
			return $query->row['name'];
		}
	}

    public function getACCategories($name) {
        $this->load->model('catalog/category');
        $sql = "
			Select
				cd.category_id
			From
				" . DB_PREFIX . "category_description cd
			Where
				LOWER(cd.name) LIKE ('%" . utf8_strtolower($this->db->escape($name)) . "%')
			And
				cd.language_id = " . (int)$this->config->get('config_language_id') . "
		";

        $rows = $this->db->query($sql);
        $result = array();
        foreach ($rows->rows as $row) {
            $category = $this->model_catalog_category->getCategory($row['category_id']);
            if(!empty($category)) {
                $result[] = array(
                    'category_id' => $row['category_id'],
                    'name'        => $this->getCategoryPath($row['category_id']),
                );
            }
        }
        return $result;
    }
	
	public function getACInformations($name) {
		$sql = "
			Select
				information_id,
				title as name
			From
				" . DB_PREFIX . "information_description
			Where
				language_id = " . (int)$this->config->get('config_language_id') . "
			And 
				LOWER(title) LIKE ('%" . utf8_strtolower($this->db->escape($name)) . "%') 
		";
		
		$rows = $this->db->query($sql);
		
		return $rows->rows;
	}
	
	public function getACBlogs($name) {
		$sql = "
			Select 
				category_id as blog_category_id,
				title as name
			From
				" . DB_PREFIX . "pavblog_category_description
			Where
				language_id = " . (int)$this->config->get('config_language_id') . "
			And
				LOWER(title) LIKE ('%" . utf8_strtolower($this->db->escape($name)) . "%')
		";
		
		$rows = $this->db->query($sql);
		
		return $rows->rows;
	}
	
	public function getACGalleries($name) {
		$sql = "
			Select 
				album_id as gallery_category_id,
				name
			From
				po_gallery_album_description
			Where
				language_id = " . (int)$this->config->get('config_language_id') . "
			And
				LOWER(name) LIKE ('%" . utf8_strtolower($this->db->escape($name)) . "%')
		";
		
		$rows = $this->db->query($sql);
		
		return $rows->rows;
	}
	
	public function getACProducts($name) {
		$sql = "
			Select 
				p.product_id,
				pd.name
			From
				" . DB_PREFIX . "product p
			Left Join
				" . DB_PREFIX . "product_description pd
			On
				(p.product_id = pd.product_id)
			Where 
				LOWER(pd.name) LIKE ('%" . utf8_strtolower($this->db->escape($name)) . "%')
			And 
				pd.language_id = " . (int)$this->config->get('config_language_id') . "
		";
		$rows = $this->db->query($sql);
		
		return $rows->rows;
	}
	
	public function getMenuTypes() {
		$sql = "
			Select 
				mt.type_id,
				mt.type_key,
				mt.icon,
				mtd.name
			From
				" . DB_PREFIX . "menu_type as mt
			Left Join
				" . DB_PREFIX . "menu_type_description mtd
			On 
				(mtd.type_id = mt.type_id)
			Where
				mtd.language_id = " . (int)$this->config->get('config_language_id') . "
		";
		$types = $this->db->query($sql);
		
		return $types->rows;
	}
	
	public function getTypePropertyId($prop, $type_key) {
		
		$sql = "
			Select 
				type_property_id as id
			From
				" . DB_PREFIX . "menu_type_property mtp
			Left Join
				" . DB_PREFIX . "menu_type mt
			On
				(mt.type_id = mtp.type_id)
			Where
				mtp.name = '" . $this->db->escape($prop) . "'
			And
				mt.type_key = '" . $this->db->escape($type_key) . "'
		";
		$prop = $this->db->query($sql);
		
		if($prop->num_rows) {
			return $prop->row['id'];
		}
	}
	
	private function getElementNameByType($element, $language_id) {
		if(!empty($element['type_key'])) {
			switch ($element['type_key']) {
				case 'category':
					$category_id = 0;
					if(!empty($element['properties'])) {
						foreach ($element['properties'] as $property) {
							if($property['name'] == 'category_id') {
								$category_id =  $property['value'];
							}
						}
					}
					if($category_id) {
						$sql = "
							Select 
								cd.name
							From 
								" . DB_PREFIX . "category c
							Left Join
								" . DB_PREFIX . "category_description cd
							On 
								(cd.category_id = c.category_id)
							Where
								c.category_id = " . (int)$category_id . "
							And
								cd.language_id = " . (int)$language_id . "
						";
						$result = $this->db->query($sql);
						
						if($result->num_rows) {
							return $result->row['name'];
						}
					}
					
					return '';
					break;
				case 'information':
					$information_id = 0;
					if(!empty($element['properties'])) {
						foreach ($element['properties'] as $property) {
							if($property['name'] == 'information_id') {
								$information_id =  $property['value'];
							}
						}
					}
					if($information_id) {
						$sql = "
							Select 
								id.title as name
							From
								" . DB_PREFIX . "information i
							Left Join
								" . DB_PREFIX . "information_description id
							On 
								(id.information_id = i.information_id)
							Where
								i.information_id = " . (int)$information_id . "
							And
								id.language_id = " . (int)$language_id . "
						";
						$result = $this->db->query($sql);
						
						if($result->num_rows) {
							return $result->row['name'];
						}
					}
					break;
				case 'blog_category':
					$blog_id = 0;
					if(!empty($element['properties'])) {
						foreach ($element['properties'] as $property) {
							if($property['name'] == 'blog_category_id') {
								$blog_id =  $property['value'];
							}
						}
					}
					if($blog_id) {
						$sql = "
							Select 
								pd.title as name
							From
								" . DB_PREFIX . "pavblog_category p
							Left Join
								" . DB_PREFIX . "pavblog_category_description pd
							On 
								(pd.category_id = p.category_id)
							Where
								p.category_id = " . (int)$blog_id . "
							And
								pd.language_id = " . (int)$language_id . "
						";
						$result = $this->db->query($sql);
						
						if($result->num_rows) {
							return $result->row['name'];
						}
					}
					break;
				case 'gallery':
					$album_id = 0;
					if(!empty($element['properties'])) {
						foreach ($element['properties'] as $property) {
							if($property['name'] == 'gallery_id') {
								$album_id =  $property['value'];
							}
						}
					}
					if($album_id) {
						$sql = "
							Select 
								gd.name
							From
								po_gallery_album g
							Left Join
								po_gallery_album_description gd
							On 
								(gd.album_id = g.album_id)
							Where
								g.album_id = " . (int)$album_id . "
							And
								gd.language_id = " . (int)$language_id . "
						";
						$result = $this->db->query($sql);
						
						if($result->num_rows) {
							return $result->row['name'];
						}
					}
					break;
				case 'category_list':
					$category_id = 0;
					if(!empty($element['properties'])) {
						foreach ($element['properties'] as $property) {
							if($property['name'] == 'root_category_id') {
								$category_id =  $property['value'];
							}
						}
					}
					if($category_id) {
						$sql = "
							Select 
								cd.name
							From 
								" . DB_PREFIX . "category c
							Left Join
								" . DB_PREFIX . "category_description cd
							On 
								(cd.category_id = c.category_id)
							Where
								c.category_id = " . (int)$category_id . "
							And
								cd.language_id = " . (int)$language_id . "
						";
						$result = $this->db->query($sql);
						
						if($result->num_rows) {
							return $result->row['name'];
						}
					}
					
					return '';
					break;
				default:
					break;
			}
		}
		return '';
		
	}
	
	public function getValueName($value, $type) {
		switch ($type) {
			case 'category':
				$sql = "
					Select
						name
					From
						" . DB_PREFIX . "category_description
					Where
						category_id = " . (int)$value . "
					And
						language_id = " . (int)$this->config->get('config_language_id') . "
				";
				$category = $this->db->query($sql);
				if($category->num_rows) {
					return $category->row['name'];
				} else {
					return false;
				}
				break;
			case 'information':
				$sql = "
					Select
						title as name
					From
						" . DB_PREFIX . "information_description
					Where
						information_id = " . (int)$value . "
					And
						language_id = " . (int)$this->config->get('config_language_id') . "
				";
				$information = $this->db->query($sql);
				if($information->num_rows) {
					return $information->row['name'];
				} else {
					return false;
				}	
				break;
			case 'blog_category':
				$sql = "
					Select
						title as name
					From
						" . DB_PREFIX . "pavblog_category_description
					Where
						category_id = " . (int)$value . "
					And
						language_id = " . (int)$this->config->get('config_language_id') . "
				";
				$category = $this->db->query($sql);
				if($category->num_rows) {
					return $category->row['name'];
				} else {
					return false;
				}
				break;
			case 'category_list':
				$sql = "
					Select
						name
					From
						" . DB_PREFIX . "category_description
					Where
						category_id = " . (int)$value . "
					And
						language_id = " . (int)$this->config->get('config_language_id') . "
				";
				$category = $this->db->query($sql);
				if($category->num_rows) {
					return $category->row['name'];
				} else {
					return false;
				}	
				break;
			case 'gallery':
				$sql = "
					Select
						name
					From
						po_gallery_album_description
					Where
						album_id = " . (int)$value . "
					And
						language_id = " . (int)$this->config->get('config_language_id') . "
				";
				$gallery = $this->db->query($sql);
				if($gallery->num_rows) {
					return $gallery->row['name'];
				} else {
					return false;
				}
				break;
			case 'products_list':
				$data = array();
				
				$products = explode(',', $value);
				foreach ($products as $product) {
					$sql = "
						Select
							name
						From
							" . DB_PREFIX . "product_description
						Where
							product_id = " . (int)$product . "
						And
							language_id = " . (int)$this->config->get('config_language_id') . "
					";
					$product = $this->db->query($sql);
					if($product->num_rows) {
						$data[] = $product->row['name'];
					} else {
						$data[] = '';
					}
				}
				return $data;
				break;
			default:
				return false;
				break;
		}
	}
	
	public function createElement($element, $parent_id = 0) {
		// oc_menu
		$sql = "
			Insert Into
				" . DB_PREFIX . "menu
			Set
				parent_id  = "  . (int)$parent_id . ",
				type_id    = "  . (int)$element['type_id'] . ",
				group_id   = "  . (int)$element['group_id'] . ",
				sort_order = "  . (int)$element['sort_order'] . ",
				class      = '" . $this->db->escape($element['class']) . "',
				icon       = '" . $this->db->escape($element['icon']) . "',
				columns    = "  . (isset($element['columns'])?count($element['columns']):1) . ",
				status     = "  . (int)$element['status'] . "
		";
		$this->db->query($sql);
		$element_id = $this->db->getLastId();
		// oc_menu_column
		if(!empty($element['columns'])) {
			foreach ($element['columns'] as $column) {
				$sql = "
					Insert Into 
						" . DB_PREFIX . "menu_column
					Set
						width = '" . $this->db->escape($column['width']) . "',
						style = '" . $this->db->escape($column['style']) . "',
						menu_id = '" . (int)$element_id . "'
				";
				$this->db->query($sql);
			}
		}
		// oc_menu_description
		if(!empty($element['descriptions'])) {
			foreach ($element['descriptions'] as $description) {
				if(empty($description['name'])) {
					$description['name'] = $this->getElementNameByType($element, $description['language_id']);
				}
				$sql = "
					Insert Into
						" . DB_PREFIX . "menu_description
					Set
						menu_id     = "  . (int)$element_id . ",
						name        = '" . $this->db->escape($description['name']) . "',
						description = '" . $this->db->escape($description['description']) . "',
						language_id = "  . $this->db->escape($description['language_id']) . "
				";
				$this->db->query($sql);
			}
		}
		// oc_menu_property
		if(!empty($element['properties'])) {
			foreach ($element['properties'] as $property) {
				$sql = "
					Insert Into 
						" . DB_PREFIX . "menu_property
					Set
						menu_id     = "  . (int)$element_id . ",
						property_id = "  . (int)$property['property_id'] . ",
						`value`     = '" . $this->db->escape($property['value']) . "'
				";
				$this->db->query($sql);
			}
		}
		
		return $element_id;
	}
	
	public function deleteElement($node_id) {
		$sql = "
			Delete From
				" . DB_PREFIX . "menu
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		$sql = "
			Delete From
				" . DB_PREFIX . "menu_column
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		$sql = "
			Delete From
				" . DB_PREFIX . "menu_description
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		$sql = "
			Delete From
				" . DB_PREFIX . "menu_property
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		
		return false;
	}
	
	public function updateElement($node_id, $data) {
		// update oc_menu
		$sql = "
			Update 
				" . DB_PREFIX . "menu
			Set
				parent_id  = " . (int)$data['parent_id'] . ",
				type_id    = " . (int)$data['type_id'] . ",
				sort_order = " . (int)$data['sort_order'] . ",
				class      = '" . $this->db->escape($data['class']) . "',
				icon       = '" . $this->db->escape($data['icon']) . "',
				columns    = " . (isset($data['columns'])?count($data['columns']):1) . ",
				status     = " . (int)$data['status'] . "
			Where
				menu_id = '" . (int)$node_id . "'
		";
		$this->db->query($sql);
		// delete description
		$sql = "
			Delete From
				" . DB_PREFIX . "menu_description
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		// add description
		if(!empty($data['descriptions'])) {
			foreach ($data['descriptions'] as $description) {
				if(empty($description['name'])) {
					$description['name'] = $this->getElementNameByType($data, $description['language_id']);
				}
				$sql = "
					Insert Into
						" . DB_PREFIX . "menu_description
					Set
						menu_id     = "  . (int)$node_id . ",
						name        = '" . $this->db->escape($description['name']) . "',
						description = '" . $this->db->escape($description['description']) . "',
						language_id = "  . $this->db->escape($description['language_id']) . "
				";
				$this->db->query($sql);
			}
		}
		// delete columns
		$sql = "
			Delete From
				" . DB_PREFIX . "menu_column
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		// add columns
		if(!empty($data['columns'])) {
			foreach ($data['columns'] as $column) {
				$sql = "
					Insert Into
						" . DB_PREFIX . "menu_column
					Set
						width = '" . $this->db->escape($column['width']) . "',
						style = '" . $this->db->escape($column['style']) . "',
						menu_id = '" . (int)$node_id . "'
				";
				$this->db->query($sql);
			}
		}
		// delete properties
		$sql = "
			Delete From
				" . DB_PREFIX . "menu_property
			Where
				menu_id = " . (int)$node_id . "
		";
		$this->db->query($sql);
		// update properties
		if(!empty($data['properties'])) {
			foreach ($data['properties'] as $property) {
				$sql = "
					Insert Into
						" . DB_PREFIX . "menu_property
					Set
						menu_id     = "  . (int)$node_id . ",
						property_id = "  . (int)$property['property_id'] . ",
						`value`     = '" . $this->db->escape($property['value']) . "'
				";
				$this->db->query($sql);
			}
		}
		
		return true;
	}
	
	public function deleteMenuGroup($group_id) {
		// Prevent some little errors
		if(!((int)$group_id)) {
			return false;
		}
		// Get group elements id`s
		$sql = "
			Select 
				menu_id 
			From
				" . DB_PREFIX . "menu
			 Where
				group_id = " . (int)$group_id . "
		";
		$elements = $this->db->query($sql);
		
		if($elements->num_rows) {
			// Delete all information about current group elements
			foreach ($elements->rows as $element) {
				$element_id = $element['menu_id'];
				// Remove columns
				$sql = "
					Delete From 
						" . DB_PREFIX . "menu_column
					Where menu_id = " . (int)$element_id . "
				";
				$this->db->query($sql);
				// Remove descriptions
				$sql = "
					Delete From
						" . DB_PREFIX . "menu_description
					Where menu_id = " . (int)$element_id . "
				";
				$this->db->query($sql);
				// Remove properties
				$sql = "
					Delete From
						" . DB_PREFIX . "menu_property
					Where menu_id = " . (int)$element_id . "
				";
				$this->db->query($sql);
			}
		}
		// delete group elements
		$sql = "
			Delete From
				" . DB_PREFIX . "menu
			Where
				group_id = " . (int)$group_id . "
		";
		$this->db->query($sql);
		return true;
	}
}
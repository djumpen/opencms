<?php
class ModelCatalogFilter extends Model {

  public function addOption($data) {

    $this->db->query("INSERT INTO " . DB_PREFIX . "category_option SET status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "', type = '" . $this->db->escape($data['type']) . "', group_count = '" . (int)$data['group_count'] . "'");

    $option_id = $this->db->getLastId();

    foreach ($data['category_option_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "category_option_description SET option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', postfix = '" . $this->db->escape($value['postfix']) . "'");
		}

    if (isset($data['category_id'])) {
			foreach ($data['category_id'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_option_to_category SET option_id = '" . (int)$option_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
		
		if (isset($data['option_store'])) {
			foreach ($data['option_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_option_to_store SET option_id = '" . (int)$option_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

    if (isset($data['option_value'])) {
      foreach ($data['option_value'] as $option_value) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value SET option_id = '" . (int)$option_id . "', sort_order = '" . (int)(isset($option_value['sort_order']['insert']) ? $option_value['sort_order']['insert'] : $option_value['sort_order']['update']) . "'");

        $value_id = $this->db->getLastId();

        foreach ($option_value['language'] as $language_id => $language) {
				  $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value_description SET value_id = '" . (int)$value_id . "', option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($language['name']) . "'");
				}
      }
    }

    $this->cache->delete('option');
  }

  public function editOption($option_id, $data) {

    $this->db->query("UPDATE " . DB_PREFIX . "category_option SET status = '" . (int)$data['status'] . "', sort_order = '" . (int)$data['sort_order'] . "', type = '" . $this->db->escape($data['type']) . "', group_count = '" . (int)$data['group_count'] . "' WHERE option_id = '" . (int)$option_id . "'");

    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_description WHERE option_id = '" . (int)$option_id . "'");

    foreach ($data['category_option_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "category_option_description SET option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', postfix = '" . $this->db->escape($value['postfix']) . "'");
		}

    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_to_category WHERE option_id = '" . (int)$option_id . "'");

    if (isset($data['category_id'])) {
			foreach ($data['category_id'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_option_to_category SET option_id = '" . (int)$option_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "category_option_to_store WHERE option_id = '" . (int)$option_id . "'");

		if (isset($data['option_store'])) {
			foreach ($data['option_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "category_option_to_store SET option_id = '" . (int)$option_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_value WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_value_description WHERE option_id = '" . (int)$option_id . "'");

    if (isset($data['option_value'])) {
      foreach ($data['option_value'] as $value_id => $value) {

        if (isset($value['sort_order']['update'])) {
          $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value SET option_id = '" . (int)$option_id . "', sort_order = '" . (int)$value['sort_order']['update'] . "', value_id = '" . (int)$value_id . "'");
        } elseif (isset($value['sort_order']['insert'])) {
          $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value SET option_id = '" . (int)$option_id . "', sort_order = '" . (int)$value['sort_order']['insert'] . "'");

          $value_id = $this->db->getLastId();
        }

        foreach ($value['language'] as $language_id => $language) {
				  $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value_description SET value_id = '" . (int)$value_id . "', option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($language['name']) . "'");
				}
      }
    }

    $this->cache->delete('option');
  }

  public function deleteOption($option_id) {
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_description WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_to_category WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_to_store WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_value WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "category_option_value_description WHERE option_id = '" . (int)$option_id . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_value WHERE option_id = '" . (int)$option_id . "'");
    $this->cache->delete('option');
  }

  public function getOption($option_id) {
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option co LEFT JOIN " . DB_PREFIX . "category_option_description cod ON (co.option_id = cod.option_id) WHERE co.option_id = '" . (int)$option_id . "'");

    return $query->row;
  }

  public function getOptionByCategoriesId($categories_id) {

    $data = array();

    foreach ($categories_id as $category_id) $data[] = (int)$category_id;

    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option co LEFT JOIN " . DB_PREFIX . "category_option_description cod ON (cod.option_id = co.option_id) LEFT JOIN " . DB_PREFIX . "category_option_to_category co2c ON (co.option_id = co2c.option_id) WHERE co2c.category_id IN (" . implode(',', $data) . ") AND cod.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY co.sort_order");

    return $query->rows;
  }

  public function getOptionsByCategoryId($category_id) {
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option co LEFT JOIN " . DB_PREFIX . "category_option_description cod ON (cod.option_id = co.option_id) LEFT JOIN " . DB_PREFIX . "category_option_to_category co2c ON (co.option_id = co2c.option_id) WHERE co2c.category_id = '" . (int)$category_id . "' AND cod.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY co.sort_order");

    return $query->rows;
  }

  public function getOptionCategories($option_id) {
    $option_category_data = array();

    $query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category_option_to_category WHERE option_id = '" . (int)$option_id . "'");

    foreach ($query->rows as $result) $option_category_data[] = $result['category_id'];

    return $option_category_data;
  }
  
  public function getOptionStores($option_id) {
		$option_store_data = array();

		$query = $this->db->query("SELECT store_id FROM " . DB_PREFIX . "category_option_to_store WHERE option_id = '" . (int)$option_id . "'");

		foreach ($query->rows as $result) { $option_store_data[] = $result['store_id']; }

		return $option_store_data;
	}

  public function getProductValues($product_id) {
    $product_values_data = array();

    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_value WHERE product_id = '" . (int)$product_id . "'");

    foreach ($query->rows as $result) $product_values_data[] = $result['value_id'];

    return $product_values_data;
  }

  public function getOptionValues($option_id) { # In option form and product callback
   	# Start values
    $value_data = array();

    $value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option_value WHERE option_id = '" . (int)$option_id . "' ORDER BY sort_order");

    foreach ($value_query->rows as $option_value) {
      # Start values description
      $category_option_value_description_data = array();

			$category_option_value_description = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option_value_description WHERE value_id = '" . (int)$option_value['value_id'] . "'");

			foreach ($category_option_value_description->rows as $result) {
				$category_option_value_description_data[$result['language_id']] = array(
          'name' => $result['name']
        );
			}

      $value_data[] = array(
        'value_id'    => $option_value['value_id'],
        'sort_order'  => $option_value['sort_order'],
        'language'    => $category_option_value_description_data
      );
    }

		return $value_data;
  }

	public function getOptionDescriptions($option_id) {
		$option_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_option_description WHERE option_id = '" . (int)$option_id . "'");

		foreach ($query->rows as $result) {
			$option_description_data[$result['language_id']] = array(
        'name'        => $result['name'],
        'description' => $result['description'],
        'postfix'     => $result['postfix']
      );
		}

		return $option_description_data;
	}
	
  public function getOptions($data = array()) { # In options list
    $option_data = array();

    $sql = "SELECT co.option_id, co.type, co.sort_order, co.status, cod.name, cod.postfix FROM " . DB_PREFIX . "category_option co LEFT JOIN " . DB_PREFIX . "category_option_description cod ON (co.option_id = cod.option_id)";

    if (!empty($data['filter_category_id'])) {
      $sql .= " LEFT JOIN " . DB_PREFIX . "category_option_to_category co2c ON (co.option_id = co2c.option_id)";
    }

    $sql .= " WHERE cod.language_id = '" . (int)$this->config->get('config_language_id') . "'";

    if (!empty($data['filter_category_id'])) {
			$sql .= " AND co2c.category_id = '" . (int)$data['filter_category_id'] . "'";
		}

    if (!empty($data['filter_type'])) {
			$sql .= " AND co.type = '" . $this->db->escape($data['filter_type']) . "'";
		}

    if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(cod.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

    if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND co.status = '" . (int)$data['filter_status'] . "'";
		}

    $sql .= " GROUP BY co.option_id";

    $sort_data = array(
			'co.sort_order',
			'cod.name'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY co.sort_order, cod.name";
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

    $options_query = $this->db->query($sql);

    if ($options_query->num_rows) {
      $options_id = array();

      foreach ($options_query->rows as $option) {
        $options_id[] = (int)$option['option_id'];
      }

      $values_query = $this->db->query("SELECT cov.value_id, cov.option_id, covd.name FROM " . DB_PREFIX . "category_option_value cov LEFT JOIN " . DB_PREFIX . "category_option_value_description covd ON (cov.value_id = covd.value_id) WHERE cov.option_id IN (" . implode(',', $options_id) . ") AND covd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY cov.sort_order ASC, covd.name DESC");

      $values = array();
      foreach ($values_query->rows as $value) $values[$value['option_id']][] = $value;

      $categories_query = $this->db->query("SELECT c.category_id, cd.name, co2c.option_id FROM " . DB_PREFIX . "category_option_to_category co2c LEFT JOIN " . DB_PREFIX . "category c ON (c.category_id = co2c.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd ON (cd.category_id = c.category_id) WHERE co2c.option_id IN (" . implode(',', $options_id) . ") AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name DESC");

      $categories = array();
      foreach ($categories_query->rows as $category) $categories[$category['option_id']][] = $category;

      foreach ($options_query->rows as $key => $option) {
        $option_data[$key] = $option;
        $option_data[$key]['values'] = (isset($values[$option['option_id']]) ? $values[$option['option_id']] : array());
        $option_data[$key]['categories'] = (isset($categories[$option['option_id']]) ? $categories[$option['option_id']] : array());
      }
    }

    return $option_data;
  }

  public function getTotalOptions($data = array()) {

    $sql = "SELECT COUNT(DISTINCT co.option_id) AS total  FROM " . DB_PREFIX . "category_option co LEFT JOIN " . DB_PREFIX . "category_option_description cod ON (co.option_id = cod.option_id)";

    if (!empty($data['filter_category_id'])) {
      $sql .= " LEFT JOIN " . DB_PREFIX . "category_option_to_category co2c ON (co.option_id = co2c.option_id)";
    }

    $sql .= " WHERE cod.language_id = '" . (int)$this->config->get('config_language_id') . "'";

    if (!empty($data['filter_category_id'])) {
			$sql .= " AND co2c.category_id = '" . (int)$data['filter_category_id'] . "'";
		}

    if (!empty($data['filter_type'])) {
			$sql .= " AND co.type = '" . $this->db->escape($data['filter_type']) . "'";
		}

    if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(cod.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

    if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND co.status = '" . (int)$data['filter_status'] . "'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

  public function getCategoriesByParentId($parent_id = 0) { # For filter list and form
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name ASC");

		return $query->rows;
	}

  public function existsTables() {
    $exists = true;

    $tables = array(
      'category_option',
      'category_option_description',
      'category_option_to_category',
      'category_option_to_store',
      'category_option_value',
      'category_option_value_description',
      'product_to_value'
    );
//
//    foreach ($tables as $table) {
//      if (!mysql_num_rows($t("SHOW TABLES LIKE '" . DB_PREFIX . $this->db->escape($table) . "'"))) {
//        $exists = false;
//      }
//    }

    return $exists;
  }

  # Install filter tables
  public function createTables() {

		$sql = "
      CREATE TABLE IF NOT EXISTS `oc_category_option` (
        `option_id` int(11) NOT NULL auto_increment,
        `status` int(1) default '1',
        `type` varchar(31) default 'checkbox',
        `sort_order` int(11) default '0',
        `group_count` int(3) default '0',
        PRIMARY KEY  (`option_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

      CREATE TABLE IF NOT EXISTS `oc_category_option_description` (
        `option_id` int(11) NOT NULL,
        `language_id` int(11) NOT NULL,
        `name` varchar(127) NOT NULL,
        `description` varchar(255) NOT NULL,
        `postfix` varchar(63) NOT NULL,
        PRIMARY KEY  (`option_id`,`language_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

      CREATE TABLE IF NOT EXISTS `oc_category_option_to_category` (
        `option_id` int(11) NOT NULL,
        `category_id` int(11) NOT NULL,
        PRIMARY KEY  (`category_id`,`option_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
      
      CREATE TABLE IF NOT EXISTS `oc_category_option_to_store` (
        `option_id` int(11) NOT NULL,
        `store_id` int(11) NOT NULL,
        PRIMARY KEY  (`store_id`,`option_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

      CREATE TABLE IF NOT EXISTS `oc_category_option_value` (
        `value_id` int(11) NOT NULL auto_increment,
        `option_id` int(11) default '0',
        `sort_order` int(11) default '0',
        PRIMARY KEY  (`value_id`,`option_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

      CREATE TABLE IF NOT EXISTS `oc_category_option_value_description` (
        `value_id` int(11) NOT NULL,
        `language_id` int(11) NOT NULL,
        `option_id` int(11) NOT NULL,
        `name` varchar(127) NOT NULL,
        PRIMARY KEY  (`value_id`,`language_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

      CREATE TABLE IF NOT EXISTS `oc_product_to_value` (
        `product_id` int(11) NOT NULL,
        `value_id` int(11) NOT NULL,
        `option_id` int(11) NOT NULL,
        PRIMARY KEY  (`product_id`,`value_id`,`option_id`)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
    ";

		foreach(explode(';', $sql) as $line) {
			$query = str_replace("CREATE TABLE IF NOT EXISTS `oc_", "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX, trim($line));

      if ($query) $this->db->query($query);

			$query = '';
		}

    return $this->existsTables();
	}

  public function backup() {
		$output = '';

    $tables = array('category_option', 'category_option_description', 'category_option_to_category', 'category_option_to_store', 'category_option_value', 'category_option_value_description', 'product_to_value');

		foreach ($tables as $table) {
			if (DB_PREFIX) {
				if (strpos($table, DB_PREFIX) === false) {
					$status = false;
				} else {
					$status = true;
				}
			} else {
				$status = true;
			}

			if ($status) {
				$output .= 'TRUNCATE TABLE `' . $table . '`;' . "\n\n";

				$query = $this->db->query("SELECT * FROM `" . $table . "`");

				foreach ($query->rows as $result) {
					$fields = '';

					foreach (array_keys($result) as $value) {
						$fields .= '`' . $value . '`, ';
					}

					$values = '';

					foreach (array_values($result) as $value) {
						$value = str_replace(array("\x00", "\x0a", "\x0d", "\x1a"), array('\0', '\n', '\r', '\Z'), $value);
						$value = str_replace(array("\n", "\r", "\t"), array('\n', '\r', '\t'), $value);
						$value = str_replace('\\', '\\\\',	$value);
						$value = str_replace('\'', '\\\'',	$value);
						$value = str_replace('\\\n', '\n',	$value);
						$value = str_replace('\\\r', '\r',	$value);
						$value = str_replace('\\\t', '\t',	$value);

						$values .= '\'' . $value . '\', ';
					}

					$output .= 'INSERT INTO `' . $table . '` (' . preg_replace('/, $/', '', $fields) . ') VALUES (' . preg_replace('/, $/', '', $values) . ');' . "\n";
				}

				$output .= "\n\n";
			}
		}

		return $output;
	}

  public function copyAttributesToFilter($data = array()) {
    $this->db->query("TRUNCATE `" . DB_PREFIX . "category_option`");
    $this->db->query("TRUNCATE `" . DB_PREFIX . "category_option_description`");
    $this->db->query("TRUNCATE `" . DB_PREFIX . "category_option_to_category`");
    $this->db->query("TRUNCATE `" . DB_PREFIX . "category_option_to_store`");
    $this->db->query("TRUNCATE `" . DB_PREFIX . "category_option_value`");
    $this->db->query("TRUNCATE `" . DB_PREFIX . "category_option_value_description`");
    $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_value`");

    $this->db->query("INSERT INTO " . DB_PREFIX . "category_option (option_id, status, type, sort_order) SELECT attribute_group_id, '1' AS status, '" . $this->db->escape($data['type']) . "' AS type, sort_order FROM " . DB_PREFIX . "attribute_group");
    $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_description (option_id, language_id, name) SELECT attribute_group_id, language_id, name FROM " . DB_PREFIX . "attribute_group_description");
    $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value (value_id, option_id, sort_order) SELECT attribute_id, attribute_group_id, sort_order FROM " . DB_PREFIX . "attribute");
    $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_value_description (value_id, language_id, option_id, name) SELECT ad.attribute_id, ad.language_id, a.attribute_group_id, ad.name FROM " . DB_PREFIX . "attribute_description ad LEFT JOIN " . DB_PREFIX . "attribute a ON (a.attribute_id = ad.attribute_id)");

    foreach ($data['option_store'] as $store_id) {
      $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_to_store (option_id, store_id) SELECT option_id, '" . (int)$store_id . "' AS store_id FROM " . DB_PREFIX . "category_option");
    }

    $this->db->query("INSERT INTO " . DB_PREFIX . "category_option_to_category (option_id, category_id) SELECT a.attribute_group_id, p2c.category_id FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id = pa.product_id) LEFT JOIN " . DB_PREFIX . "attribute a ON (a.attribute_id = pa.attribute_id) WHERE pa.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY p2c.category_id, a.attribute_group_id");
    $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_value (product_id, value_id, option_id) SELECT pa.product_id, pa.attribute_id, a.attribute_group_id FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (a.attribute_id = pa.attribute_id) WHERE pa.language_id = '" . (int)$this->config->get('config_language_id') . "'");

    $this->cache->delete('option');
  }
}

?>
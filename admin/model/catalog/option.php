<?php
class ModelCatalogOption extends Model {
    public function addOption($data) {
        /*
         * Custom fields
         * */
        if(isset($data['product_page'])) {
            $product_page = ', product_page = ' . (int)$data['product_page'];
        } else {
            $product_page = '';
        }
        /*
         * Custom fields
         * */
        $this->db->query("INSERT INTO `" . DB_PREFIX . "option` SET type = '" . $this->db->escape($data['type']) . "', sort_order = '" . (int)$data['sort_order'] . "', filter_option = '" . (isset($data['filter_option'])?((int)$data['filter_option']):1) . "' " . $product_page);

        $option_id = $this->db->getLastId();

        foreach ($data['option_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "option_description SET option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
        }

        if (isset($data['option_value'])) {
            foreach ($data['option_value'] as $option_value) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_id = '" . (int)$option_id . "', image = '" . $this->db->escape(html_entity_decode($option_value['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$option_value['sort_order'] . "', color = '" . $this->db->escape($option_value['color']) . "'");

                $option_value_id = $this->db->getLastId();

                foreach ($option_value['option_value_description'] as $language_id => $option_value_description) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int)$option_value_id . "', language_id = '" . (int)$language_id . "', option_id = '" . (int)$option_id . "', name = '" . $this->db->escape($option_value_description['name']) . "'");
                }
            }
            $this->cache->delete('select_option');
            $this->cache->delete('select_option_value');
        }
    }

    public function editOption($option_id, $data) {
        /*
         * Custom fields
         * */
        if(isset($data['product_page'])) {
            $product_page = ', product_page = ' . (int)$data['product_page'] . ' ';
        } else {
            $product_page = '';
        }
        /*
         * Custom fields
         * */
        $this->db->query("UPDATE `" . DB_PREFIX . "option` SET type = '" . $this->db->escape($data['type']) . "', sort_order = '" . (int)$data['sort_order'] . "' {$product_page} , filter_option = '" . (isset($data['filter_option'])?((int)$data['filter_option']):1) . "'  WHERE option_id = '" . (int)$option_id . "'");

        $this->db->query("DELETE FROM " . DB_PREFIX . "option_description WHERE option_id = '" . (int)$option_id . "'");

        foreach ($data['option_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "option_description SET option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "option_value WHERE option_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "option_value_description WHERE option_id = '" . (int)$option_id . "'");

        if (isset($data['option_value'])) {
            foreach ($data['option_value'] as $option_value) {
                if ($option_value['option_value_id']) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_value_id = '" . (int)$option_value['option_value_id'] . "', option_id = '" . (int)$option_id . "', image = '" . $this->db->escape(html_entity_decode($option_value['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$option_value['sort_order'] . "', color = '" . $this->db->escape($option_value['color']) . "'");
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_id = '" . (int)$option_id . "', image = '" . $this->db->escape(html_entity_decode($option_value['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$option_value['sort_order'] . "', color = '" . $this->db->escape($option_value['color']) . "'");
                }

                $option_value_id = $this->db->getLastId();

                foreach ($option_value['option_value_description'] as $language_id => $option_value_description) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int)$option_value_id . "', language_id = '" . (int)$language_id . "', option_id = '" . (int)$option_id . "', name = '" . $this->db->escape($option_value_description['name']) . "'");
                }
            }
            $this->cache->delete('select_option');
            $this->cache->delete('select_option_value');
        }
    }

    public function deleteOption($option_id) {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "option` WHERE option_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "option_description WHERE option_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "option_value WHERE option_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "option_value_description WHERE option_id = '" . (int)$option_id . "'");
        $this->cache->delete('select_option');
        $this->cache->delete('select_option_value');
    }

    public function getOption($option_id) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "option` o LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE o.option_id = '" . (int)$option_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getOptions($data = array()) {
        $sql = "SELECT * FROM `" . DB_PREFIX . "option` o LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE od.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
            $sql .= " AND od.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }

        $sort_data = array(
            'od.name',
            'o.type',
            'o.sort_order'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY od.name";
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

    public function getOptionDescriptions($option_id) {
        $option_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_description WHERE option_id = '" . (int)$option_id . "'");

        foreach ($query->rows as $result) {
            $option_data[$result['language_id']] = array('name' => $result['name']);
        }

        return $option_data;
    }

    public function getOptionValue($option_value_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_value ov LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE ov.option_value_id = '" . (int)$option_value_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getOptionValues($option_id) {
        $option_value_data = array();

        $option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_value ov LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE ov.option_id = '" . (int)$option_id . "' AND ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY ov.sort_order ASC");

        foreach ($option_value_query->rows as $option_value) {
            $option_value_data[] = array(
                'option_value_id' => $option_value['option_value_id'],
                'name'            => $option_value['name'],
                'image'           => $option_value['image'],
                'sort_order'      => $option_value['sort_order'],
                'color'           => $option_value['color'],
            );
        }

        return $option_value_data;
    }

    public function getOptionValueDescriptions($option_id, $option_value_ids = array()) {
        $option_value_data = array();

        if (!empty($option_value_ids)) {
            $option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_value WHERE option_value_id IN (" . $this->db->escape(implode(',', $option_value_ids)) . ")");
        } else {
            $option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_value WHERE option_id = '" . (int)$option_id . "'");
        }

        foreach ($option_value_query->rows as $option_value) {
            $option_value_description_data = array();

            $option_value_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "option_value_description WHERE option_value_id = '" . (int)$option_value['option_value_id'] . "'");

            foreach ($option_value_description_query->rows as $option_value_description) {
                $option_value_description_data[$option_value_description['language_id']] = array('name'  => $option_value_description['name']);
            }

            $option_value_data[] = array(
                'option_value_id'          => $option_value['option_value_id'],
                'option_value_description' => $option_value_description_data,
                'image'                    => $option_value['image'],
                'sort_order'               => $option_value['sort_order'],
                'color'                    => $option_value['color'],
            );
        }

        return $option_value_data;
    }

    public function getParentOptionValues($option_id) {
        $this->checkDependentOptionValueDb();

        $parent_option_values = array();

        $query = $this->db->query("SELECT DISTINCT parent_option_value_id FROM `" . DB_PREFIX . "dependent_option_value` WHERE parent_option_id = '" . (int)$option_id . "'");

        foreach ($query->rows as $result) {
            $parent_option_values[] = $result['parent_option_value_id'];
        }

        return $parent_option_values;
    }

    public function getSelectTypeOptions() {
        $select_option_data = $this->cache->get('select_option.' . (int)$this->config->get('config_language_id'));

        if (!$select_option_data) {
            $db_structure = $this->db->query("DESCRIBE `" . DB_PREFIX . "option`");

            foreach ($db_structure->rows as $column) {
                if ($column['Field'] == 'type' && $column['Key'] == '') {
                    $this->db->query("ALTER TABLE `" . DB_PREFIX . "option` ADD INDEX (`type`)");
                }
            }

            $query = $this->db->query("SELECT o.option_id, od.name FROM `" . DB_PREFIX . "option` o LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE od.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY o.sort_order ASC, od.name ASC");

            $select_option_data = $query->rows;

            $this->cache->set('select_option.' . (int)$this->config->get('config_language_id'), $select_option_data);
        }

        return $select_option_data;
    }

    public function getSelectTypeOptionValues() {
        $select_option_value_data = $this->cache->get('select_option_value.' . (int)$this->config->get('config_language_id'));

        if (!$select_option_value_data) {
            $db_structure = $this->db->query("DESCRIBE `" . DB_PREFIX . "option`");

            foreach ($db_structure->rows as $column) {
                if ($column['Field'] == 'type' && $column['Key'] == '') {
                    $this->db->query("ALTER TABLE `" . DB_PREFIX . "option` ADD INDEX (`type`)");
                }
            }

            $query = $this->db->query("SELECT ov.option_id, ov.option_value_id, ovd.name FROM `" . DB_PREFIX . "option_value` ov LEFT JOIN `" . DB_PREFIX . "option_value_description` ovd ON (ov.option_value_id = ovd.option_value_id) LEFT JOIN `" . DB_PREFIX . "option` o ON (ov.option_id = o.option_id) WHERE ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY ov.sort_order ASC, ovd.name ASC");

            $select_option_value_data = $query->rows;

            $this->cache->set('select_option_value.' . (int)$this->config->get('config_language_id'), $select_option_value_data);
        }

        return $select_option_value_data;
    }

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

    public function getTotalOptions() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "option`");

        return $query->row['total'];
    }
}
?>
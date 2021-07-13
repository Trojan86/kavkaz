<?php
class ModelExtensionModuleAfoc3 extends Model {
    public function getColumns($table_name, $qb_group, $prefix, $exclude_fields = array()) {
        $query = $this->db->query("SELECT data_type as data_type, column_name as column_name FROM information_schema.columns WHERE table_schema = '" . DB_DATABASE . "' AND table_name = '" . DB_PREFIX . $table_name . "'");
        
        $columns = array();
        $autocomplete_fields = array('product_id', 'category_id', 'manufacturer_id', 'attribute_id', 'parent_id', 'option_id');
        foreach ($query->rows as $row) {
          if (in_array($row['column_name'], $exclude_fields)) {
            continue;    
          }
          $qb_type = 'string';
          $qb_operator = "'equal', 'not_equal'";
          $qb_label = $this->language->get($table_name . '_' . $row['column_name']);
          $qb_values = array();
          if ($row['column_name'] == 'status') {
            $qb_values = array('1' => $this->language->get('text_enabled'), '0' => $this->language->get('text_disabled'));  
          }
          if ($row['column_name'] == 'shipping' || $row['column_name'] == 'subtract') {
            $qb_values = array('1' => $this->language->get('text_yes'), '0' => $this->language->get('text_no'));  
          }
          if ($row['column_name'] == 'stock_status_id') {
            $sql_stock = "SELECT * FROM " . DB_PREFIX . "stock_status WHERE language_id = '" . (int)$this->config->get('config_language_id') . "'";
            $query_stock = $this->db->query($sql_stock);
            $qb_values = array();
            foreach ($query_stock->rows as $stock_status) {
              $qb_values[$stock_status['stock_status_id']] = $stock_status['name'];
            }
          }
          if ($row['column_name'] == 'tax_class_id') {
            $sql_tax = "SELECT * FROM " . DB_PREFIX . "tax_class";
            $query_tax = $this->db->query($sql_tax);
            $qb_values = array();
            foreach ($query_tax->rows as $tax_class) {
              $qb_values[$tax_class['tax_class_id']] = $tax_class['title'];
            }
          }
          if ($row['column_name'] == 'length_class_id') {
            $sql_lc = "SELECT * FROM " . DB_PREFIX . "length_class lc LEFT JOIN " . DB_PREFIX . "length_class_description lcd ON (lc.length_class_id = lcd.length_class_id) WHERE lcd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
            $query_lc = $this->db->query($sql_lc);
            $qb_values = array();
            foreach ($query_lc->rows as $length_class) {
              $qb_values[$length_class['length_class_id']] = $length_class['title'];
            }
          }
          if ($row['column_name'] == 'weight_class_id') {
            $sql_wc = "SELECT * FROM " . DB_PREFIX . "weight_class wc LEFT JOIN " . DB_PREFIX . "weight_class_description wcd ON (wc.weight_class_id = wcd.weight_class_id) WHERE wcd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
            $query_wc = $this->db->query($sql_wc);
            $qb_values = array();
            foreach ($query_wc->rows as $weight_class) {
              $qb_values[$weight_class['weight_class_id']] = $weight_class['title'];
            }
          }
          if ($row['column_name'] == 'option_value_id') {
            $qb_type = 'string';
            $qb_operator = "'equal', 'not_equal'";
          }
          elseif ($row['data_type'] == 'int' && !in_array($row['column_name'], $autocomplete_fields)) {
            $qb_type = 'integer';
            $qb_operator = "'equal', 'not_equal', 'less', 'less_or_equal', 'greater', 'greater_or_equal', 'between'";
          }
          elseif ($row['data_type'] == 'decimal') {
            $qb_type = 'double';
            $qb_operator = "'equal', 'not_equal', 'less', 'less_or_equal', 'greater', 'greater_or_equal', 'between'";
          }
          elseif ($row['data_type'] == 'varchar' || $row['data_type'] == 'text') {
            $qb_type = 'string';
            $qb_operator = "'equal', 'not_equal', 'contains', 'not_contains', 'is_empty', 'is_not_empty'";
          }
          elseif ($row['data_type'] == 'datetime') {
            $qb_type = 'datetime';
            $qb_operator = "'equal', 'not_equal', 'less', 'less_or_equal', 'greater', 'greater_or_equal', 'between'";
          }
          elseif ($row['data_type'] == 'date') {
            $qb_type = 'date';
            $qb_operator = "'equal', 'not_equal', 'less', 'less_or_equal', 'greater', 'greater_or_equal', 'between'";
          }
          $columns[] = array('name' => $row['column_name'], 'label' => $qb_label, 'type' => $qb_type, 'operators' => $qb_operator, 'group' => $qb_group, 'prefix' => $prefix, 'values' => $qb_values);  
        }
        
        return $columns;
    }
}
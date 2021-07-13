<?php
class ModelExtensionModuleCustomTabSettings extends Model {
  public function getTab($tab_id) {
    $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "tab t LEFT JOIN " . DB_PREFIX . "tab_description td ON (t.tab_id = td.tab_id) WHERE t.tab_id = '" . (int)$tab_id . "' AND td.language_id = '" . (int)$this->config->get('config_language_id') . "'");

    return $query->row;
  }

  public function getTabs() {
    $sql = "SELECT * FROM " . DB_PREFIX . "tab t LEFT JOIN " . DB_PREFIX . "tab_description td ON (t.tab_id = td.tab_id) WHERE td.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY t.sort_order ASC";

    $query = $this->db->query($sql);

    return $query->rows;
  }

  public function getTabDescriptions($tab_id) {
    $tab_description_data = array();

    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tab_description WHERE tab_id = '" . (int)$tab_id . "'");

    foreach ($query->rows as $result) {
      $tab_description_data[$result['language_id']] = array(
        'name'             => $result['name']
      );
    }

    return $tab_description_data;
  }
  
  public function getTabStores($tab_id) {
    $tab_store_data = array();

    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tab_to_store WHERE tab_id = '" . (int)$tab_id . "'");

    foreach ($query->rows as $result) {
      $tab_store_data[] = $result['store_id'];
    }

    return $tab_store_data;
  }
  
  public function getTotalTabs() {
    $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "tab");

    return $query->row['total'];
  }

  public function getAllTabs() {
    $tab_data = $this->cache->get('tab.all.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'));
    if (!$tab_data || !is_array($tab_data)) {
    
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tab t LEFT JOIN " . DB_PREFIX . "tab_description cd ON (t.tab_id = cd.tab_id) LEFT JOIN " . DB_PREFIX . "tab_to_store t2s ON (t.tab_id = t2s.tab_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND t2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY c.parent_id, c.sort_order, cd.name");
    $tab_data = array();
    
    foreach ($query->rows as $row) {
      $tab_data[$row['parent_id']][$row['tab_id']] = $row;
    }
    $this->cache->set('tab.all.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'), $tab_data);
    }
    
    return $tab_data;
  }
  
  public function getTabProducts($tab_id) {
    $products_data = array();
    
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tab_products WHERE tab_id = '" . (int)$tab_id . "'");
    
    foreach ($query->rows as $result) {
      $products_data[] = $result['product_id'];
    }
    
    return $products_data;
  }
  
  public function getShowInCategories($tab_id) {
    $product_category_data = array();

    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tab_to_category WHERE tab_id = '" . (int)$tab_id . "'");

    foreach ($query->rows as $result) {
      $product_category_data[] = $result['category_id'];
    }

    return $product_category_data;
  }
}

<?php
class ModelExtensionModuleCustomTabSettings extends Model {
	public function getTab($tab_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "tab t LEFT JOIN " . DB_PREFIX . "tab_description td ON (t.tab_id = td.tab_id) WHERE t.tab_id = '" . (int)$tab_id . "' AND td.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}

	public function getTabProducts($tab_id) {
		$products_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tab_products WHERE tab_id = '" . (int)$tab_id . "'");

		foreach ($query->rows as $result) {
			$products_data[] = $result['product_id'];
		}

		return $products_data;
	}
	public function getTabToCategory($tab_id){

        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "tab t LEFT JOIN " . DB_PREFIX . "tab_to_category td ON (t.tab_id = td.tab_id) WHERE t.tab_id = '" . (int)$tab_id . "'");

        return $query->row;

    }
}
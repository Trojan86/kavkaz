<?php
class ModelExtensionModuleVacanciesModSettings extends Model {
    public function getVacancies($vacancies_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "vacancies t LEFT JOIN " . DB_PREFIX . "vacancies_description td ON (t.vacancies_id = td.vacancies_id) WHERE t.vacancies_id = '" . (int)$vacancies_id . "' AND td.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getVacanciesProducts($vacancies_id) {
        $products_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vacancies_products WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        foreach ($query->rows as $result) {
            $products_data[] = $result['product_id'];
        }

        return $products_data;
    }
}
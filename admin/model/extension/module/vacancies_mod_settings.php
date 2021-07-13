<?php
class ModelExtensionModuleVacanciesModSettings extends Model {
    public function getVacancies($vacancies_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "vacancies t LEFT JOIN " . DB_PREFIX . "vacancies_description td ON (t.vacancies_id = td.vacancies_id) WHERE t.vacancies_id = '" . (int)$vacancies_id . "' AND td.language_id = '" . (int)$this->config->get('config_language_id') . "'");

        return $query->row;
    }

    public function getVacanciess() {
        $sql = "SELECT * FROM " . DB_PREFIX . "vacancies t LEFT JOIN " . DB_PREFIX . "vacancies_description td ON (t.vacancies_id = td.vacancies_id) WHERE td.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY t.sort_order ASC";

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getVacanciesDescriptions($vacancies_id) {
        $vacancies_description_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vacancies_description WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        foreach ($query->rows as $result) {
            $vacancies_description_data[$result['language_id']] = array(
                'name'             => $result['name']
            );
        }

        return $vacancies_description_data;
    }

    public function getVacanciesStores($vacancies_id) {
        $vacancies_store_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vacancies_to_store WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        foreach ($query->rows as $result) {
            $vacancies_store_data[] = $result['store_id'];
        }

        return $vacancies_store_data;
    }

    public function getTotalVacanciess() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "vacancies");

        return $query->row['total'];
    }

    public function getAllVacanciess() {
        $vacancies_data = $this->cache->get('vacancies.all.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'));
        if (!$vacancies_data || !is_array($vacancies_data)) {

            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vacancies t LEFT JOIN " . DB_PREFIX . "vacancies_description cd ON (t.vacancies_id = cd.vacancies_id) LEFT JOIN " . DB_PREFIX . "vacancies_to_store t2s ON (t.vacancies_id = t2s.vacancies_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND t2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY c.parent_id, c.sort_order, cd.name");
            $vacancies_data = array();

            foreach ($query->rows as $row) {
                $vacancies_data[$row['parent_id']][$row['vacancies_id']] = $row;
            }
            $this->cache->set('vacancies.all.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'), $vacancies_data);
        }

        return $vacancies_data;
    }

    public function getVacanciesProducts($vacancies_id) {
        $products_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vacancies_products WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        foreach ($query->rows as $result) {
            $products_data[] = $result['product_id'];
        }

        return $products_data;
    }

    public function getShowInCategories($vacancies_id) {
        $product_category_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vacancies_to_category WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        foreach ($query->rows as $result) {
            $product_category_data[] = $result['category_id'];
        }

        return $product_category_data;
    }
}


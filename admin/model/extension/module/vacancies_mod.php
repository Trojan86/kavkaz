<?php
class ModelExtensionModuleVacanciesMod extends Model {
    public function addVacancies($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "'");

        $vacancies_id = $this->db->getLastId();

        foreach ($data['vacancies_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_description SET vacancies_id = '" . (int)$vacancies_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
        }

        if (isset($data['vacancies_store'])) {
            foreach ($data['vacancies_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_to_store SET vacancies_id = '" . (int)$vacancies_id . "', store_id = '" . (int)$store_id . "'");
            }
        }

        if (isset($data['products'])) {
            foreach ($data['products'] as $related_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_products SET vacancies_id = '" . (int)$vacancies_id . "', product_id = '" . (int)$related_id . "'");
            }
        }

        if (isset($data['vacancies_to_category'])) {
            foreach ($data['vacancies_to_category'] as $category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_to_category SET vacancies_id = '" . (int)$vacancies_id . "', category_id = '" . (int)$category_id . "'");
            }
        }

        $this->cache->delete('vacancies');

        return $vacancies_id;
    }

    public function editVacancies($vacancies_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "vacancies SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "' WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_description WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        foreach ($data['vacancies_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_description SET vacancies_id = '" . (int)$vacancies_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
        }


        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_to_store WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        if (isset($data['vacancies_store'])) {
            foreach ($data['vacancies_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_to_store SET vacancies_id = '" . (int)$vacancies_id . "', store_id = '" . (int)$store_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_products WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        if (isset($data['products'])) {
            foreach ($data['products'] as $related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_products WHERE vacancies_id = '" . (int)$vacancies_id . "' AND product_id = '" . (int)$related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_products SET vacancies_id = '" . (int)$vacancies_id . "', product_id = '" . (int)$related_id . "'");
            }
        }

        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_to_category WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        if (isset($data['vacancies_to_category'])) {
            foreach ($data['vacancies_to_category'] as $category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "vacancies_to_category SET vacancies_id = '" . (int)$vacancies_id . "', category_id = '" . (int)$category_id . "'");
            }
        }

        $this->cache->delete('vacancies');
    }

    public function editVacanciesStatus($vacancies_id, $status) {
        $this->db->query("UPDATE " . DB_PREFIX . "vacancies SET status = '" . (int)$status . "'WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        $this->cache->delete('vacancies');

    }

    public function deleteVacancies($vacancies_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies WHERE vacancies_id = '" . (int)$vacancies_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_description WHERE vacancies_id = '" . (int)$vacancies_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_to_store WHERE vacancies_id = '" . (int)$vacancies_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "vacancies_products WHERE vacancies_id = '" . (int)$vacancies_id . "'");

        $this->cache->delete('vacancies');
    }

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

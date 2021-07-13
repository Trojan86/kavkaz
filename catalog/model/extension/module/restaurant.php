<?php
class ModelExtensionModuleRestaurant extends Model
{
    public function processOutput()
    {
        $data['contacts'] = array();
        $query = $this->db->query("SELECT  contact_ID FROM " . DB_PREFIX . "Contacts;");
        $ids = $query->rows;
        if (!empty($ids)) {
            foreach ($ids as $idr)
                foreach ($idr as $k => $id) {
                    $contact = array("title" => "", "phone" => "", "work_start" => "",
                        "work_finish" => "", "address" => "", "place" => "", "iframe" => "");
                    $query = $this->db->query(
                        "SELECT title, phone, work_start, work_finish, address, place, iframe" .
                        " FROM " . DB_PREFIX . "Contacts WHERE contact_id=" . $id . ";");
                    $results = $query->rows;
                    foreach ($results as $result)
                        foreach ($result as $key => $value) {
                            $contact[$key] = $value;
                        }
                    $contact["route"] = preg_replace("/place/", "dir/", $contact["place"]);
                    Array_push($data["contacts"], $contact);
                }
        }
        return $data["contacts"];
    }

    public function getTableExist($table_name) {

        $query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . $table_name . "'");

        return $query->num_rows;
    }
}
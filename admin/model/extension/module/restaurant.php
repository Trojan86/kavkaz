<?php
class ModelExtensionModuleRestaurant extends Model
{
    public function install()
    {
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "Contacts;");
        $this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "Contacts" .
            "(contact_id int(11) NOT NULL AUTO_INCREMENT, " .
            "title TEXT NOT NULL, " .
            "street TEXT NOT NULL, " .
            "building TEXT NOT NULL, " .
            "phone TEXT NOT NULL, " .
            "work_start TEXT NOT NULL, " .
            "work_finish TEXT NOT NULL, " .
            "address TEXT NOT NULL, " .
            "place TEXT NOT NULL, " .
            "iframe TEXT NOT NULL, " .
            "PRIMARY KEY (contact_id));");
        $this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%Restaurant Back End%'");
        $this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%Restaurant Front End%'");
    }

    public function uninstall()
    {
        $this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%Restaurant Back End%'");
        $this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%Restaurant Front End%'");
    }

    public function getAllContacts()
    {
        $data['contacts'] = array();
        $query = $this->db->query("SELECT  contact_ID FROM " . DB_PREFIX . "Contacts;");
        $ids = $query->rows;
        if (empty($ids)) {
            return false;
        }
        foreach ($ids as $idr)
            foreach ($idr as $k => $id) {
                $contact = array("title" => "", "phone" => "", "work_start" => "",
                    "work_finish" => "", "address" => "", "place" => "", "iframe" => "", "contact_id" => $id);
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
        return $data["contacts"];
    }

    public function addContact($str)
    {
        $columns = array('street', 'building', 'phone', 'work_start', 'work_finish', 'place', 'iframe');
        $data_pr = array();
        foreach ($columns as $clm) {
            if (!isset($_POST[$clm]) || empty($_POST[$clm]))
                return false;
            $data_pr[$clm] = $_POST[$clm];
        }
        $data_pr['title'] = $data_pr['street'] . " " . $data_pr['building'];
        $data_pr['address'] = $str ." ". $data_pr['street'] . ", " . $data_pr['building'];
        $data_pr["iframe"] = preg_replace("/(?=height=\")[0-9]+/", "auto", $data_pr["iframe"]);
        $columns[7] = 'title';
        $columns[8] = 'address';
        $amount = count($columns);
        $inColumn = '(';
        $values = "('";
        for ($i = 0; $i < $amount - 1; $i++) {
            $inColumn = $inColumn . $columns[$i] . ", ";
            $values = $values . $data_pr[$columns[$i]] . "', '";
        }
        $inColumn = $inColumn . $columns[$amount - 1] . ") ";
        $values = $values . $data_pr[$columns[$amount - 1]] . "');";
        $queryText = "INSERT INTO " . DB_PREFIX . "Contacts" . $inColumn . "VALUES" . $values;
        $this->db->query($queryText);
        return true;
    }

    public function editContact($str)
    {
        $contact = array();
        if (!$this->request->server['REQUEST_METHOD'] == 'POST')
            return false;
        $data_ec = array('street' => $_POST['street'], 'building' => $_POST['building'],
            'phone' => $_POST['phone'], 'work_start' => $_POST['work_start'],
            'work_finish' => $_POST['work_finish'], 'place' => $_POST['place'],
            'iframe' => $_POST['iframe'], 'contact_id' => $_POST['edit_id']);
        $keys = array();
        $empty_input = true;
        foreach ($data_ec as $k => $v) {
            if (isset($data_ec[$k]) && !empty($data_ec[$k])) {
                if ($k != 'contact_id')
                    $empty_input = false;
                $contact[$k] = $v;
                array_push($keys, $k);
            }
        }
        if ($empty_input)
            return false;
        if (isset($contact['street']) && (!empty($contact['street'])) ||
            isset($contact['building']) && (!empty($contact['building']))) {
            if (!isset($contact['street']) || (empty($contact['street'])))
                $data_ec['street'] = $this->db->query("SELECT street" . " FROM " . DB_PREFIX . "Contacts WHERE contact_id=" . $_POST['edit_id'] . ";");
            if (!isset($contact['building']) || (empty($contact['building'])))
                $data_ec['building'] = $this->db->query("SELECT building" . " FROM " . DB_PREFIX . "Contacts WHERE contact_id=" . $_POST['edit_id'] . ";");
            $data_ec['title'] = $data_ec['street'] . ' ' . $data_ec['building'];
            $data_ec['address'] = $str ." ". $data_ec['street'] . ', ' . $data_ec['building'];
        }
        array_push($keys, 'title', 'address');

        $columnStr = "UPDATE " . DB_PREFIX . "Contacts  SET ";
        $amount = count($keys);
        for ($i = 0; $i < $amount - 1; $i++) {
            $columnStr = $columnStr . $keys[$i] . " = '" . $data_ec[$keys[$i]] . "', ";
        }
        $columnStr = $columnStr . $keys[$amount - 1] . " = '" . $data_ec[$keys[$amount - 1]] . "' ";
        $queryText = $columnStr . " WHERE contact_id='" . $_POST['edit_id'] . "';";
        $this->db->query($queryText);
        return true;
    }

    public function getContactById()
    {
        $data['contact'] = array();
        $query = $this->db->query(
            "SELECT street, building, phone, work_start, work_finish, place, iframe" .
            " FROM " . DB_PREFIX . "Contacts WHERE contact_id='" . $_POST['edit_id'] . "';");
        $results = $query->rows;
        foreach ($results as $result)
            foreach ($result as $key => $value) {
                $data['contact'][$key] = $value;
            }
        $data["contact"]['contact_id'] = $_POST['edit_id'];
        return $data["contact"];
    }

    public function deleteContact()
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "Contacts WHERE contact_id='" .
            $_POST['delete_id'] . "';");
    }
}
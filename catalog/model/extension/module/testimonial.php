<?php

class ModelExtensionModuleTestimonial extends Model
{
    public function addTestimonial($data)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial SET
        author = '" . $this->db->escape($data['name']) . "',
        email = '" . $this->db->escape($data['email']) . "',
        customer_id = '" . (int)$this->customer->getId() . "',
        text = '" . $this->db->escape($data['text']) . "',
        status = '" . (int)$data['status'] . "',
        image = '" . $this->db->escape($data['image']) . "',
        rating = '" . (int)$data['rating'] . "',
        date_added = NOW()");

        $testimonial_id = $this->db->getLastId();

        $this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_store SET testimonial_id = '" . (int)$testimonial_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "'");
        $this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_language SET testimonial_id = '" . (int)$testimonial_id . "', language_id = '" . (int)$this->config->get('config_language_id') . "'");

        $this->load->language('extension/module/testimonial');

        $subject = sprintf($this->language->get('text_mail_subject'), $this->config->get('config_name'));

        $message = $this->language->get('text_mail_title') . "\n";
        $message .= sprintf($this->language->get('text_mail_reviewer'), $this->db->escape(strip_tags($data['name']))) . "\n";
        if ($data['email']) {
            $message .= sprintf($this->language->get('text_mail_email'), $this->db->escape(strip_tags($data['email']))) . "\n";
        }
        if ($data['rating']) {
            $message .= sprintf($this->language->get('text_mail_rating'), $this->db->escape(strip_tags($data['rating']))) . "\n";
        }
        $message .= $this->language->get('text_mail_review') . "\n";
        $message .= $this->db->escape(strip_tags($data['text'])) . "\n\n";

        if(substr(VERSION, 0, 7) > '2.0.1.1'){
            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_host')?$this->config->get('config_mail_smtp_host'):$this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
        }else{
            $mail = new Mail($this->config->get('config_mail'));
        }

        $mail->setTo($this->config->get('config_email'));
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender($this->config->get('config_name'));
        $mail->setSubject($subject);
        $mail->setText($message);

        $mail_list = '';

        if(substr(VERSION, 0, 7) > '2.2.0.0'){
            if(in_array('testimonial', (array)$this->config->get('config_mail_alert'))){
                $mail->send();
                $mail_list = $this->config->get('config_mail_alert_email');
            }
        } else if($this->config->get('testimonial_mail')){
            $mail->send();
            $mail_list = $this->config->get('config_mail_alert');
        }
        if($mail_list && !is_array($mail_list)) {
            $emails = explode(',', $mail_list);
            foreach ($emails as $email) {
                if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
                    $mail->setTo($email);
                    $mail->send();
                }
            }
        }
    }

    public function getTestimonials($data = array())
    {
        $sql = "SELECT r.testimonial_id, r.customer_id, r.user_id, r.author, r.image, r.rating, r.text, r.reply, r.date_added FROM " . DB_PREFIX . "vs_testimonial r";

        if($data['multistore']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_store rs ON (r.testimonial_id = rs.testimonial_id)";
        }

        if($data['multilang']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_language rl ON (r.testimonial_id = rl.testimonial_id)";
        }

        $sql .= " WHERE r.status = '1'";

        if($data['multilang']){
            $sql .= " AND rl.language_id = '" . (int)$this->config->get('config_language_id') ."'";
        }

        if($data['multistore']){
            $sql .= " AND rs.store_id = '" . (int)$this->config->get('config_store_id') ."'";
        }

        $sort_data = array(
            'r.rating',
            'r.date_added'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
           $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY r.date_added";
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

    public function getModuleTestimonials($data = array())
    {
        $sql = "SELECT * FROM " . DB_PREFIX . "vs_testimonial r";
        if ($data['start'] < 0) {
            $data['start'] = 0;
        }

        if ($data['limit'] < 1) {
            $data['limit'] = 20;
        }

        if($data['multistore']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_store rs ON (r.testimonial_id = rs.testimonial_id)";
        }

        if($data['multilang']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_language rl ON (r.testimonial_id = rl.testimonial_id)";
        }
        $sql .= " WHERE status = '1'";

        if($data['multilang']) {
            $sql .= " AND rl.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if($data['multistore']) {
            $sql .= " AND rs.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        }

        switch ($data['order']) {
            case 0: {
                $sql .= "ORDER BY r.date_added  DESC LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                break;
            }
            case 1: {
                $sql .= "ORDER BY RAND() DESC LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                break;
            }
            case 2: {
                if($data['ids']) {
                    $sql .= 'AND r.testimonial_id IN (' . $data['ids'] . ') ORDER BY r.date_added LIMIT ' . (int)$data['limit'];
                }else{
                    $sql .= "ORDER BY r.date_added  DESC LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                }
                break;
            }
            case 3: {
                if($data['ids']) {
                    $sql .= 'AND r.testimonial_id IN (' . $data['ids'] . ') ORDER BY RAND() LIMIT ' . (int)$data['limit'];
                }else{
                    $sql .= "ORDER BY RAND() DESC LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                }
                break;
            }
            default: {
                $sql .= "ORDER BY r.date_added DESC LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getTotalTestimonials($data = array())
    {
        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "vs_testimonial r";

        if($data['multistore']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_store rs ON (r.testimonial_id = rs.testimonial_id)";
        }

        if($data['multilang']) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_language rl ON (r.testimonial_id = rl.testimonial_id)";
        }

        $sql .= " WHERE r.status = '1'";

        if($data['multilang']) {
            $sql .= " AND rl.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if($data['multistore']) {
            $sql .= " AND rs.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        }

        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getAggregateRating($multistore = 0, $multilang = 0 )
    {
        $sql = "SELECT COUNT(*) AS total, AVG(r.rating) as average FROM " . DB_PREFIX . "vs_testimonial r";

        if($multistore) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_store rs ON (r.testimonial_id = rs.testimonial_id)";
        }
        if($multilang) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_language rl ON (r.testimonial_id = rl.testimonial_id)";
        }

        $sql .= " WHERE r.status = '1' AND r.rating <> 0";

        if($multilang) {
            $sql .= " AND rl.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }

        if($multistore) {
            $sql .= " AND rs.store_id = '" . (int)$this->config->get('config_store_id') . "'";
        }

        $query = $this->db->query($sql);

        return $query->row;
    }

    public function getUrlKeyword($query) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->db->escape($query) . "'");

        if(isset($query->row['keyword'])){
            $keyword = $query->row['keyword'];
        }else{
            $keyword = '';
        }
        return $keyword;
    }

    public function getUserInfo($user_id = 0) {
        $query = $this->db->query("SELECT u.image, u.firstname, u.lastname FROM `" . DB_PREFIX . "user` u WHERE u.user_id = '" . (int)$user_id . "'");
        return $query->row;
    }

    public function isPurchaser($customer_id)
    {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "order WHERE customer_id = '" . (int)$customer_id . "'");

        return $query->row['total'];
    }

    public function getRatingIcons($data){
        $rating_icon = array();
        switch ($data['testimonial_icon']){
            case 0:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-star fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-star-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 1:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-thumbs-up fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-thumbs-o-up fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-thumbs-o-up fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 2:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-trophy fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-trophy fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-trophy fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 3:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-smile-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-smile-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-smile-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 4:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-certificate fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-certificate fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-certificate fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 5:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-heart fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-heart-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-heart-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 6:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-circle fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-circle-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-circle-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 7:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-check fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-check fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-check fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 8:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-check-circle-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-check-circle-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-check-circle-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 9:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-bookmark fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-bookmark-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-bookmark-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 10:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-asterisk fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-asterisk fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-asterisk fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 11:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-circle-thin fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 12:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-circle fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 13:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-circle-thin fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 14:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-circle fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 15:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-square-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 16:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-square fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 17:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-square-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 18:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-square fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-star-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".($data['testimonial_icon_size']-5)."px;line-height: inherit;'></span>";
                $rating_icon['testimonial_icon_third'] = "";
                break;
            }
            case 19:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-check-square-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-check-square-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-check-square-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 20:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-check-circle fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-check-circle fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-check-circle fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
            case 21:{
                $rating_icon['testimonial_icon_first'] = "<span class='fa fa-flag fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_second'] = "<span class='fa fa-flag-o fa-stack-2x' style='color: ".$data['testimonial_icon_border'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                $rating_icon['testimonial_icon_third'] = "<span class='fa fa-flag-o fa-stack-2x' style='color: ".$data['testimonial_icon_color'].";font-size: ".$data['testimonial_icon_size']."px;'></span>";
                break;
            }
        }
        return $rating_icon;
    }

    public function getTableExist($table_name) {

        $query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . $table_name . "'");

        return $query->num_rows;
    }

}
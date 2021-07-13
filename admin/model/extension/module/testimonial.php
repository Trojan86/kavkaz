<?php
class ModelExtensionModuleTestimonial extends Model {

	public function install() {

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "vs_testimonial` (`testimonial_id` int(11) NOT NULL AUTO_INCREMENT,`customer_id` int(11) NOT NULL,`user_id` int(11) NOT NULL,`author` varchar(64) NOT NULL,`email` varchar(96) NOT NULL,`image` varchar(255) DEFAULT NULL,`text` text NOT NULL,`reply` text NOT NULL,`rating` int(1) NOT NULL,`status` tinyint(1) NOT NULL DEFAULT '0',`date_added` datetime NOT NULL,`date_modified` datetime NOT NULL,PRIMARY KEY (`testimonial_id`)) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "vs_testimonial_to_language` (`testimonial_id` int(11) NOT NULL,`language_id` int(11) NOT NULL,PRIMARY KEY (`testimonial_id`,`language_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "vs_testimonial_to_store` (`testimonial_id` int(11) NOT NULL,`store_id` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`testimonial_id`,`store_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;");

		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%Testimonial Back End%'");
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%Testimonial Front End%'");
	}

	public function uninstall() {
		//$this->db->query("DROP TABLE `" . DB_PREFIX . "vs_testimonial`;");
		//$this->db->query("DROP TABLE `" . DB_PREFIX . "vs_testimonial_to_language`;");
		//$this->db->query("DROP TABLE `" . DB_PREFIX . "vs_testimonial_to_store`;");

		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%Testimonial Back End%'");
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%Testimonial Front End%'");
	}

	public function addTestimonial($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial SET author = '" . $this->db->escape($data['author']) . "', customer_id = '" . (int)$data['customer'] . "', user_id = '" . (int)$data['user_id'] . "',  email = '" . $this->db->escape($data['email']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "'");

		$testimonial_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "vs_testimonial SET image = '" . $this->db->escape($data['image']) . "' WHERE testimonial_id = '" . (int)$testimonial_id . "'");
		}

		if (isset($data['testimonial_language'])) {
			foreach ($data['testimonial_language'] as $language_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_language SET testimonial_id = '" . (int)$testimonial_id . "', language_id = '" . (int)$language_id . "'");
			}
		}

		if (isset($data['testimonial_store'])) {
			foreach ($data['testimonial_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_store SET testimonial_id = '" . (int)$testimonial_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		return $testimonial_id;
	}

	public function editTestimonial($testimonial_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "vs_testimonial SET author = '" . $this->db->escape($data['author']) . "', customer_id = '" . (int)$data['customer'] . "', user_id = '" . (int)$data['user_id'] . "', email = '" . $this->db->escape($data['email']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = '" . $this->db->escape($data['date_added']) . "', date_modified = NOW() WHERE testimonial_id = '" . (int)$testimonial_id  . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "vs_testimonial SET image = '" . $this->db->escape($data['image']) . "' WHERE testimonial_id = '" . (int)$testimonial_id . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "vs_testimonial_to_language WHERE testimonial_id = '" . (int)$testimonial_id . "'");

		if (isset($data['testimonial_language'])) {
			foreach ($data['testimonial_language'] as $language_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_language SET testimonial_id = '" . (int)$testimonial_id . "', language_id = '" . (int)$language_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "vs_testimonial_to_store WHERE testimonial_id = '" . (int)$testimonial_id . "'");

		if (isset($data['testimonial_store'])) {
			foreach ($data['testimonial_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_store SET testimonial_id = '" . (int)$testimonial_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
	}

	public function deleteTestimonial($testimonial_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vs_testimonial WHERE testimonial_id = '" . (int)$testimonial_id . "'");
		if($query->row['image']){
			unlink(DIR_IMAGE.$query->row['image']);
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "vs_testimonial WHERE testimonial_id = '" . (int)$testimonial_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "vs_testimonial_to_store WHERE testimonial_id = '" . (int)$testimonial_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "vs_testimonial_to_language WHERE testimonial_id = '" . (int)$testimonial_id . "'");
	}

	public function getTestimonial($testimonial_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vs_testimonial WHERE testimonial_id = '" . (int)$testimonial_id . "'");

		return $query->row;
	}

	public function getTestimonials($data = array()) {
		$sql = "SELECT r.* FROM " . DB_PREFIX . "vs_testimonial r
		LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_store rs ON (r.testimonial_id = rs.testimonial_id)
		LEFT JOIN " . DB_PREFIX . "vs_testimonial_to_language rl ON (r.testimonial_id = rl.testimonial_id)
		WHERE r.testimonial_id > 0";

		if (isset($data['filter_store']) && !is_null($data['filter_store'])) {
			$sql .= " AND rs.store_id = '" . (int)$data['filter_store'] . "'";
		}

		if (isset($data['filter_language']) && !is_null($data['filter_language'])) {
			$sql .= " AND rl.language_id = '" . (int)$data['filter_language'] . "'";
		}

		if (isset($data['filter_rating']) && !is_null($data['filter_rating'])) {
			$sql .= " AND r.rating = '" . (int)$data['filter_rating'] . "'";
		}

		if (!empty($data['filter_text'])) {
			$sql .= " AND r.text LIKE '" . $this->db->escape($data['filter_text']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND r.author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sql .= " GROUP BY r.testimonial_id";

		$sort_data = array(
			'r.author',
			'r.rating',
			'r.status',
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

	public function getTotalTestimonials($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "vs_testimonial WHERE testimonial_id > 0";

		if (isset($data['filter_rating']) && !is_null($data['filter_rating'])) {
			$sql .= " AND rating = '" . (int)$data['filter_rating'] . "'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND author LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$query = @$this->db->query($sql);

		return @$query->row['total'];
	}

	public function getTotalTestimonialsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "vs_testimonial WHERE status = '0'");

		return $query->row['total'];
	}

	public function getTestimonialStores($testimonial_id) {
		$testimonial_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vs_testimonial_to_store WHERE testimonial_id = '" . (int)$testimonial_id . "'");

		foreach ($query->rows as $result) {
			$testimonial_store_data[] = $result['store_id'];
		}

		return $testimonial_store_data;
	}

	public function getTestimonialLanguages($testimonial_id) {
		$testimonial_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "vs_testimonial_to_language WHERE testimonial_id = '" . (int)$testimonial_id . "'");

		foreach ($query->rows as $result) {
			$testimonial_store_data[] = $result['language_id'];
		}

		return $testimonial_store_data;
	}

	public function getTableExist($table_name) {

		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . $table_name . "'");

		return $query->num_rows;
	}

	public function getPreviousVersion() {
		$testimonials = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "testimonial'");
		$tm_to_language = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "testimonial_to_language'");
		$tm_to_store = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "testimonial_to_store'");
		if($testimonials->num_rows && $tm_to_language->num_rows &&  $tm_to_store->num_rows){
			$testimonials = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "testimonial`");
			$vs_testimonials = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "vs_testimonial`");
			if($testimonials->num_rows == $vs_testimonials->num_rows){
				$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "testimonial");
				return $query->row['total'];
			}else{
				return false;
			}
		}else{
			return false;
		}
	}

	public function getStoreReviews() {

		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r WHERE r.product_id = '0'");

		return $query->row['total'];
	}

	public function importStoreReviews($user_id = 0, $delete = 0){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review r WHERE r.product_id = '0'");

		foreach($query->rows as $item){
			$customer_email = '';
			if($item['customer_id']){
				$customer = $this->db->query("SELECT c.email FROM " . DB_PREFIX . "customer c WHERE c.customer_id = " . $item['customer_id']);
				if(isset($customer->row['email'])){
					$customer_email = $customer->row['email'];
				}
			}

			$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial SET
				customer_id = '" . $item['customer_id'] . "',
				user_id =   '" . (int)$user_id . "',
				author = '" . $this->db->escape($item['author']) . "',
				image = '',
				email = '" . $this->db->escape($customer_email) . "',
				text = '" . $this->db->escape(strip_tags($item['text'])) . "',
				reply = '',
				rating = '" . $item['rating'] . "',
				status = '" . $item['status'] . "',
				date_added = '" . $this->db->escape($item['date_added']) . "',
				date_modified = '" . $item['date_modified'] . "'");
		}
		if($delete){
			$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '0'");
		}
	}

	public function importPreviousVersion($delete = 0){

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial");

		foreach($query->rows as $item){
			$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial SET
				customer_id = '" . $item['customer_id'] . "',
				user_id = '" .  $item['user_id'] . "',
				author = '" . $this->db->escape($item['author']) . "',
				image = '" . $this->db->escape($item['image']) . "',
				email = '" . $this->db->escape($item['email']) . "',
				text = '" . $this->db->escape(strip_tags($item['text'])) . "',
				reply = '" . $item['reply'] . "',
				rating = '" . $item['rating'] . "',
				status = '" . $item['status'] . "',
				date_added = '" . $this->db->escape($item['date_added']) . "',
				date_modified = '" . $this->db->escape($item['date_modified']) . "'");

			$testimonial_id = $this->db->getLastId();

			$tm_to_lang = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial_to_language WHERE testimonial_id = '" . (int)$item['testimonial_id'] . "'");

			foreach ($tm_to_lang->rows as $language) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_language SET testimonial_id = '" . (int)$testimonial_id . "', language_id = '" . (int)$language['language_id']  . "'");
			}

			$tm_to_store = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial_to_store WHERE testimonial_id = '" . (int)$item['testimonial_id'] . "'");

			foreach ($tm_to_store->rows as $store) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "vs_testimonial_to_store SET testimonial_id = '" . (int)$testimonial_id . "', store_id = '" . (int)$store['store_id']  . "'");
			}
		}

		if($delete){
			$this->db->query("DROP TABLE `" . DB_PREFIX . "testimonial`;");
			$this->db->query("DROP TABLE `" . DB_PREFIX . "testimonial_to_language`;");
			$this->db->query("DROP TABLE `" . DB_PREFIX . "testimonial_to_store`;");
		}
	}

	public function editUrl($data) {

		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE `query` = 'testimonial/testimonial'");

		if ($data['keyword']) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET  `keyword` = '" . $this->db->escape($data['keyword']) . "', `query` = 'testimonial/testimonial'");
		}
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

	public function getUrlAlias($keyword) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($keyword) . "'");

		return $query->row;
	}
}
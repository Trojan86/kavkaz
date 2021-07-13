<?php
class ControllerCommonFooter extends Controller {
	public function index() {
        $query =$this->db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE `setting_id`= 8292;" );

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {

            $name = trim($_POST['firstname']);


            $phone = trim($_POST['phone']);
            $phone = strip_tags($phone);
            $phone = htmlspecialchars($phone);

            $mail = trim($_POST['email']);
            $mail = strip_tags($mail);
            $mail = htmlspecialchars($mail);

            $theme = trim($_POST['text']);
            $theme = strip_tags($theme);
            $theme = htmlspecialchars($theme);

            if ($name and $phone and $mail and $theme) {
                $email = $query->row['value'];
                $headers = 'MIME-Version: 1.0' . "\r\n";
                $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
                $headers .= 'From: Интернет-магазин kavkaz-ochag <site@kavkaz-ochag>' . "\r\n";
                $subject = "Обращение к директору";
                $body = "<h1>Обращение к директору</h1>";
                $body .= "<p>Пользователь: " . $name . "</p>";
                $body .= "<p>Телефон: " . $phone . "</p>";
                $body .= "<a href='mailto:" . $mail . "'>$mail</a>";
                $body .= "<p>Сообщение: " . $theme . "</p>";

                $result = mail($email, $subject, $body, $headers);
            }

            //$this->load->model('account/customer');

            //$this->model_account_customer->editNewsletter($this->request->post['newsletter']);

            $this->session->data['success'] = $this->language->get('text_success');

            //$this->response->redirect($this->url->link('account/download', '', true));
        }

		$this->load->language('common/footer');
        $this->load->model('account/customer');

		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

        $data['heading_title'] = $this->language->get('heading_title');
        $data['name_lastname'] = $this->language->get('name_lastname');
        $data['phone_number'] = $this->language->get('phone_number');
        $data['email_text'] = $this->language->get('email_text');
        $data['essence'] = $this->language->get('essence');

        $data['error_text'] = $this->language->get('error_text');
        $data['error_email'] = $this->language->get('error_email');
        $data['entry_newsletter'] = $this->language->get('entry_newsletter');

        $data['action'] = $this->url->link('common/home', '', true);

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);
        $data['about_href'] = $this->url->link('information/information', 'information_id=4', true);
        $data['delivery_href'] = $this->url->link('information/information', 'information_id=7', true);
        $data['promotions_href'] = $this->url->link('information/information', 'information_id=8', true);
        $data['vacancies_href'] = $this->url->link('information/information', 'information_id=9', true);
        $data['catering_href'] = $this->url->link('information/information', 'information_id=10', true);
        $data['restorans_href'] = $this->url->link('information/information', 'information_id=11', true);
        $data['contact_href'] = $this->url->link('information/information', 'information_id=12', true);
		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		return $this->load->view('common/footer', $data);
	}
}

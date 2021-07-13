<?php 
class ControllerExtensionModulePopupLogReg extends Controller {
	public function index() {
		$this->language->load('extension/module/popup_logreg');
        $settings = $this->config->get('popup_logreg');
        $language_id = $this->config->get('config_language_id');
        $this->load->model('account/customer');
        $data['action'] = $this->url->link('account/forgotten', '', true);
        //Login form
        $data['head_login'] = $settings['module_head'][$language_id];
        $data['login_email'] = $settings['login_email'][$language_id];
        $data['login_password'] = $settings['login_password'][$language_id];
        $data['login_button'] = $settings['login_button'][$language_id];
        $data['login_result'] = $settings['login_result'][$language_id];
        $data['login_forgotten'] = $settings['login_forgotten'][$language_id];
        $data['login_register'] = $settings['login_register'][$language_id];
        $data['no_accaunt'] = $this->language->get('no_accaunt');
        $data['text_else'] = $this->language->get('text_else');

        //Registration form
        $data['register_head'] = $settings['register_head'][$language_id];
        $data['register_firstname'] = $settings['register_firstname'][$language_id];
        $data['register_lastname'] = $settings['register_lastname'][$language_id];
        $data['register_phone'] = $settings['register_phone'][$language_id];
        $data['register_email'] = $settings['register_email'][$language_id];
        $data['register_password'] = $settings['register_password'][$language_id];
        $data['register_password_confirm'] = $settings['register_password_confirm'][$language_id];
        $data['register_button'] = $settings['register_button'][$language_id];
        $data['text_gender'] = $this->language->get('text_gender');
        $data['gender_man'] = $this->language->get('gender_man');
        $data['gender_wooman'] = $this->language->get('gender_wooman');


		$data['popup_logreg_login'] = $this->config->get('popup_logreg_login');
		$data['popup_logreg_login_block'] = $this->config->get('popup_logreg_login_block');
		$data['popup_logreg_login_block_link'] = $this->config->get('popup_logreg_login_block_link');
		$data['popup_logreg_login_head'] = $this->config->get('popup_logreg_login_head');
		$data['popup_logreg_login_label'] = $this->config->get('popup_logreg_login_label');
		$data['popup_logreg_login_email'] = $this->config->get('popup_logreg_login_email');
		$data['popup_logreg_login_email_placeholder'] = $this->config->get('popup_logreg_login_email_placeholder');
		$data['popup_logreg_login_password'] = $this->config->get('popup_logreg_login_password');
		$data['popup_logreg_login_password_placeholder'] = $this->config->get('popup_logreg_login_password_placeholder');
		$data['popup_logreg_login_button'] = $this->config->get('popup_logreg_login_button');
		$data['popup_logreg_login_result'] = $this->config->get('popup_logreg_login_result');
		$data['popup_logreg_login_forgotten_enable'] = $this->config->get('popup_logreg_login_forgotten_enable');
		$data['popup_logreg_login_forgotten'] = $this->config->get('popup_logreg_login_forgotten');
		$data['popup_logreg_login_register_enable'] = $this->config->get('popup_logreg_login_register_enable');
		$data['popup_logreg_login_register'] = $this->config->get('popup_logreg_login_register');
		$data['popup_logreg_login_success'] = $this->config->get('popup_logreg_login_success');
		
		$data['popup_logreg_register'] = $this->config->get('popup_logreg_register');
		$data['popup_logreg_register_block'] = $this->config->get('popup_logreg_register_block');
		$data['popup_logreg_register_block_link'] = $this->config->get('popup_logreg_register_block_link');
		$data['popup_logreg_register_head'] = $this->config->get('popup_logreg_register_head');
		$data['popup_logreg_register_label'] = $this->config->get('popup_logreg_register_label');
		$data['popup_logreg_register_firstname_show'] = $this->config->get('popup_logreg_register_firstname_show');
		$data['popup_logreg_register_firstname'] = $this->config->get('popup_logreg_register_firstname');
		$data['popup_logreg_register_firstname_placeholder'] = $this->config->get('popup_logreg_register_firstname_placeholder');
		$data['popup_logreg_register_lastname_show'] = $this->config->get('popup_logreg_register_lastname_show');
		$data['popup_logreg_register_lastname'] = $this->config->get('popup_logreg_register_lastname');
		$data['popup_logreg_register_lastname_placeholder'] = $this->config->get('popup_logreg_register_lastname_placeholder');
		$data['popup_logreg_register_phone_show'] = $this->config->get('popup_logreg_register_phone_show');
		$data['popup_logreg_register_phone'] = $this->config->get('popup_logreg_register_phone');
		$data['popup_logreg_register_phone_placeholder'] = $this->config->get('popup_logreg_register_phone_placeholder');
		$data['popup_logreg_register_phone_mask'] = $this->config->get('popup_logreg_register_phone_mask');
		$data['popup_logreg_register_email'] = $this->config->get('popup_logreg_register_email');
		$data['popup_logreg_register_email_placeholder'] = $this->config->get('popup_logreg_register_email_placeholder');
		$data['popup_logreg_register_password'] = $this->config->get('popup_logreg_register_password');
		$data['popup_logreg_register_password_placeholder'] = $this->config->get('popup_logreg_register_password_placeholder');
		$data['popup_logreg_register_password_confirm_show'] = $this->config->get('popup_logreg_register_password_confirm_show');
		$data['popup_logreg_register_password_confirm'] = $this->config->get('popup_logreg_register_password_confirm');
		$data['popup_logreg_register_password_confirm_placeholder'] = $this->config->get('popup_logreg_register_password_confirm_placeholder');
		$data['popup_logreg_register_button'] = $this->config->get('popup_logreg_register_button');
		$data['popup_logreg_register_iagree'] = $this->config->get('popup_logreg_register_iagree');
		$data['popup_logreg_register_success'] = $this->config->get('popup_logreg_register_success');
		$data['popup_logreg_register_group'] = $this->config->get('popup_logreg_register_group');

		$data['phone_mask'] = $this->language->get('phone_mask');
		
		$this->document->addStyle('catalog/view/javascript/jquery/popup_logreg/popup_logreg.css');
		$this->document->addScript('catalog/view/javascript/jquery/popup_logreg/popup_logreg.js');
		$this->document->addScript('catalog/view/javascript/jquery/popup_logreg/jquery.maskedinput.min.js');
		
		$data['logged'] = $this->customer->isLogged();
		
		if($this->config->get('popup_logreg_register_group')) {
		$this->load->model('account/customer_group');
		$data['customer_groups'] = array();
		if (is_array($this->config->get('config_customer_group_display'))) {
			$customer_groups = $this->model_account_customer_group->getCustomerGroups();
			
			foreach ($customer_groups as $customer_group) {
				if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
					$data['customer_groups'][] = $customer_group;
				}
			}
		}
		
		if (isset($this->request->post['customer_group_id'])) {
    		$data['customer_group_id'] = $this->request->post['customer_group_id'];
		} else {
			$data['customer_group_id'] = $this->config->get('config_customer_group_id');
		}
		}
		
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
			
			if ($information_info) {
				$data['text_agree'] = sprintf($this->language->get('popup_text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$data['text_agree'] = '';
			}
		} else {
			$data['text_agree'] = '';
		}
			
		return $this->load->view('extension/module/popup_logreg', $data);
	}
	
	public function info() {
		$this->response->setOutput($this->index());
	}
	
	public function login() {
		$this->load->model('account/customer');
        $settings = $this->config->get('popup_logreg');
        $language_id = $this->config->get('config_language_id');
		$json = array();
	
		if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
			$json['error']['warning'] = $settings['login_result'][$language_id];
		} else {
			if($this->config->get('popup_logreg_login_success')) {
					$json['success'] = 1;
					$json['redirect'] = $this->url->link('account/simpleedit', '', 'SSL');
			} else {
					$json['success'] = 1;
			}
		}
		
		if (!$json) {
			$data['email'] = $this->request->post['email'];
			$data['password'] = $this->request->post['password'];		
		}
		
		if (!$json) {
			unset($this->session->data['guest']);
			unset($this->session->data['shipping_country_id']);	
			unset($this->session->data['shipping_zone_id']);	
			unset($this->session->data['shipping_postcode']);
			unset($this->session->data['payment_country_id']);	
			unset($this->session->data['payment_zone_id']);	
		}
		
		$this->response->setOutput(json_encode($json));	
		
	}
	
	public function register() {
		$this->language->load('checkout/checkout');
		
		$this->load->model('account/customer');
		
		$json = array();
						
		if (!$json) {
			if ($this->config->get('popup_logreg_register_firstname_show')) {
				if ((utf8_strlen($this->request->post['firstname']) < 3) || (utf8_strlen($this->request->post['firstname']) > 32)) {
					$json['error']['firstname'] = $this->language->get('error_firstname');
				}
			}
			if ($this->config->get('popup_logreg_register_lastname_show')) {
				if ((utf8_strlen($this->request->post['lastname']) < 3) || (utf8_strlen($this->request->post['lastname']) > 32)) {
					$json['error']['lastname'] = $this->language->get('error_lastname');
				}
			}
			if ($this->config->get('popup_logreg_register_phone_show')) {
				if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
					$json['error']['phone'] = $this->language->get('error_telephone');
				}
			}
			if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
				$json['error']['email'] = $this->language->get('error_email');
			}
	
			if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
				$json['error']['warning'] = $this->language->get('error_exists');
			}
			
			$this->load->model('account/customer_group');
			
			if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
				$customer_group_id = $this->request->post['customer_group_id'];
			} else {
				$customer_group_id = $this->config->get('config_customer_group_id');
			}
	
			if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
				$json['error']['password'] = $this->language->get('error_password');
			}
			
			if($this->config->get('popup_logreg_register_password_confirm_show')) {
				if ($this->request->post['password_confirm'] != $this->request->post['password']) {
					$json['error']['password_confirm'] = $this->language->get('error_confirm');
				}
			}
			
			if($this->config->get('popup_logreg_register_iagree')) {			
				if ($this->config->get('config_account_id')) {
					$this->load->model('catalog/information');
				
					$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
					
					if ($information_info && !isset($this->request->post['agree'])) {
						$json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
					}
				}
			}
		}
		
		if (!$json) {
		//
			
		if (isset($this->request->post['firstname'])) {
			$data['firstname'] = $this->request->post['firstname'];
		} else {
			$data['firstname'] = '';
		}

		if (isset($this->request->post['lastname'])) {
			$data['lastname'] = $this->request->post['lastname'];
		} else {
			$data['lastname'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$data['telephone'] = $this->request->post['telephone'];
		} else {
			$data['telephone'] = '';
		}
		
		if (isset($this->request->post['password'])) {
			$data['password'] = $this->request->post['password'];
		} else {
			$data['password'] = '';
		}

		$data['fax'] = '';
		$data['company'] = '';
		$data['address_1'] = '';
		$data['address_2'] = '';
		$data['postcode'] = '';
		$data['city'] = '';
		$data['country_id'] = $this->config->get('config_country_id');
		$data['zone_id'] = '';	
		
		$this->model_account_customer->addCustomer($data);
		
			$this->session->data['account'] = 'register';
							  	  
		  	if ($this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				if($this->config->get('popup_logreg_register_success')) {
					$json['success'] = 1;
					$json['redirect'] = $this->url->link('account/simpleedit', '', 'SSL');
				} else {
					$json['success'] = 1;
				}
			}
			
			unset($this->session->data['guest']);
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);	
			unset($this->session->data['payment_methods']);
		}	
		
		$this->response->setOutput(json_encode($json));	
	}
	public function forgotten() {
        $this->load->model('account/customer');
        $settings = $this->config->get('popup_logreg');
        $language_id = $this->config->get('config_language_id');
        $json = array();

        if (!$this->customer->login($this->request->post['email'])){
            $json['success'] = 1;
            $data['email'] = $this->request->post['email'];
        }
        if (!$json) {
            $data['email'] = $this->request->post['email'];
        }
        $this->response->setOutput(json_encode($json));
    }
}
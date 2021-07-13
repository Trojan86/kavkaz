<?php
class ControllerExtensionModulePopupLogReg extends Controller {
	private $error = array(); 
	
	public function index() {
        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();
	    
		$this->language->load('extension/module/popup_logreg');

		$this->document->setTitle(strip_tags($this->language->get('heading_title')));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			if ($this->request->post['apply']) {
				$url = $this->url->link('extension/module/popup_logreg', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$url = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
			}
			
			unset($this->request->post['apply']);
			
			$this->model_setting_setting->editSetting('popup_logreg', $this->request->post);
		
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($url);
		}
				
		$data['heading_title'] = $this->language->get('heading_title');
        $data['entry_head'] = $this->language->get('entry_head');

		$data['text_apply'] = $this->language->get('text_apply');
		$data['text_enable_login'] = $this->language->get('text_enable_login');
		$data['text_enable_register'] = $this->language->get('text_enable_register');
        $data['text_enable_forgotten'] = $this->language->get('text_enable_forgotten');
		$data['text_head'] = $this->language->get('text_head');
		$data['text_input_name'] = $this->language->get('text_input_name');
		$data['text_yes'] = $this->language->get('text_yes');		
		$data['text_no'] = $this->language->get('text_no');
		$data['text_input_name_firstname_show'] = $this->language->get('text_input_name_firstname_show');
		$data['text_input_name_firstname'] = $this->language->get('text_input_name_firstname');
		$data['text_input_firstname_placeholder'] = $this->language->get('text_input_firstname_placeholder');
		$data['text_input_name_lastname_show'] = $this->language->get('text_input_name_lastname_show');
		$data['text_input_name_lastname'] = $this->language->get('text_input_name_lastname');
		$data['text_input_lastname_placeholder'] = $this->language->get('text_input_lastname_placeholder');
		$data['text_input_name_phone_show'] = $this->language->get('text_input_name_phone_show');
		$data['text_input_name_phone'] = $this->language->get('text_input_name_phone');
		$data['text_input_phone_placeholder'] = $this->language->get('text_input_phone_placeholder');
		$data['text_input_phone_mask'] = $this->language->get('text_input_phone_mask');
		$data['text_input_name_email'] = $this->language->get('text_input_name_email');
		$data['text_input_email_placeholder'] = $this->language->get('text_input_email_placeholder');
		$data['text_input_name_password'] = $this->language->get('text_input_name_password');
		$data['text_input_password_placeholder'] = $this->language->get('text_input_password_placeholder');
		$data['text_input_name_password_confirm_show'] = $this->language->get('text_input_name_password_confirm_show');
		$data['text_input_name_password_confirm'] = $this->language->get('text_input_name_password_confirm');
		$data['text_input_password_confirm_placeholder'] = $this->language->get('text_input_password_confirm_placeholder');
		$data['text_input_iagree'] = $this->language->get('text_input_iagree');
		$data['text_input_login_success'] = $this->language->get('text_input_login_success');
		$data['text_input_register_success'] = $this->language->get('text_input_register_success');
		$data['text_login_button'] = $this->language->get('text_login_button');
		$data['text_register_button'] = $this->language->get('text_register_button');
		$data['text_login_error'] = $this->language->get('text_login_error');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_link_text'] = $this->language->get('text_link_text');
		$data['text_block'] = $this->language->get('text_block');
		$data['text_block_link'] = $this->language->get('text_block_link');
		$data['text_block_link_last'] = $this->language->get('text_block_link_last');
		$data['text_input_register_group'] = $this->language->get('text_input_register_group');
		$data['text_copyright'] = '<a href="http://oc-dev.ru">Oc-Dev.ru © 2014-2015</a>';
		
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
				
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/popup_logreg', 'token=' . $this->session->data['token'], 'SSL'),
   		);
		
		$data['action'] = $this->url->link('extension/module/popup_logreg', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $data['settings'] = $this->config->get('popup_logreg') ? $this->config->get('popup_logreg') : array();
		$config_vars = array(
			'popup_logreg_login',
			'popup_logreg_login_block', 'popup_logreg_login_block_link',
			'popup_logreg_login_head', 'popup_logreg_login_label', 
			'popup_logreg_login_email', 'popup_logreg_login_email_placeholder', 
			'popup_logreg_login_password', 'popup_logreg_login_password_placeholder',
			'popup_logreg_login_button', 'popup_logreg_login_result',
			'popup_logreg_login_forgotten_enable', 'popup_logreg_login_forgotten',	
			'popup_logreg_login_register_enable', 'popup_logreg_login_register',
			'popup_logreg_login_register',
			'popup_logreg_register',
			'popup_logreg_register_block', 'popup_logreg_register_block_link',
			'popup_logreg_register_head', 'popup_logreg_register_label', 
			'popup_logreg_register_firstname_show', 'popup_logreg_register_firstname', 'popup_logreg_register_firstname_placeholder', 
			'popup_logreg_register_lastname_show', 'popup_logreg_register_lastname', 'popup_logreg_register_lastname_placeholder', 
			'popup_logreg_register_phone_show', 'popup_logreg_register_phone', 'popup_logreg_register_phone_placeholder', 'popup_logreg_register_phone_mask',
			'popup_logreg_register_email', 'popup_logreg_register_email_placeholder', 
			'popup_logreg_register_password', 'popup_logreg_register_password_placeholder',
			'popup_logreg_register_password_confirm_show', 'popup_logreg_register_password_confirm', 'popup_logreg_register_password_confirm_placeholder',
			'popup_logreg_register_button', 'popup_logreg_register_result',
			'popup_logreg_register_group',
			'popup_logreg_register_iagree',
            'popup_logreg_forgotten',
            'popup_logreg_forgotten_block', 'popup_logreg_forgotten_block_link',
			'popup_logreg_login_success','popup_logreg_register_success','popup_logreg_forgotten_success',
		);
	
		foreach ($config_vars as $config_var) {
			if (isset($this->request->post[$config_var])) {
				$data[$config_var] = $this->request->post[$config_var];
			} elseif ($this->config->get($config_var)) {
				$data[$config_var] = $this->config->get($config_var);
			} else {
				$data[$config_var] = '0';
			}
		}
				
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/popup_logreg', $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/popup_logreg')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
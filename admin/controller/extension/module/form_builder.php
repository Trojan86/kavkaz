<?php
class ControllerExtensionModuleFormBuilder extends Controller {
	private $type = 'module';
	private $ext = 'extension';
	private $em = 'extension/module';
	private $name = 'form_builder';
	
	public function install() {
		$setting_table = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "setting WHERE Field = 'value'");
		if (strtoupper($setting_table->row['Type']) == 'TEXT') {
			$this->db->query("ALTER TABLE " . DB_PREFIX . "setting MODIFY `value` MEDIUMTEXT NOT NULL");
		}
		
		$module_table = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "module WHERE Field = 'setting'");
		if (strtoupper($module_table->row['Type']) == 'TEXT') {
			$this->db->query("ALTER TABLE " . DB_PREFIX . "module MODIFY `setting` MEDIUMTEXT NOT NULL");
		}
		
	}
	
	public function index() {
		$data = array(
			'type'				=> $this->em,
			'name'				=> $this->name,
			'autobackup'		=> false,
			'vqmod'				=> false,
			'save_type'			=> 'keepediting',
			'token'				=> $this->session->data['token'],
			'permission'		=> $this->user->hasPermission('modify', $this->em . '/' . $this->name),
			'exit'				=> $this->url->link('extension/' . $this->ext . '&token=' . $this->session->data['token'], '', true),
		);
		
		$this->loadSettings($data);
		
		//------------------------------------------------------------------------------
		// Modules
		//------------------------------------------------------------------------------
		$modules = array();
		$module_info = array();
		$module_id = 0;
		

		$this->load->model('extension/module');
		if (isset($this->request->get['module_id'])) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
			$module_info['module_id'] = $this->request->get['module_id'];
		} else {
			foreach ($this->model_extension_module->getModulesByCode($this->name) as $module) {
					$modules[$module['module_id']] = $module['name'];
			}
		}
		
		
		//------------------------------------------------------------------------------
		// Data Arrays
		//------------------------------------------------------------------------------
		$data['store_array'] = array(0 => $this->config->get('config_name'));
		$store_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "store ORDER BY name");
		foreach ($store_query->rows as $store) {
			$data['store_array'][$store['store_id']] = $store['name'];
		}
		
		$data['language_array'] = array($this->config->get('config_language') => '');
		$data['language_flags'] = array();
		$this->load->model('localisation/language');
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$data['language_array'][$language['code']] = $language['name'];
			$data['language_flags'][$language['code']] = 'language/' . $language['code'] . '/' . $language['code'] . '.png';
		}
		
		$data['customer_group_array'] = array(0 => $data['text_guests']);
		$this->load->model('customer/customer_group');
		foreach ($this->model_customer_customer_group->getCustomerGroups() as $customer_group) {
			$data['customer_group_array'][$customer_group['customer_group_id']] = $customer_group['name'];
		}
		
		$data['currency_array'] = array($this->config->get('config_currency') => '');
		$this->load->model('localisation/currency');
		foreach ($this->model_localisation_currency->getCurrencies() as $currency) {
			$data['currency_array'][$currency['code']] = $currency['code'];
		}
		
		$this->load->model('design/layout');
		$layouts = array();
		foreach ($this->model_design_layout->getLayouts() as $layout) {
			$layouts[$layout['layout_id']] = $layout['name'];
		}
		
		$positions = array(
			'content_top'		=> $data['text_content_top'],
			'column_left'		=> $data['text_column_left'],
			'column_right'		=> $data['text_column_right'],
			'content_bottom'	=> $data['text_content_bottom'],
		);
		
		//------------------------------------------------------------------------------
		// Extension Settings
		//------------------------------------------------------------------------------
		$data['settings'] = array();
		
		$data['settings'][] = array(
			'key'		=> 'status',
			'type'		=> 'hidden',
			'default'	=> 1,
		);
		$data['settings'][] = array(
			'key'		=> 'tooltips',
			'type'		=> 'hidden',
			'default'	=> 0,
		);
		
		if (!isset($this->request->get['module_id'])) {
			
			$data['save_type'] = 'none';
			
			$data['settings'][] = array(
				'key'		=> 'module_list',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> 'module_list',
				'type'		=> 'table_start',
				'columns'	=> array('module_name', 'edit_module', 'copy_module', 'delete_module'),
			);
			foreach ($modules as $module_id => $module_name) {
				$data['settings'][] = array(
					'type'		=> 'row_start',
				);
				$data['settings'][] = array(
					'key'		=> 'module_link',
					'type'		=> 'button',
					'module_id'	=> $module_id,
					'text'		=> $module_name,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> 'edit_module',
					'type'		=> 'button',
					'module_id'	=> $module_id,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> 'copy_module',
					'type'		=> 'button',
					'module_id'	=> $module_id,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> 'delete_module',
					'type'		=> 'button',
					'module_id'	=> $module_id,
				);
				$data['settings'][] = array(
					'type'		=> 'row_end',
				);
			}
			$data['settings'][] = array(
				'type'		=> 'table_end',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<a class="btn btn-primary" href="index.php?route=' . $this->em . '/' . $this->name . '&module_id=0&token=' . $data['token'] . '"><i class="fa fa-plus pad-right"></i> ' . $data['button_add_module'] . '</a>',
			);
			
		} else {
			
			//------------------------------------------------------------------------------
			// Module Editing Page
			//------------------------------------------------------------------------------
			$data['exit'] = $this->url->link($this->em . '/' . $this->name . '&token=' . $this->session->data['token'], '', true);
			$data['module_id'] = $this->request->get['module_id'];
			
			$module_prefix = 'module_' . $data['module_id'] . '_';
			
			if ($data['module_id'] == 0) {
				$data['settings'][] = array(
					'key'		=> 'create_a_new_module',
					'type'		=> 'heading',
				);
			} else {
				$data['settings'][] = array(
					'key'		=> $module_prefix . 'module_id',
					'type'		=> 'hidden',
					'default'	=> $data['module_id'],
				);
				$data['settings'][] = array(
					'key'		=> 'edit',
					'type'		=> 'heading',
					'text'		=> $data['heading_edit'] . ' "' . (!empty($module_info['name']) ? $module_info['name'] : '(no name)') . '"',
				);
				foreach ($module_info as $key => $value) {
					$data['saved'][$module_prefix . $key] = $value;
				}
			}
			
			$data['settings'][] = array(
				'type'		=> 'tabs',
				'tabs'		=> array('general_settings', 'form_fields', 'email_settings',  'restrictions'),
			);
			
			//------------------------------------------------------------------------------
			// General Settings
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'status',
				'type'		=> 'select',
				'options'	=> array(1 => $data['text_enabled'], 0 => $data['text_disabled']),
				'default'	=> 1
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'name',
				'type'		=> 'text',
			);
			
			// Text Settings
			$data['settings'][] = array(
				'key'		=> 'text_settings',
				'type'		=> 'heading',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'heading',
				'type'		=> 'multilingual_text',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'pre_text',
				'type'		=> 'multilingual_textarea',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'post_text',
				'type'		=> 'multilingual_textarea',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'error_email',
				'type'		=> 'multilingual_text',
				'default'	=> 'Please enter a valid e-mail address',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'error_required',
				'type'		=> 'multilingual_text',
				'default'	=> 'Please fill in all required fields',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'submit_button',
				'type'		=> 'multilingual_text',
				'default'	=> 'Submit',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'please_wait',
				'type'		=> 'multilingual_text',
				'default'	=> 'Please wait...',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'success',
				'type'		=> 'multilingual_text',
				'default'	=> 'Your responses have been successfully submitted. Thank you!',
			);
			
			// Display Settings
			$data['settings'][] = array(
				'key'		=> 'display_settings',
				'type'		=> 'heading',
			);
			
			$data['settings'][] = array(
					'type'		=> 'html',
					'title'		=> $data['entry_module_locations'],
					'content'	=> '<div style="margin-top: 9px">' . $data['help_module_locations'] . '  <a href="index.php?route=design/layout&token=' . $data['token'] . '">' . ' Дизайн > Макеты</a></div>',
			);
			
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'extra_css',
				'type'		=> 'textarea',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="well">' . $data['help_form_page'] . '</div>',
			);
			
			//------------------------------------------------------------------------------
			// Form Fields
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> 'form_fields',
				'type'		=> 'tab',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> '<div class="text-info well">' . $data['help_form_fields'] . '</div>',
			);
			
			$table = 'field';
			$sortby = 'sort_order';
			$data['settings'][] = array(
				'key'		=> $table,
				'type'		=> 'table_start',
				'columns'	=> array('action', 'sort_order', 'type', 'required', '', ''),
			);
			foreach ($this->getTableRowNumbers($data, $module_prefix . $table, $sortby) as $num => $rules) {
				$prefix = $module_prefix . $table . '_' . $num . '_';
				$data['settings'][] = array(
					'type'		=> 'row_start',
				);
				$data['settings'][] = array(
					'key'		=> 'delete',
					'type'		=> 'button',
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'sort_order',
					'type'		=> 'text',
					'class'		=> 'short',
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'type',
					'type'		=> 'select',
					'default'	=> 'radio',
					'options'	=> array(
						'group_single_response'		=> '',
						'radio'						=> $data['text_radio_buttons'],
						'select'					=> $data['text_select_dropdown'],
						'group_multiple_response'	=> '',
						'checkbox'					=> $data['text_checkboxes'],
						'multiselect'				=> $data['text_multiselect_box'],
						'group_freeform_response'	=> '',
						'email'						=> $data['text_email_field'],
						'text'						=> $data['text_text_field'],
						'textarea'					=> $data['text_textarea_field'],
						'group_datetime_response'	=> '',
						'date'						=> $data['text_date_field'],
						'time'						=> $data['text_time_field'],
					),
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'required',
					'type'		=> 'select',
					'options'	=> array(0 => $data['text_no'], 1 => $data['text_yes']),
					'default'	=> 0,
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'title',
					'type'		=> 'multilingual_text',
					'before'	=> '<b>' . $data['column_title'] . '</b><br />',
					'after'		=> '<br /><b>' . $data['column_text'] . '</b><br />',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'text',
					'type'		=> 'multilingual_text',
				);
				$data['settings'][] = array(
					'type'		=> 'column',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'responses',
					'type'		=> 'multilingual_text',
					'before'	=> '<b>' . $data['column_responses'] . '</b><br />',
					'after'		=> '<br /><b>' . $data['column_other_response'] . '</b><br />',
				);
				$data['settings'][] = array(
					'key'		=> $prefix . 'other_response',
					'type'		=> 'multilingual_text',
				);
				$data['settings'][] = array(
					'type'		=> 'row_end',
				);
			}
			
			$data['settings'][] = array(
				'type'		=> 'table_end',
				'buttons'	=> 'add_row',
				'text'		=> 'button_add_field',
			);
			
			//------------------------------------------------------------------------------
			// E-mail Settings
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> 'email_settings',
				'type'		=> 'tab',
			);
			$data['settings'][] = array(
				'type'		=> 'html',
				'content'	=> $data['help_email_shortcodes'],
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'admin_email',
				'type'		=> 'text',
				'default'	=> $this->config->get('config_email'),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'admin_subject',
				'type'		=> 'multilingual_text',
				'default'	=> '[store_name]: [form_name] response',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'admin_message',
				'type'		=> 'multilingual_textarea',
				'default'	=> "<p>You have received a response to your [form_name] form, with the following responses:</p>\n\n<p>[form_responses]</p>",
				'class'		=> 'summernote',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'customer_email',
				'type'		=> 'select',
				'options'	=> array(0 => $data['text_no'], 1 => $data['text_yes']),
				'default'	=> 1,
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'customer_subject',
				'type'		=> 'multilingual_text',
				'default'	=> '[store_name]: [form_name] submitted',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'customer_message',
				'type'		=> 'multilingual_textarea',
				'default'	=> "<p>Thank you for your submission! We will respond to your inquiry as soon as possible. A copy of your responses is included below. Thanks again!</p>\n\n<p>[store_name]<br />[store_url]</p>\n\n<p>[form_responses]</p>",
				'class'		=> 'summernote',
			);
			
			//------------------------------------------------------------------------------
			// Restrictions
			//------------------------------------------------------------------------------
			$data['settings'][] = array(
				'key'		=> 'restrictions',
				'type'		=> 'tab',
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'stores',
				'type'		=> 'checkboxes',
				'options'	=> $data['store_array'],
				'default'	=> array_keys($data['store_array']),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'languages',
				'type'		=> 'checkboxes',
				'options'	=> $data['language_array'],
				'default'	=> array_keys($data['language_array']),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'customer_groups',
				'type'		=> 'checkboxes',
				'options'	=> $data['customer_group_array'],
				'default'	=> array_keys($data['customer_group_array']),
			);
			$data['settings'][] = array(
				'key'		=> $module_prefix . 'currencies',
				'type'		=> 'checkboxes',
				'options'	=> $data['currency_array'],
				'default'	=> array_keys($data['currency_array']),
			);
			
		}
		
		//------------------------------------------------------------------------------
		// end settings
		//------------------------------------------------------------------------------
		
		$this->document->setTitle($data['heading_title']);
		$this->document->addStyle('view/javascript/form_builder/summernote.css');
		$this->document->addScript('view/javascript/form_builder/summernote.min.js');
		

			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
			$this->response->setOutput($this->load->view($this->em . '/' . $this->name, $data));
		
	}
	
	//==============================================================================
	// Setting functions
	//==============================================================================
	private $encryption_key = '';
	private $columns = 7;
	
	private function getTableRowNumbers(&$data, $table, $sorting) {
		$groups = array();
		$rules = array();
		
		foreach ($data['saved'] as $key => $setting) {
			if (preg_match('/' . $table . '_(\d+)_' . $sorting . '/', $key, $matches)) {
				$groups[$setting][] = $matches[1];
			}
			if (preg_match('/' . $table . '_(\d+)_rule_(\d+)_type/', $key, $matches)) {
				$rules[$matches[1]][] = $matches[2];
			}
		}
		
		if (empty($groups)) {
			$groups = array('' => array('1'));
		}
		ksort($groups, defined('SORT_NATURAL') ? SORT_NATURAL : SORT_REGULAR);
		
		$data['used_rows'][$table] = array();
		$rows = array();
		foreach ($groups as $group) {
			foreach ($group as $num) {
				$data['used_rows'][preg_replace('/module_(\d+)_/', '', $table)][] = $num;
				$rows[$num] = (empty($rules[$num])) ? array() : $rules[$num];
			}
		}
		sort($data['used_rows'][$table]);
		
		return $rows;
	}
	
	public function loadSettings(&$data) {
		$backup_type = (empty($data)) ? 'manual' : 'auto';
		if ($backup_type == 'manual' && !$this->user->hasPermission('modify', $this->em . '/' . $this->name)) {
			return;
		}
		
		// Load saved settings
		$data['saved'] = array();
		$settings_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `code` = '" . $this->db->escape($this->name) . "' ORDER BY `key` ASC");
		
		foreach ($settings_query->rows as $setting) {
			$key = str_replace($this->name . '_', '', $setting['key']);
			$value = $setting['value'];
			if ($setting['serialized']) {
				$value = json_decode($setting['value'], true);
			}
			
			$data['saved'][$key] = $value;
			
			if (is_array($value)) {
				foreach ($value as $num => $value_array) {
					foreach ($value_array as $k => $v) {
						$data['saved'][$key . '_' . $num . '_' . $k] = $v;
					}
				}
			}
		}
		
		// Load language and run standard checks
		$data = array_merge($data, $this->load->language($this->em . '/' . $this->name));
		
		if (ini_get('max_input_vars') && ((ini_get('max_input_vars') - count($data['saved'])) < 50)) {
			$data['warning'] = $data['standard_max_input_vars'];
		}
		
		if (!empty($data['vqmod']) && !file_exists(DIR_APPLICATION . '../vqmod/vqmod.php')) {
			$data['warning'] = $data['standard_vqmod'];
		}
		
		if ($this->type == 'total') {
			file_put_contents(DIR_CATALOG . 'model/extension/' . $this->type . '/' . $this->name . '.php', str_replace('public function getTotal(&$total_data, &$order_total, &$taxes) {', 'public function getTotal($total) { $total_data = &$total["totals"]; $order_total = &$total["total"]; $taxes = &$total["taxes"];', file_get_contents(DIR_CATALOG . 'model/extension/' . $this->type . '/' . $this->name . '.php')));
		}
		
		// Set save type and skip auto-backup if not needed
		if (!empty($data['saved']['autosave'])) {
			$data['save_type'] = 'auto';
		}
		
		if ($backup_type == 'auto' && empty($data['autobackup'])) {
			return;
		}
		
		// Create settings auto-backup file
		$manual_filepath = DIR_LOGS . $this->name . $this->encryption_key . '.backup';
		$auto_filepath = DIR_LOGS . $this->name . $this->encryption_key . '.autobackup';
		$filepath = ($backup_type == 'auto') ? $auto_filepath : $manual_filepath;
		if (file_exists($filepath)) unlink($filepath);
		
		if ($this->columns == 3) {
			file_put_contents($filepath, 'EXTENSION	SETTING	VALUE' . "\n", FILE_APPEND|LOCK_EX);
		} elseif ($this->columns == 5) {
			file_put_contents($filepath, 'EXTENSION	SETTING	NUMBER	SUB-SETTING	VALUE' . "\n", FILE_APPEND|LOCK_EX);
		} else {
			file_put_contents($filepath, 'EXTENSION	SETTING	NUMBER	SUB-SETTING	SUB-NUMBER	SUB-SUB-SETTING	VALUE' . "\n", FILE_APPEND|LOCK_EX);
		}
		
		foreach ($data['saved'] as $key => $value) {
			if (is_array($value)) continue;
			
			$parts = explode('|', preg_replace(array('/_(\d+)_/', '/_(\d+)/'), array('|$1|', '|$1'), $key));
			
			$line = $this->name . "\t" . $parts[0] . "\t";
			for ($i = 1; $i < $this->columns - 2; $i++) {
				$line .= (isset($parts[$i]) ? $parts[$i] : '') . "\t";
			}
			$line .= str_replace(array("\t", "\n"), array('    ', '\n'), $value) . "\n";
			
			file_put_contents($filepath, $line, FILE_APPEND|LOCK_EX);
		}
		
		$data['autobackup_time'] = date('Y-M-d @ g:i a');
		$data['backup_time'] = (file_exists($manual_filepath)) ? date('Y-M-d @ g:i a', filemtime($manual_filepath)) : '';
		
		if ($backup_type == 'manual') {
			echo $data['autobackup_time'];
		}
	}
	
	public function saveSettings() {
		if (!$this->user->hasPermission('modify', $this->em . '/' . $this->name)) {
			echo 'PermissionError';
			return;
		}
		
		if ($this->request->get['saving'] == 'manual') {
			$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `code` = '" . $this->db->escape($this->name) . "' AND `key` != '" . $this->db->escape($this->name . '_module') . "'");
		}
		
		$module_id = 0;
		$modules = array();
		foreach ($this->request->post as $key => $value) {
			if (strpos($key, 'module_') === 0) {
				$parts = explode('_', $key, 3);
				$module_id = $parts[1];
				$modules[$parts[1]][$parts[2]] = $value;
			} else {
				if ($this->request->get['saving'] == 'auto') {
					$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `code` = '" . $this->db->escape($this->name) . "' AND `key` = '" . $this->db->escape($this->name . '_' . $key) . "'");
				}
				$this->db->query("
					INSERT INTO " . DB_PREFIX . "setting SET
					`store_id` = 0,
					`code` = '" . $this->db->escape($this->name) . "',
					`key` = '" . $this->db->escape($this->name . '_' . $key) . "',
					`value` = '" . $this->db->escape(stripslashes(is_array($value) ? implode(';', $value) : $value)) . "',
					`serialized` = 0
				");
			}
		}
		
		
			foreach ($modules as $module_id => $module) {
				if (!$module_id) {
					$this->db->query("
						INSERT INTO " . DB_PREFIX . "module SET
						`name` = '" . $this->db->escape($module['name']) . "',
						`code` = '" . $this->db->escape($this->name) . "',
						`setting` = ''
					");
					$module_id = $this->db->getLastId();
					$module['module_id'] = $module_id;
				}
				$module_settings = json_encode($module);
				$this->db->query("
					UPDATE " . DB_PREFIX . "module SET
					`name` = '" . $this->db->escape($module['name']) . "',
					`code` = '" . $this->db->escape($this->name) . "',
					`setting` = '" . $this->db->escape($module_settings) . "'
					WHERE module_id = " . (int)$module_id . "
				");
			}
		
	}
	
	public function deleteSetting() {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `code` = '" . $this->db->escape($this->name) . "' AND `key` = '" . $this->db->escape($this->name . '_' . str_replace('[]', '', $this->request->get['setting'])) . "'");
	}
	
	//==============================================================================
	// Ajax functions
	//==============================================================================
	public function copyModule() {

			$module_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE module_id = " . (int)$this->request->get['module_id']);
			$module_settings = json_decode($module_query->row['setting'], true);
			$module_settings['name'] .= ' (Copy)';
			$this->db->query("INSERT INTO " . DB_PREFIX . "module SET `name` = '" . $this->db->escape($module_settings['name']) . "', `code` = '" . $this->db->escape($this->name) . "', setting = '" . $this->db->escape(json_encode($module_settings)) . "'");
		
	}
	
	public function deleteModule() {

		$this->db->query("DELETE FROM " . DB_PREFIX . "module WHERE module_id = " . (int)$this->request->get['module_id']);
		
	}
}
?>
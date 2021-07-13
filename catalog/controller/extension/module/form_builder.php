<?php
class ControllerExtensionModuleFormBuilder extends Controller {
	private $type = 'extension/module';
	private $name = 'form_builder';
	private $copy = 'information';
	
	public function index($settings) {
		$data['type'] = $this->type;
		$data['name'] = $this->name;
		$data = array_merge($data, $this->load->language($this->type . '/' . $this->copy));
		
		// Load needed data
		$data['session_data'] = (isset($this->session->data[$this->name])) ? $this->session->data[$this->name] : array();
		$data['store_id'] = $this->config->get('config_store_id');
		$data['language'] = $this->session->data['language'];
		$data['customer_group_id'] = (int)$this->customer->getGroupId();
		$data['currency'] = $this->session->data['currency'];
		
		// Restrictions check
		if (empty($settings) ||
			empty($settings['status']) ||
			!array_intersect(array($data['store_id']), $settings['stores']) ||
			!array_intersect(array($data['language']), $settings['languages']) ||
			!array_intersect(array($data['customer_group_id']), $settings['customer_groups']) ||
			!array_intersect(array($data['currency']), $settings['currencies'])
		) {
			return;
		}
		
		// Parse settings
		$data['settings'] = array();
		foreach ($settings as $key => $value) {
			$split_key = preg_split('/_(\d+)_?/', $key, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);
				if (count($split_key) == 1)	$data['settings'][$split_key[0]] = $value;
			elseif (count($split_key) == 2)	$data['settings'][$split_key[0]][$split_key[1]] = $value;
			elseif (count($split_key) == 3)	$data['settings'][$split_key[0]][$split_key[1]][$split_key[2]] = $value;
			elseif (count($split_key) == 4)	$data['settings'][$split_key[0]][$split_key[1]][$split_key[2]][$split_key[3]] = $value;
			else 							$data['settings'][$split_key[0]][$split_key[1]][$split_key[2]][$split_key[3]][$split_key[4]] = $value;
		}
		
		// Sort fields
		$sort_order = array();
		foreach ($data['settings']['field'] as $key => $value) $sort_order[$key] = $value['sort_order'];
		array_multisort($sort_order, SORT_ASC, $data['settings']['field']);
		
		// Render
		$template_file =  $this->type . '/' . $this->name;
		return $this->load->view($template_file, $data);
		
	}
	
	//==============================================================================
	// Public functions
	//==============================================================================
	public function submitForm() {
		if (empty($this->request->post) || !$this->config->get($this->name . '_status')) {
			return;
		}
		
		// Get form data
		$this->load->model('extension/module');
		$form = $this->model_extension_module->getModule($this->request->get['module_id']);
		
		$settings = array();
		foreach ($form as $key => $value) {
			$split_key = preg_split('/_(\d+)_?/', $key, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);
				if (count($split_key) == 1)	$settings[$split_key[0]] = $value;
			elseif (count($split_key) == 2)	$settings[$split_key[0]][$split_key[1]] = $value;
			elseif (count($split_key) == 3)	$settings[$split_key[0]][$split_key[1]][$split_key[2]] = $value;
			elseif (count($split_key) == 4)	$settings[$split_key[0]][$split_key[1]][$split_key[2]][$split_key[3]] = $value;
			else 							$settings[$split_key[0]][$split_key[1]][$split_key[2]][$split_key[3]][$split_key[4]] = $value;
		}
		
		$language = (isset($this->session->data['language'])) ? $this->session->data['language'] : $this->config->get('config_language');
		$store_name = $this->config->get('config_name');
		if (is_array($store_name)) $store_name = array_shift($store_name);
		
		// Set up e-mail
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		
		
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');			
		
		
		// Put together responses
		$customer_emails = array();
		$admin_response_list = '';
		$customer_response_list = '';
		
		$replace = array(
			'[store_name]',
			'[store_url]',
			'[store_owner]',
			'[store_address]',
			'[store_email]',
			'[store_telephone]',
			'[store_fax]',
			'[customer_ip]',
			'[current_date]',
			'[current_time]',
			'[form_name]',
		);
		$with = array(
			$store_name,
			($this->config->get('config_url') ? $this->config->get('config_url') : HTTP_SERVER),
			$this->config->get('config_name'),
			$this->config->get('config_address'),
			$this->config->get('config_email'),
			$this->config->get('config_telephone'),
			$this->config->get('config_fax'),
			$this->db->escape($this->request->server['REMOTE_ADDR']),
			date($this->language->get('date_format_short')),
			date($this->language->get('time_format')),
			$settings['heading_' . $language],
		);
		
		foreach ($settings['field'] as $field) {
			$key = $this->name . '_' . $this->request->get['module_id'] . '-' . $field['sort_order'];
			$response = (isset($this->request->post[$key])) ? $this->request->post[$key] : '';
			
			if ($field['type'] == 'email' && !empty($response)) {
				$customer_emails[] = trim($response);
			}
			
			$response_string = (is_array($response)) ? nl2br(implode(', ', $response)) : nl2br($response);
			$field_title = strip_tags(html_entity_decode($field['title_' . $language], ENT_QUOTES, 'UTF-8'));
			$response_list_line = '<tr><td style="white-space: nowrap"><strong>' . $field_title . (strpos($field_title, ':') === false ? ':' : '') . '</strong></td> <td>' . $response_string . '</td></tr>' . "\n";
			
			$admin_response_list .= $response_list_line;
			if ($field['type'] != 'email') {
				$customer_response_list .= $response_list_line;
			}
		}
		
		// Send out e-mails
		$admin_emails = array_map('trim', explode(',', $settings['admin_email']));
		$html = html_entity_decode($settings['admin_message_' . $language], ENT_QUOTES, 'UTF-8');
		$html = str_replace($replace, $with, $html);
		$html = str_replace('[form_responses]', '<table>' . $admin_response_list . '</table>', $html);
		
		$mail->setFrom(!empty($customer_emails) ? $customer_emails[0] : $admin_emails[0]);
		$mail->setReplyTo(!empty($customer_emails) ? $customer_emails[0] : $admin_emails[0]);
		$mail->setSender(!empty($customer_emails) ? $customer_emails[0] : str_replace(array(',', '&'), array('', 'and'), html_entity_decode($store_name, ENT_QUOTES, 'UTF-8')));
		$mail->setSubject(str_replace($replace, $with, $settings['admin_subject_' . $language]));
		$mail->setHtml($html);
		$mail->setText(strip_tags($html));
		
		foreach ($admin_emails as $email) {
			$mail->setTo($email);
			$mail->send();
		}
		
		if (!empty($customer_emails) && $settings['customer_email']) {
			$html = html_entity_decode($settings['customer_message_' . $language], ENT_QUOTES, 'UTF-8');
			$html = str_replace($replace, $with, $html);
			$html = str_replace('[form_responses]', '<table>' . $customer_response_list . '</table>', $html);
			
			$mail->setFrom($admin_emails[0]);
			$mail->setReplyTo($admin_emails[0]);
			$mail->setSender(str_replace(array(',', '&'), array('', 'and'), html_entity_decode($store_name, ENT_QUOTES, 'UTF-8')));
			$mail->setSubject(str_replace($replace, $with, $settings['customer_subject_' . $language]));
			$mail->setHtml($html);
			$mail->setText(strip_tags($html));
			
			foreach ($customer_emails as $email) {
				$mail->setTo($email);
				$mail->send();
			}
		}
	}
}
?>
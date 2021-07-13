<?php
class ControllerTestimonialConfiguration extends Controller {
	private $error = array();
	private $moduleName 			= 'testimonial';
	private $moduleModel 			= 'model_extension_module_testimonial';
	private $moduleModelPath 		= 'extension/module/testimonial';
	private $modulePath 			= 'testimonial/configuration';
	private $moduleVersion 			= '1.3.4';

	public function index() {
		$this->document->addStyle('view/stylesheet/testimonial.css');
		$lang_ar = $this->load->language($this->modulePath);
		foreach($lang_ar as $key => $item){
			$data[$key] = $item;
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/store');

		$this->load->model($this->moduleModelPath);

		if(!$this->{$this->moduleModel}->getTableExist('vs_testimonial')){
			$data['install'] =$this->url->link('extension/extension/module/install', 'token=' . $this->session->data['token'] . '&extension=testimonial', 'SSL');
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');

			if(substr(VERSION, 0, 7) > '2.1.0.2'){
				return $this->response->setOutput($this->load->view('testimonial/install', $data));
			} else {
				return $this->response->setOutput($this->load->view('testimonial/install.tpl', $data));
			}
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_title'),
			'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['stores'] = array();

		$this->load->model('tool/image');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$image = $this->model_tool_image->resize($this->config->get('config_logo'), 40, 40);
		} else {
			$image = $this->model_tool_image->resize('no_image.png', 40, 40);
		}

		$data['stores'][] = array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name') . $this->language->get('text_default'),
			'url'      => HTTP_CATALOG,
			'image'    => $image,
			'edit'     => $this->url->link($this->modulePath . '/edit', 'token=' . $this->session->data['token']. '&store_id=0', 'SSL')
		);

		$results = $this->model_setting_store->getStores();
		$this->load->model('setting/setting');

		foreach ($results as $result) {
			$store_info = $this->model_setting_setting->getSetting('config', $result['store_id']);
			if (is_file(DIR_IMAGE . $store_info['config_logo'])) {
				$image = $this->model_tool_image->resize($store_info['config_logo'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 40, 40);
			}
			$data['stores'][] = array(
				'store_id' => $result['store_id'],
				'name'     => $result['name'],
				'url'      => $result['url'],
				'image'    => $image,
				'edit'     => $this->url->link($this->modulePath . '/edit', 'token=' . $this->session->data['token'] . '&store_id=' . $result['store_id'], 'SSL')
			);
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if(substr(VERSION, 0, 7) > '2.1.0.2'){
			$this->response->setOutput($this->load->view('testimonial/store_list', $data));
		} else {
			$this->response->setOutput($this->load->view('testimonial/store_list.tpl', $data));
		}
	}

	public function edit() {
		$this->document->addStyle('view/stylesheet/testimonial.css');
		$lang_ar = $this->load->language($this->modulePath);
		foreach($lang_ar as $key => $item){
			$data[$key] = $item;
		}
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model($this->moduleModelPath);

		if(!$this->{$this->moduleModel}->getTableExist('vs_testimonial')){
			$data['install'] =$this->url->link('extension/extension/module/install', 'token=' . $this->session->data['token'] . '&extension=testimonial', 'SSL');
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');

			if(substr(VERSION, 0, 7) > '2.1.0.2'){
				return $this->response->setOutput($this->load->view('testimonial/install', $data));
			} else {
				return $this->response->setOutput($this->load->view('testimonial/install.tpl', $data));
			}
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->moduleName, $this->request->post, $this->request->get['store_id']);

			if(!$this->request->get['store_id']){
				$this->{$this->moduleModel}->editUrl($this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			if(!$this->request->post['apply']){
				$this->response->redirect($this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['keyword'])) {
			$data['error_keyword'] = $this->error['keyword'];
		} else {
			$data['error_keyword'] = '';
		}

		if (isset($this->error['image'])) {
			$data['error_image'] = $this->error['image'];
		} else {
			$data['error_image'] = '';
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_title'),
			'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_edit'),
			'href' => $this->url->link($this->modulePath . '/edit', 'token=' . $this->session->data['token'] . '&store_id=' . $this->request->get['store_id'], 'SSL')
		);

		$data['cancel'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL');

		$data['notification'] = $this->url->link('extension/module/testimonial/getNotification', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->get['store_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$this->load->model('setting/setting');

			$store_info = $this->model_setting_setting->getSetting($this->moduleName, $this->request->get['store_id']);
			foreach ($store_info as $key => $item){
				if (isset($store_info[$key])) {
					$data[$key] = $store_info[$key];
				}
			}
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		foreach ($this->request->post as $key => $item){
			if (isset($item)) {
				$data[$key] = $item;
			}
		}

		if(!$this->request->get['store_id']){
			if (isset($this->request->post['keyword'])) {
				$data['keyword'] = $this->request->post['keyword'];
			} else {
				$data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
			}	
		}

		if (isset($this->request->get['store_id'])){
			$data['store_id'] = $this->request->get['store_id'];
		} else {
			$data['store_id'] = 0;
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['testimonial_default_image']) && is_file(DIR_IMAGE . $this->request->post['testimonial_default_image'])) {
			$data['thumb'] = $this->model_tool_image->resize($this->request->post['testimonial_default_image'], 100, 100);
		} elseif (isset($store_info['testimonial_default_image']) && is_file(DIR_IMAGE . $store_info['testimonial_default_image'])) {
			$data['thumb'] = $this->model_tool_image->resize($store_info['testimonial_default_image'], 100, 100);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);


		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if(substr(VERSION, 0, 7) > '2.1.0.2'){
			$this->response->setOutput($this->load->view($this->modulePath, $data));
		} else {
			$this->response->setOutput($this->load->view($this->modulePath . '.tpl', $data));
		}
	}

	protected function validate() {

		if (isset($this->request->get['store_id']) && !$this->request->get['store_id'] && utf8_strlen($this->request->post['keyword']) > 0) {
			$this->load->model($this->moduleModelPath);

			$url_alias_info = $this->{$this->moduleModel}->getUrlAlias($this->request->post['keyword']);

			if ($url_alias_info && $url_alias_info['query'] != 'testimonial/testimonial') {
				$this->error['keyword'] = sprintf($this->language->get('error_keyword'));
			}
		}

		if (!$this->user->hasPermission('modify', $this->modulePath)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
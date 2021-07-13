<?php
class ControllerTestimonialTestimonial extends Controller {
	private $error = array();
	private $moduleName 			= 'testimonial';
	private $moduleModel 			= 'model_extension_module_testimonial';
	private $moduleModelPath 		= 'extension/module/testimonial';
	private $modulePath 			= 'testimonial/testimonial';
	private $moduleVersion 			= '1.3.4';

	public function index() {
		$this->document->addStyle('view/stylesheet/testimonial.css');
		$lang_ar = $this->load->language($this->modulePath);

		foreach($lang_ar as $key => $item){
			$data[$key] = $item;
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model($this->moduleModelPath);

		if(!$this->{$this->moduleModel}->getTableExist('vs_testimonial')){
			$data['text_install_module'] = $this->language->get('text_install_module');
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

		if (isset($this->request->get['filter_store'])) {
			$filter_store = $this->request->get['filter_store'];
		} else {
			$filter_store = null;
		}

		if (isset($this->request->get['filter_language'])) {
			$filter_language = $this->request->get['filter_language'];
		} else {
			$filter_language = null;
		}

		if (isset($this->request->get['filter_rating'])) {
			$filter_rating = $this->request->get['filter_rating'];
		} else {
			$filter_rating = null;
		}

		if (isset($this->request->get['filter_author'])) {
			$filter_author = $this->request->get['filter_author'];
		} else {
			$filter_author = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'r.date_added';
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}

		if (isset($this->request->get['filter_language'])) {
			$url .= '&filter_language=' . $this->request->get['filter_language'];
		}

		if (isset($this->request->get['filter_rating'])) {
			$url .= '&filter_rating=' . $this->request->get['filter_rating'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link($this->modulePath . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link($this->modulePath . '/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['heading_title'] = $this->language->get('heading_title');

		if($count_reviews = $this->{$this->moduleModel}->getPreviousVersion()){
			$data['text_confirm_remove'] = $this->language->get('text_confirm_remove');
			$data['text_import'] = sprintf($this->language->get('text_import'), $count_reviews);
			$data['href_import'] = $this->url->link($this->modulePath . '/import', 'token=' . $this->session->data['token'] . '&type=1', 'SSL');
		}

		if($count_reviews = $this->{$this->moduleModel}->getStoreReviews()){
			$data['text_confirm_remove_sr'] = $this->language->get('text_confirm_remove_sr');
			$data['text_import_sr'] = sprintf($this->language->get('text_import_sr'), $count_reviews);
			$data['href_import_sr'] = $this->url->link($this->modulePath . '/import', 'token=' . $this->session->data['token'] . '&type=2', 'SSL');
		}

		$data['testimonials'] = array();

		$filter_data = array(
			'filter_store'      => $filter_store,
			'filter_language'   => $filter_language,
			'filter_rating'     => $filter_rating,
			'filter_author'     => $filter_author,
			'filter_status'     => $filter_status,
			'filter_date_added' => $filter_date_added,
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);

		$this->load->model('tool/image');

		$testimonial_total = $this->{$this->moduleModel}->getTotalTestimonials($filter_data);

		$results = $this->{$this->moduleModel}->getTestimonials($filter_data);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 40, 40);
			}

			$data['testimonials'][] = array(
				'testimonial_id'  => $result['testimonial_id'],
				'customer'   => $result['customer_id']? '<i style="color:#63B8FF;" class="fa fa-user"></i> ' : '',
				'image'      => $image,
				'author'     => $result['author'],
				'text'       => utf8_substr(strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
				'rating'     => $result['rating'],
				'status'     => ($result['status']) ? '<i style="color:#00CD00;" class="fa fa-check"></i>' : '<i style="color:#EE0000;" class="fa fa-minus"></i>',
				'date_added' => date($this->language->get('date_format_long'), strtotime($result['date_added'])),
				'edit'       => $this->url->link($this->modulePath . '/edit', 'token=' . $this->session->data['token'] . '&testimonial_id=' . $result['testimonial_id'] . $url, 'SSL')
			);
		}

		$data['token'] = $this->session->data['token'];

		$data['action'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('setting/store');

		$data['stores'] = $this->model_setting_store->getStores();

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

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

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_author'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&sort=r.author' . $url, 'SSL');
		$data['sort_rating'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&sort=r.rating' . $url, 'SSL');
		$data['sort_status'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&sort=r.status' . $url, 'SSL');
		$data['sort_date_added'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&sort=r.date_added' . $url, 'SSL');

		$url = '';
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}

		if (isset($this->request->get['filter_language'])) {
			$url .= '&filter_language=' . $this->request->get['filter_language'];
		}

		if (isset($this->request->get['filter_rating'])) {
			$url .= '&filter_rating=' . $this->request->get['filter_rating'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $testimonial_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($testimonial_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($testimonial_total - $this->config->get('config_limit_admin'))) ? $testimonial_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $testimonial_total, ceil($testimonial_total / $this->config->get('config_limit_admin')));

		$data['filter_store'] = $filter_store;
		$data['filter_language'] = $filter_language;
		$data['filter_rating'] = $filter_rating;
		$data['filter_author'] = $filter_author;
		$data['filter_status'] = $filter_status;
		$data['filter_date_added'] = $filter_date_added;

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if(substr(VERSION, 0, 7) > '2.1.0.2'){
			$this->response->setOutput($this->load->view($this->modulePath . '_list', $data));
		} else {
			$this->response->setOutput($this->load->view($this->modulePath . '_list.tpl', $data));
		}
	}

	public function add() {
		$this->load->language($this->modulePath);

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model($this->moduleModelPath);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->request->post['user_id'] = $this->user->getId();
			$this->{$this->moduleModel}->addTestimonial($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_rating'])) {
				$url .= '&filter_rating=' . $this->request->get['filter_rating'];
			}

			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language($this->modulePath);

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model($this->moduleModelPath);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->request->post['user_id'] = $this->user->getId();
			$this->{$this->moduleModel}->editTestimonial($this->request->get['testimonial_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_rating'])) {
				$url .= '&filter_rating=' . $this->request->get['filter_rating'];
			}

			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language($this->modulePath);

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model($this->moduleModelPath);

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $testimonial_id) {
				$this->{$this->moduleModel}->deleteTestimonial($testimonial_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_rating'])) {
				$url .= '&filter_rating=' . $this->request->get['filter_rating'];
			}

			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	public function import() {
		if (isset($this->request->get['type'])) {
			$type = $this->request->get['type'];
		} else {
			$type = 0;
		}
		if (isset($this->request->get['delete'])) {
			$delete = $this->request->get['delete'];
		} else {
			$delete = 0;
		}
		$this->load->model($this->moduleModelPath);
		switch ($type){
			case 1:{
				$this->{$this->moduleModel}->importPreviousVersion($delete);
				break;
			}
			case 2:{
				$this->{$this->moduleModel}->importStoreReviews($this->user->getId(),$delete);
				break;
			}
		}

		$this->response->redirect($this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL'));

	}

	protected function getForm() {

		$this->document->addStyle('view/stylesheet/testimonial.css');
		
		$lang_ar = $this->load->language($this->modulePath);

		foreach($lang_ar as $key => $item){
			$data[$key] = $item;
		}

		$data['text_form'] = !isset($this->request->get['testimonial_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['author'])) {
			$data['error_author'] = $this->error['author'];
		} else {
			$data['error_author'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['text'])) {
			$data['error_text'] = $this->error['text'];
		} else {
			$data['error_text'] = '';
		}

		if (isset($this->error['rating'])) {
			$data['error_rating'] = $this->error['rating'];
		} else {
			$data['error_rating'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_rating'])) {
			$url .= '&filter_rating=' . $this->request->get['filter_rating'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['testimonial_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_add'),
				'href' => $this->url->link($this->modulePath . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL')
			);
			$data['action'] = $this->url->link($this->modulePath . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link($this->modulePath . '/edit', 'token=' . $this->session->data['token'] . '&testimonial_id=' . $this->request->get['testimonial_id'] . $url, 'SSL')
			);
			$data['action'] = $this->url->link($this->modulePath . '/edit', 'token=' . $this->session->data['token'] . '&testimonial_id=' . $this->request->get['testimonial_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['testimonial_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$testimonial_info = $this->{$this->moduleModel}->getTestimonial($this->request->get['testimonial_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['image'])) {
			$data['image'] = $this->request->post['image'];
		} elseif (!empty($testimonial_info)) {
			$data['image'] = $testimonial_info['image'];
		} else {
			$data['image'] = '';
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['image']) && is_file(DIR_IMAGE . $this->request->post['image'])) {
			$data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
		} elseif (!empty($testimonial_info) && is_file(DIR_IMAGE . $testimonial_info['image'])) {
			$data['thumb'] = $this->model_tool_image->resize($testimonial_info['image'], 100, 100);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$this->load->model('setting/store');

		$data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['testimonial_store'])) {
			$data['testimonial_store'] = $this->request->post['testimonial_store'];
		} elseif (isset($this->request->get['testimonial_id'])) {
			$data['testimonial_store'] = $this->{$this->moduleModel}->getTestimonialStores($this->request->get['testimonial_id']);
		} else {
			$data['testimonial_store'] = array(0);
		}

		if (isset($this->request->post['testimonial_language'])) {
			$data['testimonial_language'] = $this->request->post['testimonial_language'];
		} elseif (isset($this->request->get['testimonial_id'])) {
			$data['testimonial_language'] = $this->{$this->moduleModel}->getTestimonialLanguages($this->request->get['testimonial_id']);
		} else {
			$data['testimonial_language'] = array(0);
		}


		if (isset($this->request->post['author'])) {
			$data['author'] = $this->request->post['author'];
		} elseif (!empty($testimonial_info)) {
			$data['author'] = $testimonial_info['author'];
		} else {
			$data['author'] = '';
		}

		if (isset($this->request->post['customer'])) {
			$data['customer'] = $this->request->post['customer'];
		} elseif (!empty($testimonial_info)) {
			$data['customer'] = $testimonial_info['customer_id'];
		} else {
			$data['customer'] = 0;
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($testimonial_info)) {
			$data['email'] = $testimonial_info['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['date_added'])) {
			$data['date_added'] = $this->request->post['date_added'];
		} elseif (!empty($testimonial_info)) {
			$data['date_added'] = ($testimonial_info['date_added'] != '0000-00-00') ? $testimonial_info['date_added'] : '';
		} else {
			$data['date_added'] = date('Y-m-d');
		}

		if (isset($this->request->post['text'])) {
			$data['text'] = $this->request->post['text'];
		} elseif (!empty($testimonial_info)) {
			$data['text'] = $testimonial_info['text'];
		} else {
			$data['text'] = '';
		}

		if (isset($this->request->post['reply'])) {
			$data['reply'] = $this->request->post['reply'];
		} elseif (!empty($testimonial_info)) {
			$data['reply'] = $testimonial_info['reply'];
		} else {
			$data['reply'] = '';
		}

		if (isset($this->request->post['rating'])) {
			$data['rating'] = $this->request->post['rating'];
		} elseif (!empty($testimonial_info)) {
			$data['rating'] = $testimonial_info['rating'];
		} else {
			$data['rating'] = '';
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($testimonial_info)) {
			$data['status'] = $testimonial_info['status'];
		} else {
			$data['status'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		if(substr(VERSION, 0, 7) > '2.1.0.2'){
			$this->response->setOutput($this->load->view($this->modulePath . '_form', $data));
		} else {
			$this->response->setOutput($this->load->view($this->modulePath . '_form.tpl', $data));
		}
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', $this->modulePath)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 64)) {
			$this->error['author'] = $this->language->get('error_author');
		}

		if (utf8_strlen($this->request->post['text']) < 1) {
			$this->error['text'] = $this->language->get('error_text');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', $this->modulePath)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
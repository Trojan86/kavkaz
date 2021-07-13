<?php
class ControllerTestimonialLanguage extends Controller {
	private $error = array();
	private $moduleName 			= 'testimonial';
	private $moduleModel 			= 'model_extension_module_testimonial';
	private $moduleModelPath 		= 'extension/module/testimonial';
	private $modulePath 			= 'testimonial/language';
	private $moduleVersion 			= '1.3.4';

	public function index() {
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

		$data['cancel'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL');

		$data['variables'] = $this->url->link($this->modulePath . '/getVariables', 'token=' . $this->session->data['token'], 'SSL');

		$data['save'] = $this->url->link($this->modulePath . '/saveTranslate', 'token=' . $this->session->data['token'], 'SSL');

		$data['reset'] = $this->url->link($this->modulePath . '/resetTranslate', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

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
			$this->response->setOutput($this->load->view('testimonial/language', $data));
		} else {
			$this->response->setOutput($this->load->view('testimonial/language.tpl', $data));
		}
	}

	public function getVariables()
	{
		$json = array();

		$lang_ar = $this->load->language($this->modulePath);

		foreach($lang_ar as $key => $item){
			if (strpos($key, 'entry_') !== false) {
				$json['entry'][$key] = $item;
			}
		}

		$json['default'] = $this->getDefaultVariables();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			$path = DIR_CATALOG . 'language/en-gb/extension/module/testimonial.php';

			if(isset($this->request->post['language']) && file_exists(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php')){
				$path = DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php';
			}

			if(file_exists($path)) {

				require($path);

				$vars = get_defined_vars();

				if(isset($vars['_'])){
					foreach ($vars['_'] as $key => $item){
						$json['vars'][$key] = htmlentities($item);
					}
				}
			} else{
				$json['error'] = $this->language->get('error_language_file');
			}
		} else{
			$json['error'] = $this->language->get('error_permission');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));

	}

	public function saveTranslate()
	{
		$this->load->language($this->modulePath);

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->user->hasPermission('modify', $this->modulePath)) {

			if(isset($this->request->post['variable']) && isset($this->request->post['language'])) {
				$variables = $this->request->post['variable'];
				$str = "<?php\r\n";
				foreach ($variables as $key => $variable) {
					$str .= '$_[\'' . $key . '\'] = \'' . addcslashes(html_entity_decode($variable), '\'') . '\';' . "\r\n";
				}

				if (file_exists(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php')) {
					file_put_contents(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php', $str);
				} else {
					if(!file_exists(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module')){
						mkdir(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module', 0755, true);
					}
					file_put_contents(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php', $str);
				}
			}
		} else {
			$json['permission'] = $this->language->get('error_permission');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function resetTranslate()
	{
		$this->load->language($this->modulePath);

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->user->hasPermission('modify', $this->modulePath)) {

			if(isset($this->request->post['language'])) {
				$variables = $this->getDefaultVariables();
				$str = "<?php\r\n";
				foreach ($variables as $key => $variable) {
					$str .= '$_[\'' . $key . '\'] = \'' . addcslashes(html_entity_decode($variable), '\'') . '\';' . "\r\n";
				}

				if (file_exists(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php')) {
					file_put_contents(DIR_CATALOG . 'language/' . $this->request->post['language'] . '/extension/module/testimonial.php', $str);
				}
			}
		} else {
			$json['permission'] = $this->language->get('error_permission');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function getDefaultVariables()
	{
		$output = array(
			'heading_title'      => 'Testimonials',
			'text_from' 	     => 'based on',
			'text_reviews'       => 'reviews',
			'text_sort'          => 'Sort by:',
			'text_limit'         => 'Show:',
			'text_default'       => 'Default',
			'text_rating_desc'   => 'Rating (Highest)',
			'text_rating_asc'    => 'Rating (Lowest)',
			'text_date_desc'     => 'Date Added (Newer)',
			'text_date_asc'      => 'Date Added (Older)',
			'text_write'         => 'Write a review',
			'text_posted'        => 'posted',
			'text_login'         => 'Please <a href="%s">login</a> or <a href="%s">register</a> to review',
			'text_no_reviews'    => 'There are no reviews yet!',
			'text_note'          => '<span class="text-danger">Note:</span> HTML is not translated!',
			'text_success'       => 'Thank you for your review.',
			'text_submit' 		 => 'Thank you for your review. It has been submitted to the administrator for approval.',
			'text_registered'    => 'Registered User',
			'text_purchased'     => 'Reviews only for customers who have purchased something!',
			'text_mail_subject'  => 'You have a new testimonial waiting.',
			'text_mail_title'    => 'You have a new testimonial waiting.',
			'text_mail_reviewer' => 'Reviewer: %s',
			'text_mail_email'    => 'Email: %s',
			'text_mail_rating'   => 'Rating: %s',
			'text_mail_review'   => 'Testimonial Text:',
			'button_continue'    => 'Continue',
			'button_cancel'      => 'Cancel',
			'button_upload'      => 'Choose File',
			'button_list'        => 'List',
			'button_grid'        => 'Grid',
			'button_all'         => 'Show All',
			'entry_name'         => 'Your Name',
			'entry_email'        => 'Your Email',
			'entry_review'       => 'Your Review',
			'entry_image'        => 'Your Photo',
			'entry_choose_image' => 'No file chosen',
			'entry_rating'       => 'Rating',
			'entry_bad'          => 'Bad',
			'entry_good'         => 'Good',
			'error_name'         => 'Warning: Your Name must be between 3 and 25 characters!',
			'error_email'        => 'Warning: E-Mail Address does not appear to be valid!',
			'error_text'         => 'Warning: Your Text must be between 25 and 3000 characters!',
			'error_rating'       => 'Warning: Please select a review rating!',
			'error_captcha'      => 'Warning: Verification code does not match the image!',
			'error_filename'     => 'Warning: Filename must be between 3 and 64 characters!',
			'error_filetype'     => 'Warning: Invalid file type!',
			'error_upload'       => 'Warning: No file chosen!',
			'error_not_installed'=> 'Warning: Testimonials module is not installed!',
		);

		return $output;
	}

	protected function validate() {

		if (!$this->user->hasPermission('modify', $this->modulePath)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
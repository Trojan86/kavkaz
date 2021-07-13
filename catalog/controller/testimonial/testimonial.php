<?php
class ControllerTestimonialTestimonial extends Controller
{
    private $error = array();
    private $moduleName 			= 'testimonial';
    private $moduleModel 			= 'model_extension_module_testimonial';
    private $moduleModelPath 		= 'extension/module/testimonial';
    private $moduleLanguagePath 	= 'extension/module/testimonial';
    private $modulePath 			= 'testimonial/testimonial';
    private $moduleCaptchaPath 		= 'extension/captcha';
    private $moduleVersion 			= '1.3.4';

    public function index()
    {
        $this->load->language($this->moduleLanguagePath);
        $this->load->model($this->moduleModelPath);

        $description = $this->config->get('testimonial_description');

        $data['testimonial_theme'] = $this->config->get('testimonial_theme');

        $data['language_id'] = $this->config->get('config_language_id');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['heading_title'] = isset($description[$data['language_id']]['name']) ? nl2br($description[$data['language_id']]['name']) : $this->language->get('heading_title');

        if($this->{$this->moduleModel}->getTableExist('vs_testimonial')) {

            $this->document->setTitle(isset($description[$data['language_id']]['meta_title']) ? $description[$data['language_id']]['meta_title'] : '');
            $this->document->setDescription(isset($description[$data['language_id']]['meta_description']) ? $description[$data['language_id']]['meta_description'] : '');
            $this->document->setKeywords(isset($description[$data['language_id']]['meta_keyword']) ? $description[$data['language_id']]['meta_keyword'] : '');

            switch ($data['testimonial_theme']) {
                case 1: {
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-boot.css');
                    break;
                }
                case 2: {
                    $this->document->addScript('catalog/view/javascript/bootstrap/js/bootstrap.min.js');
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-boot.css');
                    break;
                }
                case 3: {
                    $this->document->addScript('catalog/view/javascript/testimonial/modal.bootstrap.js');
                    $this->document->addScript('catalog/view/javascript/testimonial/tooltip.bootstrap.js');
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-boot.css');
                    $this->document->addStyle('catalog/view/javascript/font-awesome/css/font-awesome.min.css');
                    break;
                }
                case 4: {
                    $this->document->addScript('catalog/view/javascript/bootstrap/js/bootstrap.min.js');
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-boot.css');
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-pavilion.css');
                    break;
                }
                case 5: {
                    $this->document->addScript('catalog/view/javascript/testimonial/testimonial.journal.js');
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-boot.css');
                    $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-journal.css');
                    break;
                }
                case 6: {

                    break;
                }
            }

            $this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
            $this->document->addScript('catalog/view/javascript/testimonial/testimonial.js');
            $this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/testimonial/testimonial.css')) {
                $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/testimonial/testimonial.css');
            } else {
                $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial.css');
            }

            $data['testimonial_multistore'] = $this->config->get('testimonial_multistore');
            $data['testimonial_multilang'] = $this->config->get('testimonial_multilang');
            $data['testimonial_popup'] = $this->config->get('testimonial_popup');
            $data['text_success'] = $this->language->get('text_success');
            $data['text_submit'] = $this->language->get('text_submit');

            $data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
            $data['action'] = $data['keyword'] ? $data['keyword'] : $this->url->link('testimonial/testimonial');
            $data['keyword'] = $data['action'];
            if (isset($this->request->get['page']) && $this->request->get['page'] != 1) {
                $data['action'] .= '&page=' . $this->request->get['page'];
            }
            $this->session->data['gcapcha'] = '';
            if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
                $data['action'] .= '#alert-success';
                $filename = '';
                if ($this->request->files) {
                    $filename = basename(html_entity_decode($this->request->files['image']['name'], ENT_QUOTES, 'UTF-8'));
                }
                if ($filename) {
                    $file = md5(mt_rand()) . '-' . $filename;
                    if (!file_exists(DIR_IMAGE . 'catalog/testimonials/')) {
                        mkdir(DIR_IMAGE . 'catalog/testimonials/', 0755);
                    }
                    move_uploaded_file($this->request->files['image']['tmp_name'], DIR_IMAGE . 'catalog/testimonials/' . $file);
                }
                if (!isset($this->request->post['email'])) {
                    $this->request->post['email'] = '';
                }

                if (!isset($this->request->post['rating'])) {
                    $this->request->post['rating'] = 0;
                }
                $this->load->model($this->moduleModelPath);
                if ($this->config->get('testimonial_rating') && $this->config->get('testimonial_approve') && $this->request->post['rating'] >= $this->config->get('testimonial_approve')) {
                    $this->request->post['status'] = 1;
                    $this->session->data['success_review'] = $data['text_success'];
                } elseif ($this->config->get('testimonial_approve') == 10) {
                    $this->request->post['status'] = 1;
                    $this->session->data['success_review'] = $data['text_success'];
                } else {
                    $this->request->post['status'] = 0;
                    $this->session->data['success_review'] = $data['text_submit'];
                }

                if ($filename) {
                    $this->request->post['image'] = 'catalog/testimonials/' . $file;
                } else {
                    $this->request->post['image'] = '';
                }

                $this->{$this->moduleModel}->addTestimonial($this->request->post);

                $this->response->redirect($data['action']);
            }

            $data['breadcrumbs'][] = array(
                'text' => $data['heading_title'],
                'href' => $data['keyword']
            );

            $data['testimonial_top'] = $this->load->controller('testimonial/testimonial_top', $this->error);
            $data['testimonial_list'] = $this->load->controller('testimonial/testimonial_list');
            $data['testimonial_bottom'] = $this->load->controller('testimonial/testimonial_bottom', $this->error);
        } else {
            $data['error_not_installed'] = html_entity_decode($this->language->get('error_not_installed'));
        }

        if (isset($this->session->data['success_review'])) {
            $data['success'] = $this->session->data['success_review'];
            unset($this->session->data['success_review']);
        } else {
            $data['success'] = '';
        }

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->response->setOutput($this->load->view('testimonial/testimonial', $data));
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/testimonial/testimonial.tpl', $data));
            }
        }
    }

    protected function validate()
    {
        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
            $this->error['name'] = $this->language->get('error_name');
        }

        if ($this->config->get('testimonial_email_required') && $this->config->get('testimonial_email')) {
            if (!preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
                $this->error['email'] = $this->language->get('error_email');
            }
        }

        if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 3000)) {
            $this->error['text'] = $this->language->get('error_text');
        }

        if ($this->config->get('testimonial_rating_required') && $this->config->get('testimonial_rating')) {
            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $this->error['rating'] = $this->language->get('error_rating');
            }
        }
        if('2.1.0.1'>substr(VERSION, 0, 7)){
            if (!$this->config->get('testimonial_popup') && $this->config->get('config_google_captcha_status') && $this->config->get('testimonial_captcha')) {
                $recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

                $recaptcha = json_decode($recaptcha, true);

                if (!$recaptcha['success']) {
                    $this->error['captcha'] = $this->language->get('error_captcha');
                }
            }
        }else{
            if (!$this->config->get('testimonial_popup') && $this->config->get($this->config->get('config_captcha') . '_status') && in_array('testimonial', (array)$this->config->get('config_captcha_page'))) {
                $captcha = $this->load->controller($this->moduleCaptchaPath . '/' . $this->config->get('config_captcha') . '/validate');

                if ($captcha) {
                    $this->error['captcha'] = $captcha;
                }
            }
        }

        if (!empty($this->request->files['image']['name']) && is_file($this->request->files['image']['tmp_name'])) {

            if($this->config->get('testimonial_file_size') && filesize($this->request->files['image']['tmp_name']) > $this->config->get('testimonial_file_size')) {
                $this->error['image'] = sprintf($this->language->get('error_filesize'),$this->formatBytes($this->config->get('testimonial_file_size')));
            }
        }

        if ($this->config->get('testimonial_image') && $this->config->get('testimonial_image_required')) {
            if (!empty($this->request->files['image']['name']) && is_file($this->request->files['image']['tmp_name'])) {

                $filename = basename(html_entity_decode($this->request->files['image']['name'], ENT_QUOTES, 'UTF-8'));

                if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 128)) {
                    $this->error['image'] = $this->language->get('error_filename');
                }

                $allowed = array();

                $extension_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_ext_allowed'));

                $filetypes = explode("\n", $extension_allowed);

                foreach ($filetypes as $filetype) {
                    $allowed[] = trim($filetype);
                }

                if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
                    $this->error['image'] = $this->language->get('error_filetype');
                }

                $allowed = array();

                $mime_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_mime_allowed'));

                $filetypes = explode("\n", $mime_allowed);

                foreach ($filetypes as $filetype) {
                    $allowed[] = trim($filetype);
                }

                if (!in_array($this->request->files['image']['type'], $allowed)) {
                    $this->error['image'] = $this->language->get('error_filetype');
                }

                $content = file_get_contents($this->request->files['image']['tmp_name']);

                if (preg_match('/\<\?php/i', $content)) {
                    $this->error['image'] =$this->language->get('error_filetype');
                }

                if ($this->request->files['image']['error'] != UPLOAD_ERR_OK) {
                    $this->error['image'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
                }
            } else {
                $this->error['image'] = $this->language->get('error_upload');
            }
        }

        return !$this->error;
    }

    public function getPopupForm()
    {
        $lang_ar = $this->load->language($this->moduleLanguagePath);

        foreach($lang_ar as $key => $item){
            $data[$key] = $item;
        }
        
        $this->load->model($this->moduleModelPath);

        $data['language_id'] = $this->config->get('config_language_id');

        $data['testimonial_email'] = $this->config->get('testimonial_email');
        $data['testimonial_email_required'] = $this->config->get('testimonial_email_required');
        $data['testimonial_rating'] = (int)$this->config->get('testimonial_rating');
        $data['testimonial_rating_required'] = (int)$this->config->get('testimonial_rating_required');
        $data['testimonial_image'] = (int)$this->config->get('testimonial_image');
        $data['testimonial_image_required'] = (int)$this->config->get('testimonial_image_required');
        $data['testimonial_file_size'] = $this->config->get('testimonial_file_size');
        $data['testimonial_stars'] = (int)$this->config->get('testimonial_stars');
        $data['testimonial_captcha'] = (int)$this->config->get('testimonial_captcha');

        $data['error_file_size'] = sprintf($this->language->get('error_filesize'),$this->formatBytes($this->config->get('testimonial_file_size')));

        $data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
        $data['action'] = $data['keyword']?$data['keyword']:$this->url->link('testimonial/testimonial');

        if('2.1.0.1'>substr(VERSION, 0, 7)){
            if ($this->config->get('config_google_captcha_status') && $data['testimonial_captcha']) {
                $data['site_key'] = $this->config->get('config_google_captcha_public');
            } else {
                $data['site_key'] = '';
            }
        } else {
            if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('testimonial', (array)$this->config->get('config_captcha_page'))) {
                $data['captcha'] = $this->load->controller($this->moduleCaptchaPath . '/' . $this->config->get('config_captcha'));
            } else {
                $data['captcha'] = '';
            }
        }

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } else {
            $data['name'] = $this->customer->getFirstName();
        }

        if (isset($this->request->post['email'])) {
            $data['email'] = $this->request->post['email'];
        } else {
            $data['email'] = $this->customer->getEmail();
        }

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            $data['recaptcha_api'] = '';
            $this->response->setOutput($this->load->view('testimonial/testimonial_form_popup', $data));
        }else{
            $data['recaptcha_api'] = '<script src="https://www.google.com/recaptcha/api.js" type="text/javascript"></script>';
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_form_popup.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_form_popup.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/testimonial/testimonial_form_popup.tpl', $data));
            }
        }
    }

    public function ajax_validate()
    {
        $this->load->language($this->moduleLanguagePath);

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {

            if('2.1.0.1'>substr(VERSION, 0, 7)){
                if ($this->config->get('config_google_captcha_status') &&  $this->config->get('testimonial_captcha')) {
                    $recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

                    $recaptcha = json_decode($recaptcha, true);

                    if (!$recaptcha['success']) {
                        $json['error'] = $this->language->get('error_captcha');
                    }
                }
            }else{
                if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('testimonial', (array)$this->config->get('config_captcha_page'))) {
                    $captcha = $this->load->controller($this->moduleCaptchaPath . '/' . $this->config->get('config_captcha') . '/validate');

                    if ($captcha) {
                        $json['error'] = $captcha;
                    }
                }
            }

            if ($this->config->get('testimonial_rating_required') && $this->config->get('testimonial_rating')) {
                if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                    $json['error'] = $this->language->get('error_rating');
                }
            }

            if ($this->config->get('testimonial_image') && $this->config->get('testimonial_image_required')) {
                $filename = $this->request->post['image'];
                if (!empty($filename)) {

                    if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 128)) {
                        $json['error'] = $this->language->get('error_filename');
                    }

                    $allowed = array();

                    $extension_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_ext_allowed'));

                    $filetypes = explode("\n", $extension_allowed);

                    foreach ($filetypes as $filetype) {
                        $allowed[] = trim($filetype);
                    }

                    if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
                        $json['error'] = $this->language->get('error_filetype');
                    }

                } else {
                    $json['error'] = $this->language->get('error_upload');
                }
            }

            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 3000)) {
                $json['error'] = $this->language->get('error_text');
            }

            if ($this->config->get('testimonial_email_required') && $this->config->get('testimonial_email')) {
                if (!preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
                    $json['error'] = $this->language->get('error_email');
                }
            }

            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }

            if (!isset($json['error'])) {
                $json['success'] = 1;
                $this->load->model($this->moduleModelPath);

                if(!isset($this->request->post['rating'])){
                    $this->request->post['rating'] = 0;
                }

                if($this->config->get('testimonial_rating') && $this->config->get('testimonial_approve') && $this->request->post['rating'] >= $this->config->get('testimonial_approve')){
                    $this->request->post['status'] = 1;
                    $this->session->data['success'] = $this->language->get('text_success');
                }else{
                    $this->request->post['status'] = 0;
                    $this->session->data['success'] = $this->language->get('text_submit');
                }
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    protected function formatBytes($bytes, $precision = 2) {
        $units = array('B', 'KB', 'MB', 'GB', 'TB');

        $bytes = max($bytes, 0);
        $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
        $pow = min($pow, count($units) - 1);

        // Uncomment one of the following alternatives
         $bytes /= pow(1024, $pow);
        // $bytes /= (1 << (10 * $pow));

        return round($bytes, $precision) . ' ' . $units[$pow];
    }
}
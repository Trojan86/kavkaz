<?php
class ControllerTestimonialTestimonialPart extends Controller
{
    private $moduleName 			= 'testimonial';
    private $moduleModel 			= 'model_extension_module_testimonial';
    private $moduleModelPath 		= 'extension/module/testimonial';
    private $moduleLanguagePath 	= 'extension/module/testimonial';
    private $modulePath 			= 'testimonial/testimonial_part';
    private $moduleVersion 			= '1.3.4';
    
    public function index($params){
        switch ($params['name']){
            case 'popup' : {
                return $this->popup($params);
            }
            case 'rating' : {
                return $this->rating($params);
            }
            case 'description' : {
                return $this->description($params);
            }
            case 'panel' : {
                return $this->panel($params);
            }
        }
    }

    protected function popup($params)
    {
        $lang_ar = $this->load->language($this->moduleLanguagePath);

        foreach($lang_ar as $key => $item){
            $data[$key] = $item;
        }
        
        $data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));

        $data['language_id'] = $this->config->get('config_language_id');
        $data['module'] = $params['module'];

        $data['testimonial_multistore'] = $this->config->get('testimonial_multistore');
        $data['testimonial_multilang'] = $this->config->get('testimonial_multilang');
        $data['testimonial_popup'] = $this->config->get('testimonial_popup');
        $data['testimonial_email'] = $this->config->get('testimonial_email');
        $data['testimonial_email_required'] = $this->config->get('testimonial_email_required');
        $data['testimonial_rating'] = $this->config->get('testimonial_rating');

        $data['testimonial_rating_required'] = $this->config->get('testimonial_rating_required');
        $data['testimonial_image'] = $this->config->get('testimonial_image');
        $data['testimonial_image_required'] = $this->config->get('testimonial_image_required');
        $data['testimonial_file_size'] = $this->config->get('testimonial_file_size');
        $data['testimonial_stars'] = $this->config->get('testimonial_stars');
        $data['testimonial_captcha'] = $this->config->get('testimonial_captcha');

        $data['error_file_size'] = sprintf($this->language->get('error_filesize'),$this->formatBytes($this->config->get('testimonial_file_size')));

        $data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
        $data['action'] = $data['keyword']?$data['keyword']:$this->url->link('testimonial/testimonial');
        $data['keyword'] = $data['action'];
        if (isset($this->request->get['page']) && $this->request->get['page'] != 1) {
            $data['action'] .= '&page=' . $this->request->get['page'];
        }
        $data['action'] .= '#tm-form';

        switch($this->config->get('testimonial_tm_status')){
            case 1:{
                $data['testimonial_tm_status'] = $this->customer->isLogged();
                break;
            }
            case 2:{
                if($this->customer->getId()) {
                    $data['testimonial_tm_status'] = $this->{$this->moduleModel}->isPurchaser($this->customer->getId());
                } else {
                    $data['testimonial_tm_status'] = false;
                }
                $data['text_login'] = $this->language->get('text_purchased');
                break;
            }
            case 3:{
                $data['testimonial_tm_status'] = false;
                $data['text_login'] = '';
                break;
            }
            default:{
                $data['testimonial_tm_status'] = true;
                break;
            }
        }

        if(substr(VERSION, 0, 7)<'2.1.0.1'){
            if ($this->config->get('config_google_captcha_status') &&  $this->config->get('testimonial_captcha')) {
                $data['site_key'] = $this->config->get('config_google_captcha_public');
            } else {
                $data['site_key'] = '';
            }
        } else {
            if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('testimonial', (array)$this->config->get('config_captcha_page'))) {
                if(substr(VERSION, 0, 7)>'2.2.0.0') {
                    $data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'), $params['error']);
                } else {
                    $data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'), $params['error']);
                }
            } else {
                $data['captcha'] = '';
            }
        }

        if (isset($params['error']['name'])) {
            $data['error_name'] = $params['error']['name'];
        } else {
            $data['error_name'] = '';
        }

        if (isset($params['error']['email'])) {
            $data['error_email'] = $params['error']['email'];
        } else {
            $data['error_email'] = '';
        }

        if (isset($params['error']['text'])) {
            $data['error_text'] = $params['error']['text'];
        } else {
            $data['error_text'] = '';
        }

        if (isset($params['error']['rating'])) {
            $data['error_rating'] = $params['error']['rating'];
        } else {
            $data['error_rating'] = '';
        }

        if (isset($params['error']['captcha'])) {
            $data['error_captcha'] = $params['error']['captcha'];
        } else {
            $data['error_captcha'] = '';
        }

        if (isset($params['error']['image'])) {
            $data['error_image'] = $params['error']['image'];
        } else {
            $data['error_image'] = '';
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

        if (isset($this->request->post['text'])) {
            $data['text'] = $this->request->post['text'];
        } else {
            $data['text'] = '';
        }

        if (isset($this->request->post['rating'])) {
            $data['rating'] = $this->request->post['rating'];
        } else {
            $data['rating'] = '';
        }

        switch ($params['position']){
            case 1:{
                $data['class'] = 'pull-left';
                break;
            }
            case 2:{
                $data['class'] = 'center-block';
                break;
            }
            case 3:{
                $data['class'] = 'pull-right';
                break;
            }
            case 4:{
                $data['class'] = 'pull-left';
                break;
            }
            case 5:{
                $data['class'] = 'center-block';
                break;
            }
            case 6:{
                $data['class'] = 'pull-right';
                break;
            }
            default:{
                $data['class'] = 'pull-right';
            }
        }

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            $data['recaptcha_api'] = '';
            return $this->load->view('testimonial/testimonial_form', $data);
        }else{
            $data['recaptcha_api'] = '<script src="https://www.google.com/recaptcha/api.js" type="text/javascript"></script>';
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_form.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_form.tpl', $data);
            } else {
                return $this->load->view('default/template/testimonial/testimonial_form.tpl', $data);
            }
        }
    }

    protected function rating($params)
    {

        $this->load->language($this->moduleLanguagePath);
        $this->load->model($this->moduleModelPath);

        $data['language_id'] = $this->config->get('config_language_id');

        $data['testimonial_multistore'] = $this->config->get('testimonial_multistore');
        $data['testimonial_multilang'] = $this->config->get('testimonial_multilang');
        $data['testimonial_stars'] = (int)$this->config->get('testimonial_stars');

        $data['text_from'] = $this->language->get('text_from');
        $data['text_reviews'] = $this->language->get('text_reviews');

        $reviews_rating = $this->{$this->moduleModel}->getAggregateRating($data['testimonial_multistore'], $data['testimonial_multilang']);

        $data['reviews_rating_total'] = $reviews_rating['total'];
        $data['reviews_rating_average'] =  round($reviews_rating['average'],1);
        $data['reviews_rating'] = 100/5*$reviews_rating['average'];

        switch ($params['position']){
            case 1:{
                $data['class'] = 'text-left';
                break;
            }
            case 2:{
                $data['class'] = 'text-center';
                break;
            }
            case 3:{
                $data['class'] = 'text-right';
                break;
            }
            case 4:{
                $data['class'] = 'text-left';
                break;
            }
            case 5:{
                $data['class'] = 'text-center';
                break;
            }
            case 6:{
                $data['class'] = 'text-right';
                break;
            }
            default:{
                $data['class'] = 'text-left';
            }
        }

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->load->view('testimonial/testimonial_rating', $data);
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_rating.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_rating.tpl', $data);
            } else {
                return $this->load->view('default/template/testimonial/testimonial_rating.tpl', $data);
            }
        }
    }

    protected function description()
    {
        $description = $this->config->get('testimonial_description');
        $data['language_id'] = $this->config->get('config_language_id');

        $data['description'] = html_entity_decode($description[$data['language_id']]['description'], ENT_QUOTES, 'UTF-8');

        if (isset($this->request->get['page']) && $this->request->get['page'] != 1) {
            $data['description'] = '';
        }

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->load->view('testimonial/testimonial_description', $data);
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_description.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_description.tpl', $data);
            } else {
                return $this->load->view('default/template/testimonial/testimonial_description.tpl', $data);
            }
        }
    }

    protected function panel()
    {
        $lang_ar = $this->load->language($this->moduleLanguagePath);

        foreach($lang_ar as $key => $item){
            $data[$key] = $item;
        }

        $this->load->model($this->moduleModelPath);

        $data['language_id'] = $this->config->get('config_language_id');

        $data['testimonial_sort'] = $this->config->get('testimonial_sort');
        $data['testimonial_count'] = $this->config->get('testimonial_count');
        
        $data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
        $data['action'] = $data['keyword']?$data['keyword']:$this->url->link('testimonial/testimonial');
        $data['keyword'] = $data['action'];

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'DESC';
        }

        if (isset($this->request->get['limit']) && $this->request->get['limit']) {
            $limit = $this->request->get['limit'];
        } elseif($this->config->get('testimonial_limit')) {
            $limit = $this->config->get('testimonial_limit');
        } else {
            $limit = 4;
        }

        $url = '';

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $data['sorts'] = array();

        $data['sorts'][] = array(
            'text'  => $this->language->get('text_default'),
            'value' => 'p.sort_order-ASC',
            'href'  => $data['keyword'] . $url
        );

        $data['sorts'][] = array(
            'text'  => $this->language->get('text_rating_desc'),
            'value' => 'r.rating-DESC',
            'href'  => $data['keyword'] . $url . '&sort=r.rating&order=DESC'
        );

        $data['sorts'][] = array(
            'text'  => $this->language->get('text_rating_asc'),
            'value' => 'r.rating-ASC',
            'href'  => $data['keyword'] . $url . '&sort=r.rating&order=ASC'
        );

        $data['sorts'][] = array(
            'text'  => $this->language->get('text_date_desc'),
            'value' => 'r.date_added-DESC',
            'href'  => $data['keyword'] . $url . '&sort=r.date_added&order=DESC'
        );

        $data['sorts'][] = array(
            'text'  => $this->language->get('text_date_asc'),
            'value' => 'r.date_added-ASC',
            'href'  => $data['keyword'] . $url . '&sort=r.date_added&order=ASC'
        );
        
        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $data['limits'] = array();

        $limits = array_unique(array($this->config->get('testimonial_limit'), 8, 16, 32, 64));

        sort($limits);

        foreach($limits as $value) {
            $data['limits'][] = array(
                'text'  => $value,
                'value' => $value,
                'href'  => $data['keyword'] . $url . '&limit=' . $value
            );
        }

        $data['sort'] = $sort;
        $data['order'] = $order;
        $data['limit'] = $limit;

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->load->view('testimonial/testimonial_panel', $data);
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_panel.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_panel.tpl', $data);
            } else {
                return $this->load->view('default/template/testimonial/testimonial_panel.tpl', $data);
            }
        }
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
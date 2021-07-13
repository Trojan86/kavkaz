<?php

class ControllerExtensionModuleTestimonial extends Controller
{
    private $error = array();
    private $moduleName 			= 'testimonial';
    private $moduleModel 			= 'model_extension_module_testimonial';
    private $modulePath 			= 'extension/module/testimonial';
    private $moduleVersion 			= '1.3.4';

    public function index()
    {
        $data['moduleName'] 		= $this->moduleName;
        $data['moduleModel']		= $this->moduleModel;

        $this->document->addStyle('view/stylesheet/testimonial.css');

        $lang_ar = $this->load->language($this->modulePath);

        foreach($lang_ar as $key => $item){
            $data[$key] = $item;
        }
        
        $this->load->model($this->modulePath);

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('extension/module');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule($this->moduleName, $this->request->post);
                $module_id =  $this->db->getLastId();
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
                $module_id =  $this->request->get['module_id'];
            }

            $this->session->data['success'] = $this->language->get('text_success');

            if(!$this->request->post['apply']){
                $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
            }else{
                $this->response->redirect($this->url->link($this->modulePath, 'token='. $this->session->data['token'] . '&module_id=' . $module_id , 'SSL'));
            }
        }

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL')
        );

        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title') . ' ' . $this->moduleVersion,
                'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL')
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'). ' ' . $this->moduleVersion,
                'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
            );
        }

        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
        }

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');

        $data['notification'] = $this->url->link($this->modulePath . '/getNotification', 'token=' . $this->session->data['token'], 'SSL');

        $data['autocomplete'] = $this->url->link($this->modulePath . '/autoComplete', 'token=' . $this->session->data['token'], 'SSL');

        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }

        if (isset($this->request->post['order'])) {
            $data['order'] = $this->request->post['order'];
        } elseif (!empty($module_info)) {
            $data['order'] = $module_info['order'];
        } else {
            $data['order'] = '';
        }

        $data['token'] = $this->session->data['token'];

        $data['testimonials'] = array();

        if (isset($this->request->post['testimonial'])) {
            $testimonials = $this->request->post['testimonial'];
        } elseif (!empty($module_info['testimonial'])) {
            $testimonials = $module_info['testimonial'];
        } else {
            $testimonials = array();
        }

        if($testimonials) {
            foreach ($testimonials as $testimonial_id) {
                $testimonial_info = $this->{$this->moduleModel}->getTestimonial($testimonial_id);

                if ($testimonial_info) {
                    $data['testimonials'][] = array(
                        'testimonial_id' => $testimonial_info['testimonial_id'],
                        'text' => utf8_substr(strip_tags(html_entity_decode($testimonial_info['text'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                    );
                }
            }
        }


        if (isset($this->request->post['layout_id'])) {
            $data['layout_id'] = $this->request->post['layout_id'];
        } elseif (!empty($module_info)) {
            $data['layout_id'] = $module_info['layout_id'];
        } else {
            $data['layout_id'] = '';
        }

        if (isset($this->request->post['limit'])) {
            $data['limit'] = $this->request->post['limit'];
        } elseif (!empty($module_info)) {
            $data['limit'] = $module_info['limit'];
        } else {
            $data['limit'] = '3';
        }

        if (isset($this->request->post['text_limit'])) {
            $data['text_limit'] = $this->request->post['text_limit'];
        } elseif (!empty($module_info)) {
            $data['text_limit'] = $module_info['text_limit'];
        } else {
            $data['text_limit'] = '100';
        }

        if (isset($this->request->post['text_align'])) {
            $data['text_align'] = $this->request->post['text_align'];
        } elseif (!empty($module_info)) {
            $data['text_align'] = $module_info['text_align'];
        } else {
            $data['text_align'] = 'left';
        }

        if (isset($this->request->post['image'])) {
            $data['image'] = $this->request->post['image'];
        } elseif (!empty($module_info)) {
            $data['image'] = $module_info['image'];
        } else {
            $data['image'] = '1';
        }

        if (isset($this->request->post['image_width'])) {
            $data['image_width'] = $this->request->post['image_width'];
        } elseif (!empty($module_info)) {
            $data['image_width'] = $module_info['image_width'];
        } else {
            $data['image_width'] = '100';
        }

        if (isset($this->request->post['image_height'])) {
            $data['image_height'] = $this->request->post['image_height'];
        } elseif (!empty($module_info)) {
            $data['image_height'] = $module_info['image_height'];
        } else {
            $data['image_height'] = '100';
        }

        if (isset($this->request->post['button_all'])) {
            $data['button_all'] = $this->request->post['button_all'];
        } elseif (!empty($module_info)) {
            $data['button_all'] = $module_info['button_all'];
        } else {
            $data['button_all'] = '1';
        }

        if (isset($this->request->post['multilang'])) {
            $data['multilang'] = $this->request->post['multilang'];
        } elseif (!empty($module_info)) {
            $data['multilang'] = $module_info['multilang'];
        } else {
            $data['multilang'] = '0';
        }

        if (isset($this->request->post['multistore'])) {
            $data['multistore'] = $this->request->post['multistore'];
        } elseif (!empty($module_info)) {
            $data['multistore'] = $module_info['multistore'];
        } else {
            $data['multistore'] = '0';
        }

        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $data['status'] = $module_info['status'];
        } else {
            $data['status'] = '1';
        }

        if (isset($this->request->post['slide_limit'])) {
            $data['slide_limit'] = $this->request->post['slide_limit'];
        } elseif (!empty($module_info)) {
            $data['slide_limit'] = $module_info['slide_limit'];
        } else {
            $data['slide_limit'] = '1';
        }

        if (isset($this->request->post['navigation'])) {
            $data['navigation'] = $this->request->post['navigation'];
        } elseif (!empty($module_info)) {
            $data['navigation'] = $module_info['navigation'];
        } else {
            $data['navigation'] = '';
        }

        if (isset($this->request->post['pagination'])) {
            $data['pagination'] = $this->request->post['pagination'];
        } elseif (!empty($module_info)) {
            $data['pagination'] = $module_info['pagination'];
        } else {
            $data['pagination'] = '';
        }

        if (isset($this->request->post['slide_speed'])) {
            $data['slide_speed'] = $this->request->post['slide_speed'];
        } elseif (!empty($module_info)) {
            $data['slide_speed'] = $module_info['slide_speed'];
        } else {
            $data['slide_speed'] = '3000';
        }

        if (isset($this->request->post['module_description'])) {
            $data['module_description'] = $this->request->post['module_description'];
        } elseif (!empty($module_info)) {
            $data['module_description'] = $module_info['module_description'];
        } else {
            $data['module_description'] = '';
        }

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
            $this->response->setOutput($this->load->view($this->modulePath, $data));
        } else {
            $this->response->setOutput($this->load->view($this->modulePath . '.tpl', $data));
        }
    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', $this->modulePath)) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }

        return !$this->error;
    }

    public function autoComplete() {
        $json = array();

        if (isset($this->request->get['filter_text'])) {
            $this->load->model($this->modulePath);

            if (isset($this->request->get['filter_text'])) {
                $filter_text = $this->request->get['filter_text'];
            } else {
                $filter_text = '';
            }

            if (isset($this->request->get['limit'])) {
                $limit = $this->request->get['limit'];
            } else {
                $limit = 5;
            }

            $filter_data = array(
                'filter_text'  => $filter_text,
                'start'        => 0,
                'limit'        => $limit,
                'filter_status'=> 1
            );

            $results = $this->{$this->moduleModel}->getTestimonials($filter_data);

            foreach ($results as $result) {

                $json[] = array(
                    'testimonial_id' => $result['testimonial_id'],
                    'text'       => utf8_substr(strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8')), 0, 100 ). '..',
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function install() {
        $this->load->model('setting/store');
        $this->load->model('setting/setting');
        $this->load->model('localisation/language');
        $this->load->model($this->modulePath);

        $languages = $this->model_localisation_language->getLanguages();
        
        foreach($languages as $lang){
            $tm_description[$lang['language_id']] = array(
                'name'=>'Testimonials',
                'description'=>'',
                'meta_title'=>'Testimonials',
                'meta_description'=>'',
                'meta_keyword'=>'',
            );
        }

        $tm_parts = array(
            array(
                'code'=>'description',
                'position'=>3,
                'sort_order'=>2
            ),
            array(
                'code'=>'rating',
                'position'=>2,
                'sort_order'=>1
            ),
            array(
                'code'=>'popup',
                'position'=>5,
                'sort_order'=>1
            )
        );

        $settings = array(
            'testimonial_tm_status'=>0,
            'testimonial_approve'=>0,
            'testimonial_multilang'=>0,
            'testimonial_multistore'=>0,
            'testimonial_template'=>0,
            'testimonial_theme'=>0,
            'testimonial_sort'=>0,
            'testimonial_count'=>0,
            'testimonial_popup'=>0,
            'testimonial_email'=>0,
            'testimonial_email_required'=>0,
            'testimonial_captcha'=>0,
            'testimonial_date'=>1,
            'testimonial_date_format'=>'d/m/Y',
            'testimonial_registered'=>1,
            'testimonial_registered_color'=>'#999',
            'testimonial_limit'=>4,
            'testimonial_rating'=>1,
            'testimonial_rating_required'=>1,
            'testimonial_stars'=>4,
            'testimonial_icon_color'=>'#FC0',
            'testimonial_icon_border'=>'#E69500',
            'testimonial_icon_size'=>16,
            'testimonial_image'=>0,
            'testimonial_image_required'=>0,
            'testimonial_image_width'=>100,
            'testimonial_image_height'=>100,
            'testimonial_file_size'=>5242880,
            'testimonial_default_image'=>'',
            'testimonial_parts'=>$tm_parts,
            'testimonial_description'=>$tm_description,
        );
        
        $stores = $this->model_setting_store->getStores();

        $this->model_setting_setting->editSetting('testimonial',$settings, 0);
        foreach ($stores as $store) {
            $this->model_setting_setting->editSetting('testimonial',$settings, $store['store_id']);
        }

        $this->{$this->moduleModel}->install();

        $modifications = $this->load->controller('extension/modification/refresh');
    }


    public function uninstall() {
        $this->load->model('setting/store');
        $this->load->model('setting/setting');
        $this->load->model($this->modulePath);

        $this->model_setting_setting->deleteSetting('testimonial',0);
        $stores=$this->model_setting_store->getStores();
        foreach ($stores as $store) {
            $this->model_setting_setting->deleteSetting('testimonial', $store['store_id']);
        }

        $this->{$this->moduleModel}->uninstall();

        $modifications = $this->load->controller('extension/modification/refresh');
    }
    
    public function getNotification() {
        sleep(1);
        $this->load->language($this->modulePath);

        $json['version'] = $this->moduleVersion;

        $language_code = $this->config->get('config_admin_language');
        $result = $this->getCurlContent("https://vanstudio.co.ua/index.php?route=information/message&type=module_testimonials&version=$this->moduleVersion&language_code=$language_code");


        if (stripos($result,'<html') !== false || $result == false) {
            $json['message'] = '';
            $json['error'] = $this->language->get('error_notification');
        } else {
            $json['message'] = $result;
            $json['error'] = '';
        }

        $this->response->setOutput(json_encode($json));
    }

    protected function getCurlContent($url) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }
}
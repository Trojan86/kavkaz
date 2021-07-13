<?php
class ControllerExtensionModuleRestaurant extends Controller {
    private $moduleName 			= 'restaurant';
    private $moduleModel 			= 'model_extension_module_restaurant';
    private $modulePath 			= 'extension/module/restaurant';
    private $moduleVersion 			= '1.3.4';
    private $name = 'restaurant';
    public function index($setting) {
        $data['moduleName'] 		= $this->moduleName;
        $data['moduleModel']		= $this->moduleModel;
        $this->load->model($this->modulePath);
        $lang_ar = $this->load->language($this->modulePath);
        foreach($lang_ar as $key => $item){
            $data[$key] = $item;}

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $data['language_id'] = $this->config->get('config_language_id');

        if(!$this->{$this->moduleModel}->getTableExist('vs_restaurant')){
            $data['error_not_installed'] = html_entity_decode($this->language->get('error_not_installed'));
        }

        $data['heading_title'] = isset($setting['module_description'][$data['language_id']]['title'])?html_entity_decode($setting['module_description'][$data['language_id']]['title'], ENT_QUOTES, 'UTF-8'):$this->language->get('heading_title');
        $data['button_all_text'] = isset($setting['module_description'][$data['language_id']]['all_text'])?html_entity_decode($setting['module_description'][$data['language_id']]['all_text'], ENT_QUOTES, 'UTF-8'):$this->language->get('button_all');

        $data['restaurant_theme'] = $this->config->get('restaurant_theme');

        $data['layout'] = (int)$setting['layout_id'];
        $data['slide_limit'] = (int)$setting['slide_limit'];
        if ($data['slide_limit'] == 1) {
            $data['single_item'] = 'true';
        } else {
            $data['single_item'] = 'false';
        }
        $data['navigation'] = $setting['navigation'];
        $data['pagination'] = $setting['pagination'];
        $data['slide_speed'] = (int)$setting['slide_speed'];
        $data['text_align'] = $setting['text_align'];
        $data['image'] = (int)$setting['image'];
        $data['image_width'] = $setting['image_width'];
        $data['image_height'] = $setting['image_height'];
        $data['multilang'] = (int)$setting['multilang'];
        $data['multistore'] = (int)$setting['multistore'];
        $data['button_all'] = (int)$setting['button_all'];

        $data['contacts']=$this->{$this->moduleModel}->processOutput();

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->load->view('extension/module/restaurant', $data);
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->modulePath . '.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/' . $this->modulePath . '.tpl', $data);
            } else {
                return $this->load->view('default/template/' . $this->modulePath .'.tpl', $data);
            }
        }
    }

}
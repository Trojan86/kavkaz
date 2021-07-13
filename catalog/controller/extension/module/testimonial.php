<?php

class ControllerExtensionModuleTestimonial extends Controller
{
    private $moduleName 			= 'testimonial';
    private $moduleModel 			= 'model_extension_module_testimonial';
    private $modulePath 			= 'extension/module/testimonial';
    private $moduleVersion 			= '1.3.4';
    
    public function index($setting)
    {
        static $module = 0;
        $this->load->language($this->modulePath);
        $this->load->model($this->modulePath);

        $data['language_id'] = $this->config->get('config_language_id');
        
        if(!$this->{$this->moduleModel}->getTableExist('vs_testimonial')){
            $data['error_not_installed'] = html_entity_decode($this->language->get('error_not_installed'));
        }

        $data['heading_title'] = isset($setting['module_description'][$data['language_id']]['title'])?html_entity_decode($setting['module_description'][$data['language_id']]['title'], ENT_QUOTES, 'UTF-8'):$this->language->get('heading_title');
        $data['button_all_text'] = isset($setting['module_description'][$data['language_id']]['all_text'])?html_entity_decode($setting['module_description'][$data['language_id']]['all_text'], ENT_QUOTES, 'UTF-8'):$this->language->get('button_all');
        
        $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
        $this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');
        $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-module.css');

        $data['testimonial_theme'] = $this->config->get('testimonial_theme');
        if($data['testimonial_theme']){
            $this->document->addStyle('catalog/view/theme/default/stylesheet/testimonial/testimonial-mod.css');
        }

        
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

        $data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
        $data['keyword'] = $data['keyword']?$data['keyword']:$this->url->link('testimonial/testimonial');
        $data['testimonial_rating'] = $this->config->get('testimonial_rating');
        $data['testimonial_date'] = $this->config->get('testimonial_date');
        $data['testimonial_date_format'] = $this->config->get('testimonial_date_format');
        $data['testimonial_registered'] = $this->config->get('testimonial_registered');
        $data['testimonial_registered_color'] = $this->config->get('testimonial_registered_color');

        $data['testimonial_icon_size'] = $this->config->get('testimonial_icon_size');
        $data['testimonial_icon'] = $this->config->get('testimonial_icon');
        $data['testimonial_icon_color'] = $this->config->get('testimonial_icon_color');
        $data['testimonial_icon_border'] = $this->config->get('testimonial_icon_border');

        $rating_icon = $this->{$this->moduleModel}->getRatingIcons($data);

        $data['testimonial_icon_first'] = $rating_icon['testimonial_icon_first'];
        $data['testimonial_icon_second'] = $rating_icon['testimonial_icon_second'];
        $data['testimonial_icon_third'] = $rating_icon['testimonial_icon_third'];

        $data['text_posted'] = $this->language->get('text_posted');
        $data['text_registered'] = $this->language->get('text_registered');
        $data['text_no_reviews'] = $this->language->get('text_no_reviews');
        $data['send_feedback'] = $this->language->get('send_feedback');

        $data['testimonials'] = array();
        $testimonials = '';
        if (!empty($setting['testimonial'])) {
            $testimonials = implode(',', $setting['testimonial']);
        }
        $filter_data = array(
            'multistore'         => $data['multistore'],
            'multilang'          => $data['multilang'],
            'order'              => $setting['order'],
            'start'              => 0,
            'limit'              => $setting['limit'],
            'ids'                => $testimonials
        );

        $results = $this->{$this->moduleModel}->getModuleTestimonials($filter_data);
        $this->load->model('tool/image');
        if ($results) {
            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $setting['image_width']?$setting['image_width']:100, $setting['image_height']?$setting['image_height']:100);
                } elseif($this->config->get('testimonial_default_image')) {
                    $image = $this->model_tool_image->resize($this->config->get('testimonial_default_image'), $setting['image_width']?$setting['image_width']:100, $setting['image_height']?$setting['image_height']:100);
                } else {
                    $image = $this->model_tool_image->resize('no_image.png', $setting['image_width']?$setting['image_width']:100, $setting['image_height']?$setting['image_height']:100);
                }
                $data['testimonials'][] = array(
                    'testimonial_id' => $result['testimonial_id'],
                    'thumb'      => $image,
                    'author' => $result['author'],
                    'text' => utf8_substr(strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8')), 0, $setting['text_limit']) . '..',
                    'rating' => (int)$result['rating'],
                    'author' => $result['author'],
                    'customer_id' => $result['customer_id'],
                    //'date_added' => date($this->language->get('date_format_long'), strtotime($result['date_added'])),
                    'date_added' =>$this->rel_date($result['date_added'],$this->session->data['language']),
                );
            }

            $data['module'] = 'tm' . $module++;
            switch ($data['layout']) {
                case 0:
                    $tmp_name = 'tm_ver';
                    break;
                case 1:
                    $tmp_name = 'tm_hor';
                    break;
                case 2:
                    $tmp_name = 'tm_slid';
                    break;
                default:
                    $tmp_name = 'tm_ver';
                    break;
            }
            $data['tm_class'] = $tmp_name;

            if(substr(VERSION, 0, 7) > '2.1.0.2'){
                return $this->load->view('extension/module/testimonial_'.$tmp_name, $data);
            }else{
                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->modulePath . '_'.$tmp_name.'.tpl')) {
                    return $this->load->view($this->config->get('config_template') . '/template/' . $this->modulePath . '_'.$tmp_name.'.tpl', $data);
                } else {
                    return $this->load->view('default/template/' . $this->modulePath . '_'.$tmp_name.'.tpl', $data);
                }
            }
        }
    }
    private function rel_date($danni = null, $lang = 'ukr') {
        // Переклад
        if ($lang == 'uk-ua') {
            $translate = array(
                "am" => "до",
                "pm" => "по",
                "AM" => "ДО",
                "PM" => "ПО",
                "Monday" => "Понеділок",
                "Mon" => "Пн",
                "Tuesday" => "Вівторок",
                "Tue" => "Вт",
                "Wednesday" => "Середа",
                "Wed" => "Ср",
                "Thursday" => "Четвер",
                "Thu" => "Чт",
                "Friday" => "П\'ятница",
                "Fri" => "Пт",
                "Saturday" => "Субота",
                "Sat" => "Сб",
                "Sunday" => "Неділя",
                "Sun" => "Нж",
                "January" => "Січня",
                "Jan" => "Січ",
                "February" => "Лютого",
                "Feb" => "Лют",
                "March" => "Березня",
                "Mar" => "Бер",
                "April" => "Квітня",
                "Apr" => "Кві",
                "May" => "Травня",
                "May" => "Тра",
                "June" => "Червня",
                "Jun" => "Чер",
                "July" => "Липня",
                "Jul" => "Лип",
                "August" => "Серпня",
                "Aug" => "Сер",
                "September" => "Вересня",
                "Sep" => "Вер",
                "October" => "Жовтня",
                "Oct" => "Жов",
                "November" => "Листопада",
                "Nov" => "Лис",
                "December" => "Грудня",
                "Dec" => "Гру",
                "st" => "е",
                "nd" => "е",
                "rd" => "е",
                "th" => "е"
            );
        } elseif ($lang == 'ru-ru') {
            $translate = array(
                "am" => "дп",
                "pm" => "пп",
                "AM" => "ДП",
                "PM" => "ПП",
                "Monday" => "Понедельник",
                "Mon" => "Пн",
                "Tuesday" => "Вторник",
                "Tue" => "Вт",
                "Wednesday" => "Среда",
                "Wed" => "Ср",
                "Thursday" => "Четверг",
                "Thu" => "Чт",
                "Friday" => "Пятница",
                "Fri" => "Пт",
                "Saturday" => "Суббота",
                "Sat" => "Сб",
                "Sunday" => "Воскресенье",
                "Sun" => "Вс",
                "January" => "Января",
                "Jan" => "Янв",
                "February" => "Февраля",
                "Feb" => "Фев",
                "March" => "Марта",
                "Mar" => "Мар",
                "April" => "Апреля",
                "Apr" => "Апр",
                "May" => "Мая",
                "May" => "Мая",
                "June" => "Июня",
                "Jun" => "Июн",
                "July" => "Июля",
                "Jul" => "Июл",
                "August" => "Августа",
                "Aug" => "Авг",
                "September" => "Сентября",
                "Sep" => "Сен",
                "October" => "Октября",
                "Oct" => "Окт",
                "November" => "Ноября",
                "Nov" => "Ноя",
                "December" => "Декабря",
                "Dec" => "Дек",
                "st" => "ое",
                "nd" => "ое",
                "rd" => "е",
                "th" => "ое"
            );
        }
// Якщо дата отримана, то обробляємо її
        if ($danni != null) {
            $timestamp = strtotime($danni);
            return strtr(date("j F Y", $timestamp), $translate);
        } else {
            // або виводимо поточну дату...
            return strtr(date("j F Y"), $translate);
        }
    }
}
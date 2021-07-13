<?php
class ControllerTestimonialTestimonialList extends Controller
{
    private $moduleName 			= 'testimonial';
    private $moduleModel 			= 'model_extension_module_testimonial';
    private $moduleModelPath 		= 'extension/module/testimonial';
    private $modulePath 			= 'testimonial/testimonial_list';
    private $moduleVersion 			= '1.3.4';
    
    public function index()
    {
        $lang_ar = $this->load->language($this->modulePath);

        foreach($lang_ar as $key => $item){
            $data[$key] = $item;
        }
        
        $this->load->model($this->moduleModelPath);
        $this->load->model('tool/image');

        $data['language_id'] = $this->config->get('config_language_id');

        $data['testimonial_multistore'] = $this->config->get('testimonial_multistore');
        $data['testimonial_multilang'] = $this->config->get('testimonial_multilang');
        $data['testimonial_rating'] = $this->config->get('testimonial_rating');
        $data['testimonial_image'] = $this->config->get('testimonial_image');
        $data['testimonial_image_width'] = $this->config->get('testimonial_image_width');
        $data['testimonial_image_height'] = $this->config->get('testimonial_image_height');

        $data['testimonial_template'] = $this->config->get('testimonial_template');
        $data['testimonial_template'] = isset($data['testimonial_template'])?$data['testimonial_template']:0;

        $data['testimonial_icon_size'] = $this->config->get('testimonial_icon_size');
        $data['testimonial_icon'] = $this->config->get('testimonial_icon');
        $data['testimonial_icon_color'] = $this->config->get('testimonial_icon_color');
        $data['testimonial_icon_border'] = $this->config->get('testimonial_icon_border');

        $rating_icon = $this->{$this->moduleModel}->getRatingIcons($data);

        $data['testimonial_icon_first'] = $rating_icon['testimonial_icon_first'];
        $data['testimonial_icon_second'] = $rating_icon['testimonial_icon_second'];
        $data['testimonial_icon_third'] = $rating_icon['testimonial_icon_third'];

        $data['testimonial_date'] = $this->config->get('testimonial_date');
        $data['testimonial_date_format'] = $this->config->get('testimonial_date_format');
        $data['testimonial_registered'] = $this->config->get('testimonial_registered');
        $data['testimonial_registered_color'] = $this->config->get('testimonial_registered_color');

        $data['keyword'] = $this->{$this->moduleModel}->getUrlKeyword('testimonial/testimonial');
        $data['action'] = $data['keyword']?$data['keyword']:$this->url->link('testimonial/testimonial');
        $data['keyword'] = $data['action'];

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

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

        $data['testimonials'] = array();

        $filter_data = array(
            'multistore'         => $data['testimonial_multistore'],
            'multilang'          => $data['testimonial_multilang'],
            'sort'               => $sort,
            'order'              => $order,
            'start'              => ($page - 1) * $limit,
            'limit'              => $limit
        );

        $testimonial_total = $this->{$this->moduleModel}->getTotalTestimonials($filter_data);
        $results = $this->{$this->moduleModel}->getTestimonials($filter_data);

        $image_width = $this->config->get('testimonial_image_width')?$this->config->get('testimonial_image_width'):'100';
        $image_height = $this->config->get('testimonial_image_height')?$this->config->get('testimonial_image_height'):'100';

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $image_width, $image_height);
            } elseif($this->config->get('testimonial_default_image')) {
                $image = $this->model_tool_image->resize($this->config->get('testimonial_default_image'), $image_width, $image_height);
            } else {
                $image = $this->model_tool_image->resize('no_image.png', $image_width, $image_height);
            }

            $data['testimonials'][] = array(
                'thumb'      => $image,
                'author'     => $result['author'],
                'text'       => nl2br($result['text']),
                'rating'     => (int)$result['rating'],
                'customer_id'=> (int)$result['customer_id'],
                'date_added' => date($data['testimonial_date_format']?$data['testimonial_date_format']:$this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }

        $url = '';

        if (isset($this->request->get['filter'])) {
            $url .= '&filter=' . $this->request->get['filter'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $pagination = new Pagination();

        $pagination->total = $testimonial_total;
        $pagination->page = $page;
        $pagination->limit = $limit;
        $pagination->url = $data['keyword']?$data['keyword'] . $url . '&page={page}':$this->url->link('testimonial/testimonial',  $url . '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($testimonial_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($testimonial_total - $limit)) ? $testimonial_total : ((($page - 1) * $limit) + $limit), $testimonial_total, ceil($testimonial_total / $limit));

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->load->view('testimonial/testimonial_list' . $data['testimonial_template'], $data);
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_list' . $data['testimonial_template'] . '.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_list' . $data['testimonial_template'] . '.tpl', $data);
            } else {
                return $this->load->view('default/template/testimonial/testimonial_list' . $data['testimonial_template'] . '.tpl', $data);
            }
        }
    }
}
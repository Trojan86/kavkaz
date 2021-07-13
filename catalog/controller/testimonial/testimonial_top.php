<?php
class ControllerTestimonialTestimonialTop extends Controller
{
    public function index($error){
        static $module = 0;
        $data['parts'] = array();
        $data['module'] = $module++;

        $parts = $this->config->get('testimonial_parts');
        if($parts){
            foreach($parts as $p=>$key){
                $sort_part[] = $key['sort_order'];
            }
            array_multisort($sort_part, SORT_ASC, $parts);

            foreach ($parts as $item) {
                $part = explode('.', $item['code']);

                if (isset($part[0]) && $item['position']<4) {
                    $params = array(
                        'name' => $part[0],
                        'module' => $data['module'],
                        'position' => $item['position'],
                        'error' => $error
                    );
                    $data['parts'][] = $this->load->controller('testimonial/testimonial_part', $params);
                }
            }
        }

        if(substr(VERSION, 0, 7) > '2.1.0.2'){
            return $this->load->view('testimonial/testimonial_top', $data);
        }else{
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/testimonial/testimonial_top.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/testimonial/testimonial_top.tpl', $data);
            } else {
                return $this->load->view('default/template/testimonial/testimonial_top.tpl', $data);
            }
        }

    }
}

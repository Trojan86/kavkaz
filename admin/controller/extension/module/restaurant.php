<?php
class ControllerExtensionModuleRestaurant extends Controller {
    private $error = array();
    private $moduleName 			= 'restaurant';
    private $moduleModel 			= 'model_extension_module_restaurant';
    private $modulePath 			= 'extension/module/restaurant';
    private $extensionPath 			= 'extension/extension';
    private $moduleVersion 			= '1.3.4';
    private $name = 'restaurant';

    public function index() {
        $dataLoad= $this->loadData();
        $data['module_info']=null;
        foreach  ($dataLoad as $key=>$value) {
            $data[$key]=$value;
        }
        $data['contacts']=$this->{$this->moduleModel}->getAllContacts();
        $this->setRedirect($this->modulePath.'_show', $data, $this->modulePath, isset($data['module_info'])?$data['module_info']:null);
    }

    public function install() {
        $this->load->model('setting/store');
        $this->load->model('setting/setting');
        $this->load->model('localisation/language');
        $this->load->model($this->modulePath);

        $languages = $this->model_localisation_language->getLanguages();

        foreach($languages as $lang){
            $rs_description[$lang['language_id']] = array(
                'name'=>'Restaurant',
                'description'=>'restaurant',
                'meta_title'=>'Restaurant',
                'meta_description'=>'restaurant',
                'meta_keyword'=>'',
            );
        }
        $rs_parts = array(
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
            'restaurant_rs_status'=>0,
            'restaurant_approve'=>0,
            'restaurant_multilang'=>0,
            'restaurant_multistore'=>0,
            'restaurant_template'=>0,
            'restaurant_theme'=>0,
            'restaurant_sort'=>0,
            'restaurant_count'=>0,
            'restaurant_popup'=>0,
            'restaurant_email'=>0,
            'restaurant_email_required'=>0,
            'restaurant_captcha'=>0,
            'restaurant_date'=>1,
            'restaurant_date_format'=>'d/m/Y',
            'restaurant_registered'=>1,
            'restaurant_registered_color'=>'#999',
            'restaurant_limit'=>4,
            'restaurant_rating'=>1,
            'restaurant_rating_required'=>1,
            'restaurant_stars'=>4,
            'restaurant_icon_color'=>'#FC0',
            'restaurant_icon_border'=>'#E69500',
            'restaurant_icon_size'=>16,
            'restaurant_image'=>0,
            'restaurant_image_required'=>0,
            'restaurant_image_width'=>100,
            'restaurant_image_height'=>100,
            'restaurant_file_size'=>5242880,
            'restaurant_default_image'=>'',
            'restaurant_parts'=>$rs_parts,
            'restaurant_description'=>$rs_description,
        );

        $stores = $this->model_setting_store->getStores();

        $this->model_setting_setting->editSetting('restaurant',$settings, 0);
        foreach ($stores as $store) {
            $this->model_setting_setting->editSetting('restaurant',$settings, $store['store_id']);
        }
        $this->{$this->moduleModel}->install();

        $modifications = $this->load->controller('extension/modification/refresh');
    }

    public function uninstall() {  $this->load->model('setting/store');
        $this->load->model('setting/setting');
        $this->load->model($this->modulePath);

        $this->model_setting_setting->deleteSetting('restaurant',0);
        $stores=$this->model_setting_store->getStores();
        foreach ($stores as $store) {
            $this->model_setting_setting->deleteSetting('restaurant', $store['store_id']);
        }

        $this->{$this->moduleModel}->uninstall();

        $modifications = $this->load->controller('extension/modification/refresh');

    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', $this->modulePath)) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        return !$this->error;
    }

    public function processAction()
    {   $data2=$this->loadData();
        $isAdd=isset($_POST['add']);
        $isEdit=isset($_POST['edit']);
        $isCancel=isset($_POST['cancel']);
        $isDelete=isset($_POST['delete']);

        if($isAdd||$isEdit||$isCancel||$isDelete){
            if($isAdd) {
                if($this->{$this->moduleModel}->addContact($data2['text_str']))
                    $data2['message']= $data2['text_add_success'];
                else {
                    $data2['message'] = $data2['text_mustfill'];
                }
            }
            else if($isEdit) {
                if($this->{$this->moduleModel}->editContact($data2['text_str']))
                    $data2['message'] = $data2['text_edit_success'];
            }
            else if($isDelete) {
                $this->{$this->moduleModel}->deleteContact();
            }
            $data2['contacts']=$this->{$this->moduleModel}->getAllContacts();
        }
        else if(isset($_POST['toEdit']))
            $data2['contact']=$this->{$this->moduleModel}->getContactById();
        $lp=isset($_POST['return'])?$this->extensionPath:false;

        if (isset($_POST['toEdit']))
            $pathVersion='_edit';
        else if (isset($_POST['toAdd']))
            $pathVersion='_add';
        else $pathVersion='_show';
        $this->setRedirect($this->modulePath.$pathVersion, $data2, $lp);}



    public function setRedirect($viewPath, $data2, $linkPath, $module_info=null) {
        if($linkPath!=false) {
            if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
                $post = $this->request->post;
                $post1 = $this->getParamsFromPost($module_info);
                foreach ($post1 as $key => $value) {
                    $post[$key] = $value;
                }

                if (!isset($this->request->get['module_id'])) {
                    $this->model_extension_module->addModule($this->moduleName, $post);
                    $module_id = $this->db->getLastId();
                } else {
                    $this->model_extension_module->editModule($this->request->get['module_id'], $post1);
                    $data2['module_id'] = $module_id = $this->request->get['module_id'];
                }

                $this->session->data2['success'] = $this->language->get('text_success');

                if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
                    $module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
                    $data2['info'] = $module_info;
                }


                if ($this->request->post['apply']) {
                    $data2[success_redirect] = true;
                    $this->response->redirect($this->url->link($linkPath, 'token=' . $this->session->data['token'], 'SSL'));
                } else {
                    $data2[success_redirect] = false;
                    $this->response->redirect($this->url->link($linkPath, 'token=' . $this->session->data['token'] . '&module_id=' . $module_id, 'SSL'));
                }
            }
        }
        if(substr(VERSION, 0, 7) <= '2.1.0.2')
            $viewPath=$viewPath. '.tpl';
        $this->response->setOutput($this->load->view($viewPath, $data2));
    }

    public function loadData()
    {   $data2['moduleName'] 		= $this->moduleName;
        $data2['moduleModel']		= $this->moduleModel;
        $lang_ar = $this->load->language($this->modulePath);
        foreach($lang_ar as $key => $item){
            $data2[$key] = $item;}

        $this->load->model($this->modulePath);
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('extension/module');

        if (isset($this->error['warning'])) {
            $data2['error_warning'] = $this->error['warning'];
        } else {
            $data2['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data2['error_name'] = $this->error['name'];
        } else {
            $data2['error_name'] = '';
        }

        $data2['breadcrumbs'] = array();

        $data2['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data2['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL')
        );

        if (!isset($this->request->get['module_id'])) {
            $data2['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title') . ' ' . $this->moduleVersion,
                'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'], 'SSL')
            );
        } else {
            $data2['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'). ' ' . $this->moduleVersion,
                'href' => $this->url->link($this->modulePath, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
            );
        }

        if (!isset($this->request->get['module_id']))
        {
            $data2['action'] = $this->url->link($this->modulePath.'/processAction', 'token=' . $this->session->data['token'], 'SSL');
        } else {
            $data2['action'] = $this->url->link($this->modulePath . '/processAction', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
        }

        $data2['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
        $data2['autocomplete'] = $this->url->link($this->modulePath . '/autoComplete', 'token=' . $this->session->data['token'], 'SSL');

        $data2['$module_info'] = null;
        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $data2['$module_info'] = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        $post1=$this->getParamsFromPost($data2['$module_info']);
        foreach  ($post1 as $key=>$value) {
            $data2[$key]=$value;
        }

        $data2['token'] = $this->session->data['token'];

        $data2['restaurants'] = array();

        if (isset($this->request->post['restaurant'])) {
            $restaurants = $this->request->post['restaurant'];
        } elseif (!empty($module_info['restaurant'])) {
            $restaurants = $module_info['restaurant'];
        } else {
            $restaurants = array();
        }

        if($restaurants) {
            foreach ($restaurants as $restaurant_id) {
                $restaurant_info = $this->{$this->moduleModel}->getRestaurant($restaurant_id);

                if ($restaurant_info) {
                    $data2['restaurants'][] = array(
                        'restaurant_id' => $restaurant_info['restaurant_id'],
                        'text' => utf8_substr(strip_tags(html_entity_decode($restaurant_info['text'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                    );
                }
            }
        }

        $this->load->model('localisation/language');

        $data2['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->session->data['success'])) {
            $data2['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data2['success'] = '';
        }

        $data2['header'] = $this->load->controller('common/header');
        $data2['column_left'] = $this->load->controller('common/column_left');
        $data2['column_right'] = $this->load->controller('common/column_right');
        $data2['footer'] = $this->load->controller('common/footer');
        return $data2;
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

            $results = $this->{$this->moduleModel}->getRestaurants($filter_data);

            foreach ($results as $result) {

                $json[] = array(
                    'restaurant_id' => $result['restaurant_id'],
                    'text'       => utf8_substr(strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8')), 0, 100 ). '..',
                );
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getParamsFromPost($module_info) {
        $post1 = $this->request->post;

        /* if (isset($this->request->post['name'])) {
             $post1['name'] = $this->request->post['name'];
         } elseif (!empty($module_info)) {
             $post1['name'] = $module_info['name'];
         } else {
             $post1['name'] = '';
         }*/

        if (isset($this->request->post['status'])) {
            $post1['status'] = $this->request->post['status'];
        } elseif (!empty($module_info)) {
            $post1['status'] = $module_info['status'];
        } else {
            $post1['status'] = '1';
        }

        if (isset($this->request->post['order'])) {
            $post1['order'] = $this->request->post['order'];
        } elseif (!empty($module_info)) {
            $post1['order'] = $module_info['order'];
        } else {
            $post1['order'] = '';
        }
        if (isset($this->request->post['slide_limit'])) {
            $post1['slide_limit'] = $this->request->post['slide_limit'];
        } elseif (!empty($module_info)) {
            $post1['slide_limit'] = $module_info['slide_limit'];
        } else {
            $post1['slide_limit'] = '1';
        }

        if (isset($this->request->post['navigation'])) {
            $post1['navigation'] = $this->request->post['navigation'];
        } elseif (!empty($module_info)) {
            $post1['navigation'] = $module_info['navigation'];
        } else {
            $post1['navigation'] = '';
        }

        if (isset($this->request->post['pagination'])) {
            $post1['pagination'] = $this->request->post['pagination'];
        } elseif (!empty($module_info)) {
            $post1['pagination'] = $module_info['pagination'];
        } else {
            $post1['pagination'] = '';
        }

        if (isset($this->request->post['slide_speed'])) {
            $post1['slide_speed'] = $this->request->post['slide_speed'];
        } elseif (!empty($module_info)) {
            $post1['slide_speed'] = $module_info['slide_speed'];
        } else {
            $post1['slide_speed'] = '3000';
        }

        if (isset($this->request->post['layout_id'])) {
            $post1['layout_id'] = $this->request->post['layout_id'];
        } elseif (!empty($module_info)) {
            $post1['layout_id'] = $module_info['layout_id'];
        } else {
            $post1['layout_id'] = '';
        }

        if (isset($this->request->post['text_align'])) {
            $post1['text_align'] = $this->request->post['text_align'];
        } elseif (!empty($module_info)) {
            $post1['text_align'] = $module_info['text_align'];
        } else {
            $post1['text_align'] = 'left';
        }
        if (isset($this->request->post['image_height'])) {
            $post1['image_height'] = $this->request->post['image_height'];
        } elseif (!empty($module_info)) {
            $post1['image_height'] = $module_info['image_height'];
        } else {
            $post1['image_height'] = '100';
        }

        if (isset($this->request->post['multistore'])) {
            $post1['multistore'] = $this->request->post['multistore'];
        } elseif (!empty($module_info)) {
            $post1['multistore'] = $module_info['multistore'];
        } else {
            $post1['multistore'] = '0';
        }

        if (isset($this->request->post['limit'])) {
            $post1['limit'] = $this->request->post['limit'];
        } elseif (!empty($module_info)) {
            $post1['limit'] = $module_info['limit'];
        } else {
            $post1['limit'] = '3';
        }

        if (isset($this->request->post['image_width'])) {
            $post1['image_width'] = $this->request->post['image_width'];
        } elseif (!empty($module_info)) {
            $post1['image_width'] = $module_info['image_width'];
        } else {
            $post1['image_width'] = '100';
        }

        if (isset($this->request->post['text_limit'])) {
            $post1['text_limit'] = $this->request->post['text_limit'];
        } elseif (!empty($module_info)) {
            $post1['text_limit'] = $module_info['text_limit'];
        } else {
            $post1['text_limit'] = '100';
        }

        if (isset($this->request->post['image'])) {
            $post1['image'] = $this->request->post['image'];
        } elseif (!empty($module_info)) {
            $post1['image'] = $module_info['image'];
        } else {
            $post1['image'] = '1';
        }

        if (isset($this->request->post['button_all'])) {
            $post1['button_all'] = $this->request->post['button_all'];
        } elseif (!empty($module_info)) {
            $post1['button_all'] = $module_info['button_all'];
        } else {
            $post1['button_all'] = '1';
        }

        if (isset($this->request->post['multilang'])) {
            $post1['multilang'] = $this->request->post['multilang'];
        } elseif (!empty($module_info)) {
            $post1['multilang'] = $module_info['multilang'];
        } else {
            $post1['multilang'] = '0';
        }

        if (isset($this->request->post['module_description'])) {
            $post1['module_description'] = $this->request->post['module_description'];
        } elseif (!empty($module_info)) {
            $post1['module_description'] = $module_info['module_description'];
        } else {
            $post1['module_description'] = '';
        }
        $post1['name']=$this->name;
        return $post1;
    }
}
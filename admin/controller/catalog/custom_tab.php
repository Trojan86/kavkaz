<?php
class ControllerCatalogCustomTab extends Controller {
	private $error = array();
	private $tab_id = 0;
	private $path = array();

	public function index() {
		$this->load->language('extension/module/custom_tab');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/custom_tab');

		$this->getList();
	}

	public function add() {
		$this->load->language('extension/module/custom_tab');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/custom_tab');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_module_custom_tab->addTab($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('extension/module/custom_tab');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/custom_tab');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_module_custom_tab->editTab($this->request->get['tab_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('extension/module/custom_tab');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module/custom_tab');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $tab_id) {
				$this->model_extension_module_custom_tab->deleteTab($tab_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
        $url = '';
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true)
		);
		
		$data['add'] = $this->url->link('catalog/custom_tab/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/custom_tab/delete', 'token=' . $this->session->data['token'] . $url, true);
		$data['enabled'] = $this->url->link('catalog/custom_tab/enable', 'token=' . $this->session->data['token'] . $url, true);
        $data['disabled'] = $this->url->link('catalog/custom_tab/disable', 'token=' . $this->session->data['token'] . $url, true);

		
		$tabs = $this->model_extension_module_custom_tab->getTabs();

		$data['tabs'] = array();
		foreach ($tabs as $tab) {
			$data['tabs'][] = array(
				'tab_id' => $tab['tab_id'],
				'name'        => $tab['name'],
				'sort_order'  => $tab['sort_order'],
				'edit'        => $this->url->link('catalog/custom_tab/edit', 'token=' . $this->session->data['token'] . '&tab_id=' . $tab['tab_id'], true)
				);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_shop'] = $this->language->get('button_shop');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_rebuild'] = $this->language->get('button_rebuild');
		$data['button_enable'] = $this->language->get('button_enable');
        $data['button_disable'] = $this->language->get('button_disable');

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
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/custom_tab_list', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['tab_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_products'] = $this->language->get('entry_products');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}
		
		$url = '';

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
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['tab_id'])) {
			$data['action'] = $this->url->link('catalog/custom_tab/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/custom_tab/edit', 'token=' . $this->session->data['token'] . '&tab_id=' . $this->request->get['tab_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['tab_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$tab_info = $this->model_extension_module_custom_tab->getTab($this->request->get['tab_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['tab_description'])) {
			$data['tab_description'] = $this->request->post['tab_description'];
		} elseif (isset($this->request->get['tab_id'])) {
			$data['tab_description'] = $this->model_extension_module_custom_tab->getTabDescriptions($this->request->get['tab_id']);
		} else {
			$data['tab_description'] = array();
		}
		
		$language_id = $this->config->get('config_language_id');
		if (isset($data['tab_description'][$language_id]['name'])) {
			$data['heading_title'] = $data['tab_description'][$language_id]['name'];
		}

		$this->load->model('setting/store');

		$data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['tab_store'])) {
			$data['tab_store'] = $this->request->post['tab_store'];
		} elseif (isset($this->request->get['tab_id'])) {
			$data['tab_store'] = $this->model_extension_module_custom_tab->getTabStores($this->request->get['tab_id']);
		} else {
			$data['tab_store'] = array(0);
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($tab_info)) {
			$data['sort_order'] = $tab_info['sort_order'];
		} else {
			$data['sort_order'] = 0;
		}
		
		if (isset($this->request->post['products'])) {
			$products = $this->request->post['products'];
		} elseif (isset($tab_info)) {		
			$products = $this->model_extension_module_custom_tab->getTabProducts($this->request->get['tab_id']);
		} else {
			$products = array();
		}	

		$data['products'] = array();
			
		$this->load->model('catalog/product');
		
		foreach ($products as $product_id) {
			$related_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($related_info) {
				$data['products'][] = array(
					'product_id' => $related_info['product_id'],
					'name'       => $related_info['name']
				);
			}
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($tab_info)) {
			$data['status'] = $tab_info['status'];
		} else {
			$data['status'] = true;
		}

		// Categories
		$this->load->model('catalog/category');
		
		$categories = $this->model_catalog_category->getAllCategories();
		
		$data['categories'] = $this->model_catalog_category->getCategories($categories);

		if (isset($this->request->post['tab_to_category'])) {
			$categories = $this->request->post['tab_to_category'];
		} elseif (isset($this->request->get['tab_id'])) {
			$categories = $this->model_extension_module_custom_tab->getShowInCategories($this->request->get['tab_id']);
		} else {
			$categories = array();
		}

		$data['tab_to_categories'] = array();

		foreach ($categories as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
				$data['tab_to_categories'][] = array(
					'category_id' => $category_info['category_id'],
					'name'        => ($category_info['path']) ? $category_info['path'] . ' &gt; ' . $category_info['name'] : $category_info['name']
				);
			}
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/custom_tab_form', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/custom_tab')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['tab_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		return !$this->error;
	}
	
	public function enable() {
        $this->load->language('extension/module/custom_tab');
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('extension/module/custom_tab');
        if (isset($this->request->post['selected'])) {
            foreach ($this->request->post['selected'] as $tab_id) {
                $this->model_extension_module_custom_tab->editTabStatus($tab_id, 1);
            }
            $this->session->data['success'] = $this->language->get('text_success');
            $url = '';
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
			$this->response->redirect($this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true));
        }
        $this->getList();
    }
	
    public function disable() {
        $this->load->language('extension/module/custom_tab');
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('extension/module/custom_tab');
        if (isset($this->request->post['selected'])) {
            foreach ($this->request->post['selected'] as $tab_id) {
                $this->model_extension_module_custom_tab->editTabStatus($tab_id, 0);
            }
            $this->session->data['success'] = $this->language->get('text_success');
            $url = '';
            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            $this->response->redirect($this->url->link('catalog/custom_tab', 'token=' . $this->session->data['token'] . $url, true));
        }
        $this->getList();
    }


	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/custom_tab')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}


	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('extension/module/custom_tab');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'sort'        => 'name',
				'order'       => 'ASC',
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_extension_module_custom_tab->getTabs($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'tab_id' => $result['tab_id'],
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}

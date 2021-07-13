<?php
class ControllerExtensionModuleafoc3 extends Controller {
	private $error = array();

	public function index() {
		
		
		$this->document->addScript('view/javascript/jquery/querybuilder/query-builder.standalone.min.js');
		$this->document->addScript('view/javascript/jquery/querybuilder/query-builder.ru.js');
		//$this->document->addScript('view/javascript/jquery/querybuilder/sql-parser.min.js');
		
		$this->document->addStyle('view/javascript/jquery/querybuilder/query-builder.default.min.css');
		$this->document->addStyle('view/javascript/jquery/querybuilder/afstyle.css');
		
		$this->load->language('extension/module/afoc3');
		$this->load->model('extension/module/afoc3');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/module');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('afoc3', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_sortprice'] = $this->language->get('entry_sortprice');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_status'] = $this->language->get('entry_status');
		
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_cond_source'] = $this->language->get('tab_cond_source');
		$data['tab_cond_dest'] = $this->language->get('tab_cond_dest');
		$data['entry_preset'] = $this->language->get('entry_preset');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
		$data['entry_delim'] = $this->language->get('entry_delim');
		$data['entry_sort'] = $this->language->get('entry_sort');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_asc'] = $this->language->get('entry_asc');
		$data['entry_desc'] = $this->language->get('entry_desc');
		$data['eantry_product_attribute'] = $this->language->get('eantry_product_attribute');
		$data['eantry_product_option'] = $this->language->get('eantry_product_option');
		$data['matching_attr'] = $this->language->get('matching_attr');
		$data['matching_opt'] = $this->language->get('matching_opt');
		$data['entry_option'] = $this->language->get('entry_option');
		$data['entry_attr'] = $this->language->get('entry_attr');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['adaptation'] = $this->url->link('extension/module/afoc3/adaptation', 'token=' . $this->session->data['token'], 'SSL');
		$data['adaptation_text'] = $this->language->get('adaptation_text');
		
		if (isset($this->error['width'])) {
			$data['error_width'] = $this->error['width'];
		} else {
			$data['error_width'] = '';
		}

		if (isset($this->error['height'])) {
			$data['error_height'] = $this->error['height'];
		} else {
			$data['error_height'] = '';
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
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/afoc3', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('extension/module/afoc3', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('extension/module/afoc3', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}
		
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
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
		
		if (isset($this->request->post['title'])) {
			$data['title'] = $this->request->post['title'];
		} elseif (!empty($module_info) && isset($module_info['title'])) {
			$data['title'] = $module_info['title'];
		} else {
			$data['title'] = array();
		}
		
		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['limit'])) {
			$data['limit'] = $this->request->post['limit'];
		} elseif (!empty($module_info)) {
			$data['limit'] = $module_info['limit'];
		} else {
			$data['limit'] = 4;
		}
		
		if (isset($this->request->post['width'])) {
			$data['width'] = $this->request->post['width'];
		} elseif (!empty($module_info)) {
			$data['width'] = $module_info['width'];
		} else {
			$data['width'] = 200;
		}

		if (isset($this->request->post['height'])) {
			$data['height'] = $this->request->post['height'];
		} elseif (!empty($module_info)) {
			$data['height'] = $module_info['height'];
		} else {
			$data['height'] = 200;
		}
		
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}
		
		if (isset($this->request->post['preset'])) {
			$data['preset'] = $this->request->post['preset'];
		} elseif (!empty($module_info)) {
			$data['preset'] = $module_info['preset'];
		} else {
			$data['preset'] = '';
		}
		
		if (isset($this->request->post['attr'])) {
			$data['attr'] = $this->request->post['attr'];
			$data['attr_name'] = $this->request->post['attr_name'];
		} elseif (!empty($module_info)) {
			$data['attr'] = $module_info['attr'];
			$data['attr_name'] = $this->getAttribute($module_info['attr']);
		} else {
			$data['attr'] = '';
			$data['attr_name'] = '';
		}
		
		if (isset($this->request->post['option'])) {
			$data['option'] = $this->request->post['option'];
			$data['option_name'] = $this->request->post['option_name'];
		} elseif (!empty($module_info)) {
			$data['option'] = $module_info['option'];
			$data['option_name'] = $this->getOption($module_info['option']);
		} else {
			$data['option'] = '';
			$data['option_name'] = '';
		}
		
		if (isset($this->request->post['delim'])) {
			$data['delim'] = $this->request->post['delim'];
		} elseif (!empty($module_info)) {
			$data['delim'] = $module_info['delim'];
		} else {
			$data['delim'] = '';
		}
		
		$data['preset_list'] = array('advanced' => array('name' => $this->language->get('entry_advanced'), 'source_json' => '', 'dest_json' => ''),
			'news' => array('name' => $this->language->get('entry_news'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition": "AND","rules": [{"empty": true}]}'),
			'special' => array('name' => $this->language->get('entry_special'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition":"AND","rules":[{"id":"pspecd.price","field":"pspecd.price","type":"double","input":"number","operator":"not_equal","value":0},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"}],"valid":true}'),
			'discount' => array('name' => $this->language->get('entry_discount'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition":"AND","rules":[{"id":"pdisd.price","field":"pdisd.price","type":"double","input":"number","operator":"not_equal","value":0},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"}],"valid":true}'),
			'oneman' => array('name' => $this->language->get('entry_oneman'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition":"AND","rules":[{"id":"pd.manufacturer_id","field":"pd.manufacturer_id","type":"string","input":"text","operator":"equal_source","value":null},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"not_equal_source","value":null}],"valid":true}'),
			'otherman' => array('name' => $this->language->get('entry_otherman'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition":"AND","rules":[{"id":"pd.manufacturer_id","field":"pd.manufacturer_id","type":"string","input":"text","operator":"not_equal_source","value":null},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"not_equal_source","value":null}],"valid":true}'),
			'onecat' => array('name' => $this->language->get('entry_onecat'), 'source_json' => '{"condition":"AND","rules":[{"id":"catd.category_id","field":"catd.category_id","type":"string","input":"text","operator":"equal_source","value":null},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"not_equal_source","value":null},{"id":"catpd.level","field":"catpd.level","type":"integer","input":"number","operator":"ac_max_level","value":null}],"valid":true}'),
			'othercat' => array('name' => $this->language->get('entry_othercat'), 'source_json' => '{"condition":"AND","rules":[{"id":"catd.category_id","field":"catd.category_id","type":"string","input":"text","operator":"not_equal_source","value":null},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"not_equal_source","value":null}],"valid":true}'),
			'oneattr' => array('name' => $this->language->get('entry_oneattr'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition": "AND","rules": [{"empty": true}]}'),
			'oneopt' => array('name' => $this->language->get('entry_oneopt'), 'source_json' => '{"condition": "AND","rules": [{"empty": true}]}', 'dest_json' => '{"condition": "AND","rules": [{"empty": true}]}')
			);
		
		if (isset($this->request->post['sort'])) {
			$data['sort'] = $this->request->post['sort'];
		} elseif (!empty($module_info)) {
			$data['sort'] = $module_info['sort'];
		} else {
			$data['sort'] = '';
		}
		
		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($module_info)) {
			$data['sort_order'] = $module_info['sort_order'];
		} else {
			$data['sort_order'] = '';
		}
		
		if (isset($this->request->post['dest_sql'])) {
			$data['dest_sql'] = $this->request->post['dest_sql'];
		} elseif (!empty($module_info)) {
			$data['dest_sql'] = htmlspecialchars_decode($module_info['dest_sql']);
		} else {
			$data['dest_sql'] = '';
		}
		
		if (isset($this->request->post['dest_json'])) {
			$data['dest_json'] = $this->request->post['dest_json'];
		} elseif (!empty($module_info)) {
			$data['dest_json'] = str_replace(array("\r","\n"," "),"", htmlspecialchars_decode($module_info['dest_json']));
		} else {
			$data['dest_json'] = '';
		}
		$ar = json_decode($data['dest_json'], TRUE);
		if (is_array($ar) && count($ar) > 0) {
			$this->checkArray($ar);
		
			$data['dest_json'] = str_replace("\\\"", "\\\\\"", json_encode($ar));
		}
		
		if (isset($this->request->post['source_sql'])) {
			$data['source_sql'] = $this->request->post['source_sql'];
		} elseif (!empty($module_info)) {
			$data['source_sql'] = htmlspecialchars_decode($module_info['source_sql']);
		} else {
			$data['source_sql'] = '';
		}
		
		if (isset($this->request->post['source_json'])) {
			$data['source_json'] = $this->request->post['source_json'];
		} elseif (!empty($module_info)) {
			$data['source_json'] = str_replace(array("\r","\n"," "),"", htmlspecialchars_decode($module_info['source_json']));
		} else {
			$data['source_json'] = '';
		}
		$ar = json_decode($data['source_json'], TRUE);
		if (is_array($ar) && count($ar) > 0) {
			$this->checkArray($ar);
			
			$data['source_json'] = str_replace("\\\"", "\\\\\"", json_encode($ar));
		}
		//if (haveOptionValue($ar);
		$data['token'] = $this->session->data['token'];
		
		$data['tables']['product_columns'] = $this->model_extension_module_afoc3->getColumns('product', $this->language->get('eantry_product'), 'p');
		
		$exclude_fields = array('language_id', 'product_id');
		$data['tables']['product_description_columns'] = $this->model_extension_module_afoc3->getColumns('product_description', $this->language->get('eantry_product'), 'pdesc', $exclude_fields);
		
		$exclude_fields = array('product_id', 'language_id');
		$data['tables']['product_attribute_columns'] = $this->model_extension_module_afoc3->getColumns('product_attribute', $this->language->get('eantry_product_attribute'),'pattr', $exclude_fields);
		
		$exclude_fields = array('product_id', 'product_option_id', 'product_option_value_id');
		$data['tables']['product_option_columns'] = $this->model_extension_module_afoc3->getColumns('product_option_value', $this->language->get('eantry_product_option'),'popt', $exclude_fields);
		
		$data['tables']['category_columns'] = $this->model_extension_module_afoc3->getColumns('category', $this->language->get('eantry_category'),'cat');
		
		$exclude_fields = array('product_id', 'product_discount_id');
		$data['tables']['product_discount'] = $this->model_extension_module_afoc3->getColumns('product_discount', $this->language->get('eantry_product_discount'),'pdis', $exclude_fields);
		
		$exclude_fields = array('product_id', 'product_special_id');
		$data['tables']['product_special'] = $this->model_extension_module_afoc3->getColumns('product_special', $this->language->get('eantry_product_special'),'pspec', $exclude_fields);
	
		$exclude_fields = array('language_id', 'category_id');
		$data['tables']['category_description_columns'] = $this->model_extension_module_afoc3->getColumns('category_description', $this->language->get('eantry_category'),'catdesc', $exclude_fields);
		
		$exclude_fields = array('category_id');
		$data['tables']['category_description_path'] = $this->model_extension_module_afoc3->getColumns('category_path', $this->language->get('eantry_category'),'catp', $exclude_fields);
		
		$exclude_fields = array('language_id', 'attribute_id');
		$data['tables']['attribute_columns'] = $this->model_extension_module_afoc3->getColumns('attribute_description', $this->language->get('eantry_product_attribute'),'attrdesc', $exclude_fields);
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/afoc3.tpl', $data));
	}
	
	public function adaptation() {
      $this->load->model('extension/modification');
      $xml = array();
      $xml[] = file_get_contents(DIR_SYSTEM . 'modification.xml');

			$files = glob(DIR_SYSTEM . '*.ocmod.xml');

			if ($files) {
				foreach ($files as $file) {
					$xml[] = file_get_contents($file);
				}
			}
      
      $results = $this->model_extension_modification->getModifications();

			foreach ($results as $result) {
				if ($result['status']) {
					$xml[] = $result['xml'];
				}
			}

			$modification = array();
      $xmlstr = '<?xml version="1.0" encoding="utf-8"?>
  <modification>
  <name>Автоматически рекомендуемые товары</name>
  <code>afoc3</code>
  <version>1.0</version>
  <author>2304 Studio</author>
  <link>http://2304.ru</link>
   <file path="catalog/controller/extension/module/afoc3.php">';
      foreach ($xml as $xml) {
				if (empty($xml)){
					continue;
				}
				if (strpos($xml,'opencart turbo')) {
          continue;
        }
				$dom = new DOMDocument('1.0', 'UTF-8');
				$dom->preserveWhiteSpace = false;
				$dom->loadXml($xml);
        $files = $dom->getElementsByTagName('modification')->item(0)->getElementsByTagName('file');
        foreach ($files as $file) {
          $operations = $file->getElementsByTagName('operation');

					$files = explode('|', $file->getAttribute('path'));
          foreach ($files as $file) {
            $path = '';

						// Get the full path of the files that are going to be used for modification
						if ((substr($file, 0, 7) == 'catalog')) {
							$path = DIR_CATALOG . substr($file, 8);
						}

						if ((substr($file, 0, 5) == 'admin')) {
							$path = DIR_APPLICATION . substr($file, 6);
						}

						if ((substr($file, 0, 6) == 'system')) {
							$path = DIR_SYSTEM . substr($file, 7);
						}

						if ($path) {
							$files = glob($path, GLOB_BRACE);

							if ($files) {
								foreach ($files as $file) {
                  if (substr($file, -13) == '/featured.php') {
                    foreach ($operations as $operation) {
                        $xmlstr .= '
      ' . str_replace("/featured","/afoc3",$operation->ownerDocument->saveXML($operation));
                    }
                  }
                }
              }
            }
          }
        }
      }
      //$xml = new SimpleXMLElement($xmlstr);
$xmlstr .= '	</file>
</modification>';
      $this->response->addHeader('Content-Description: File Transfer');
      $this->response->addHeader('Content-Type: application/octet-stream');
      $this->response->addHeader('Content-Disposition: attachment; filename=afoc3.ocmod.xml');
      $this->response->addHeader('Content-Transfer-Encoding: binary');
      $this->response->setOutput($xmlstr);

	}
  
	private function checkArray(&$arr) {
		if (is_array($arr)) { 
			if (array_key_exists('id', $arr) && array_key_exists('value', $arr)) {
				if (strpos($arr['id'], '.product_id') && is_array($arr['value'])) {
					$arr['value'][0] = $this->getProduct($arr['value'][1]);
				}
				if (strpos($arr['id'], '.category_id') && is_array($arr['value']) ) {
					$arr['value'][0] = $this->getCategory($arr['value'][1]);
				}
				if (strpos($arr['id'], '.parent_id') && is_array($arr['value'])) {
					$arr['value'][0] = $this->getCategory($arr['value'][1]);
				}
				if (strpos($arr['id'], '.manufacturer_id') && is_array($arr['value'])) {
					$arr['value'][0] = $this->getManufacturer($arr['value'][1]);
				}
				if (strpos($arr['id'], '.attribute_id') && is_array($arr['value'])) {
					$arr['value'][0] = $this->getAttribute($arr['value'][1]);
				}
				if (strpos($arr['id'], '.option_id') && is_array($arr['value'])) {
					$arr['value'][0] = $this->getOption($arr['value'][1]);
				} 
			}
			else {
				foreach ($arr as &$val) {
					$this->checkArray($val);
				}
			}
		}
	}
	private function getProduct($product_id) {
		$this->load->model('catalog/product');
		$product_info = $this->model_catalog_product->getProduct($product_id);
		if ($product_info) {
			return htmlspecialchars_decode($product_info['name']); 
		}

		return "";
	}
	
	private function getCategory($category_id) {
		$this->load->model('catalog/category');
		$category_info = $this->model_catalog_category->getCategoryDescriptions($category_id);
		if ($category_info) {
			$this->load->model('localisation/language');
			$langs = $this->model_localisation_language->getLanguages();
			return htmlspecialchars_decode($category_info[$langs[$this->config->get('config_language')]['language_id']]['name']); 
		}

		return "";
	
	}
	
	private function getAttribute($attribute_id) {
		$this->load->model('catalog/attribute');
		$attribute_info = $this->model_catalog_attribute->getAttributeDescriptions($attribute_id);
		if ($attribute_info) {
			$this->load->model('localisation/language');
			$langs = $this->model_localisation_language->getLanguages();
			return htmlspecialchars_decode($attribute_info[$langs[$this->config->get('config_language')]['language_id']]['name']); 
		}

		return "";
		
	}
	
	private function getOption($option_id) {
		$this->load->model('catalog/option');
		$option_info = $this->model_catalog_option->getOptionDescriptions($option_id);
		if ($option_info) {
			$this->load->model('localisation/language');
			$langs = $this->model_localisation_language->getLanguages();
			return htmlspecialchars_decode($option_info[$langs[$this->config->get('config_language')]['language_id']]['name']); 
		}

		return "";
		
	}
	
	public function getOptionValues() {
		
		$this->load->model('catalog/option');
		
		$option_value_data = array();
		
		if (isset($this->request->get['option_id'])) {
			
		
			$option_values = $this->model_catalog_option->getOptionValues($this->request->get['option_id']);

			foreach ($option_values as $option_value) {

				$option_value_data[] = array(
					'option_value_id' => $option_value['option_value_id'],
					'name'            => strip_tags(html_entity_decode($option_value['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($option_value_data));
		
	}
	
	public function getManufacturer($manufacturer_id) {
		$this->load->model('catalog/manufacturer');
		$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);
		if ($manufacturer_info) {
			return htmlspecialchars_decode($manufacturer_info['name']); 
		}

		return "";

	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/afoc3')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		
		return !$this->error;
	}
}
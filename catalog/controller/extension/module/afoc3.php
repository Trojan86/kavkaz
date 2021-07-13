<?php
class ControllerExtensionModuleafoc3 extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/afoc3');
		
		$this->load->model('extension/module/afoc3');
				
		$data['heading_title'] = $setting['title'][$this->config->get('config_language_id')]['name'];
		
		$data['text_tax'] = $this->language->get('text_tax');
        $data['text_cart_info_weight'] = $this->language->get('text_cart_info_weight');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		
		$this->load->model('catalog/product');
		
		$this->load->model('extension/module/afoc3');
		
		$products_src = array();
		
		if (isset($this->request->get['product_id'])) {
			$products_src[] = $this->request->get['product_id'];
		}
		$products = $this->model_extension_module_afoc3->getProducts($setting, $products_src);  
		
		$this->load->model('tool/image');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if ($products) {
			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
                        'minimum'     => ($product_info['minimum'] > 0) ? $product_info['minimum'] : 1,
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
                        'price_for_calc'      => round($product_info['price']),
                        'special'     => $special,
                        'special_for_calc' => round($product_info['special']),
                        'currency'    => $this->session->data['currency'],
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
                        'weight'      => $this->weight->format($product_info['weight'], $product_info['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point'))
					);
				}
			}
		}

		if ($data['products']) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_theme') . '/template/extension/module/afoc3.tpl')) {
				return $this->load->view('extension/module/afoc3.tpl', $data);
			} elseif (file_exists(DIR_TEMPLATE . $this->config->get('config_theme') . '/template/extension/module/featured.tpl')) {
				return $this->load->view('extension/module/featured.tpl', $data);
			} else {
				return $this->load->view('extension/module/afoc3.tpl', $data);
			}
		}
			
	}}
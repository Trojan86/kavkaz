<?php
// *	@copyright	Arekaev Aleksey web-mehanik@yandex.ru 2017
// *	@site	http://energia-it.ru

class ControllerExtensionModuleCustomTabSettings extends Controller {
    public function index($setting) {
        $this->load->language('extension/module/custom_tab_settings');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_tax'] = $this->language->get('text_tax');
        $data['text_cart_info_weight'] = $this->language->get('text_cart_info_weight');

        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');

        $this->load->model('catalog/product');
        $this->load->model('extension/module/custom_tab_settings');

        $this->load->model('tool/image');

        $data['tabs'] = array();

        if (!$setting['limit']) {
            $setting['limit'] = 15;
        }
        

        if ($setting['tab']) {foreach ($setting['tab'] as $tab_id) {

            $products = array();

            $tab_info = $this->model_extension_module_custom_tab_settings->getTab($tab_id);
            $results = $this->model_extension_module_custom_tab_settings->getTabProducts($tab_id);
            $results_cat = $this->model_extension_module_custom_tab_settings->getTabToCategory($tab_id);


            if (!empty($results)) {
                foreach ($results as $product_id) {
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

                        $products[] = array(
                            'product_id'  => $product_info['product_id'],
                            'minimum'     => ($product_info['minimum'] > 0) ? $product_info['minimum'] : 1,
                            'thumb'       => $image,
                            'name'        => $product_info['name'],
                            'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                            'price'       => $price,
                            'price_for_calc'      => $product_info['price'],
                            'special'     => $special,
                            'special_for_calc' => $product_info['special'],
                            'currency'    => $this->session->data['currency'],
                            'tax'         => $tax,
                            'rating'      => $rating,
                            'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
                            'weight'      => $this->weight->format($product_info['weight'], $product_info['weight_class_id'], $this->language->get('decimal_point'), $this->language->get('thousand_point'))
                        );
                    }
                }
            }

            if (!empty($products)) {
                $data['tabs'][] = array(
                    'tab_id'   => $tab_info['tab_id'],
                    'title'    => $tab_info['name'],
                    'products' => $products
                );
            }
            if (!empty($products)) {
                $data['cats'][] = array(
                    'tab_id'   => $results_cat['tab_id'],
                    'cat_id'   => $results_cat['category_id'],
                    'cat_href' => $this->url->link('product/category', 'path=' . $results_cat['category_id'])
                );
            }
        }}

        // echo '<pre>';
        // var_dump($data['tabs']);
        // echo '</pre>';

        if ($data['tabs']) {
            return $this->load->view('extension/module/custom_tab_settings', $data);
        }
    }
}
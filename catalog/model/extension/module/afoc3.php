<?php
class ModelExtensionModuleafoc3 extends Model
{
    public function getProducts($settings, $products_src)
    {
        
        $src_prod = array();
        
        foreach ($products_src as $product_id) {
            $src_prod[] = (int) $product_id;
        }
        
        $dest_ar = json_decode(htmlspecialchars_decode($settings['dest_json']), TRUE);
        
        $used_tables = array();
        
        $this->fill_used_tables($dest_ar, $used_tables);
        
        $src_ar          = json_decode(htmlspecialchars_decode($settings['source_json']), TRUE);
        $used_tables_src = array();
        
        $this->fill_used_tables($src_ar, $used_tables_src);
        
        $dest_sql   = $this->parseToSQL($dest_ar, $settings, $src_prod, $used_tables);
        $source_sql = $this->parseToSQL($src_ar, $settings, $src_prod, $used_tables);
        
        $search_table = substr($settings['sort'], 0, strpos($settings['sort'], '.'));
        
        if (!in_array($search_table, $used_tables)) {
            $used_tables[] = $search_table;
        }
        
        
        
        $products = array();
        
        //print_r($source_sql);
        if (count($src_prod) > 0) {
            
            $sql_src = "SELECT p.product_id FROM " . DB_PREFIX . "product p";
            
            if (in_array('pdesc', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_description pdesc ON (pdesc.product_id = p.product_id AND pdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
            }
            
            if (in_array('pdis', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_discount pdis ON (pdis.product_id = p.product_id AND pdis.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "')";
            }
            
            if (in_array('pspec', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_special pspec ON (pspec.product_id = p.product_id AND pspec.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "')";
            }
            if (in_array('pattr', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_attribute pattr ON (pattr.product_id  IN (" . implode(',', $src_prod) . ") AND pattr.language_id = '" . (int) $this->config->get('config_language_id') . "')";
            }
            if (in_array('filt', $used_tables_src) || in_array('filtdesc', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_filter filt ON (filt.product_id  IN (" . implode(',', $src_prod) . "))";
            }
            if (in_array('filtdesc', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "filter_description filtdesc ON (filtdesc.filter_id = filt.filter_id AND filtdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
            }
            if (in_array('popt', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_option_value popt ON (popt.product_id  IN (" . implode(',', $src_prod) . "))";
            }
            if (in_array('cat', $used_tables_src) || in_array('catdesc', $used_tables_src) || in_array('catp', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "product_to_category ptc ON (ptc.product_id = p.product_id)";
            }
            if (in_array('cat', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "category cat ON (cat.category_id = ptc.category_id)";
            }
            if (in_array('catdesc', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "category_description catdesc ON (catdesc.category_id = ptc.category_id AND catdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
            }
            if (in_array('catp', $used_tables_src)) {
                $sql_src .= " LEFT JOIN " . DB_PREFIX . "category_path catp ON (catp.category_id = ptc.category_id)";
            }

            if (count($source_sql) > 0) {
                $source_sql_imploded = implode($src_ar['condition'] . ' ', $source_sql);
                $sql_src .= " WHERE (" . $source_sql_imploded . ")";
                
                $query = $this->db->query($sql_src);
                if (count($products_src) > 0) {
                    $sql_src .= " AND p.product_id IN (" . implode(',', $src_prod) . ")";
                }
                
            }
			else {
				//return $products;
			}
			
            if (count($used_tables_src)) {
            	$query = $this->db->query($sql_src);
                if (!$query->num_rows) {
                    return $products;
                }
            }
            
        }
        
        $sql = "SELECT pd.product_id";
        if (in_array('pattrd', $used_tables)) {
            $sql .= ", count(distinct pattrd.attribute_id) as matching_attr";
        }
        if (in_array('poptd', $used_tables)) {
            $sql .= ", count(distinct poptd.option_id) as matching_opt";
        }
        $sql .= " FROM " . DB_PREFIX . "product pd";
        
        if (count($products_src) == 0 && (in_array('p', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('pdesc', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('pdis', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('pspec', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('pattr', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('popt', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('cat', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('catdesc', $used_tables))) {
            return $products;
        }
        if (count($products_src) == 0 && (in_array('catp', $used_tables))) {
            return $products;
        }
        
        if (count($products_src) > 0) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product p ON (p.product_id IN (" . implode(',', $src_prod) . "))";
        }
        if (in_array('pdesc', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pdesc ON (pdesc.product_id = p.product_id AND pdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        
        if (in_array('pdescd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pdescd ON (pdescd.product_id = pd.product_id AND pdescd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        
        if (in_array('pdis', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_discount pdis ON (pdis.product_id = p.product_id AND pdis.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "')";
        }
        
        if (in_array('pdisd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_discount pdisd ON (pdisd.product_id = pd.product_id AND pdisd.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "')";
        }
        
        if (in_array('pspec', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_special pspec ON (pspec.product_id = p.product_id AND pspec.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "')";
        }
        
        if (in_array('pspecd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_special pspecd ON (pspecd.product_id = pd.product_id AND pspecd.customer_group_id = '" . (int) $this->config->get('config_customer_group_id') . "')";
        }
        
        if (in_array('filt', $used_tables_src) || in_array('filtdesc', $used_tables_src)) {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_filter filt ON (filt.product_id  IN (" . implode(',', $src_prod) . "))";
        }
        if (in_array('filtdesc', $used_tables_src)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "filter_description filtdesc ON (filtdesc.filter_id = filt.filter_id AND filtdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
         
        if (in_array('filtd', $used_tables_src) || in_array('filtdescd', $used_tables_src)) {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_filter filtd ON (filtd.product_id = pd.product_id)";
        }
        if (in_array('filtdesc', $used_tables_src)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "filter_description filtdescd ON (filtdescd.filter_id = filtd.filter_id AND filtdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        
        if (in_array('pattr', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute pattr ON (pattr.product_id  IN (" . implode(',', $src_prod) . ") AND pattr.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        if (in_array('pattrd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute pattrd ON (pd.product_id = pattrd.product_id AND pattrd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        
        if (in_array('popt', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_option_value popt ON (popt.product_id  IN (" . implode(',', $src_prod) . "))";
        }
        if (in_array('poptd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_option_value poptd ON (poptd.product_id = pd.product_id)";
        }
        if (in_array('cat', $used_tables) || in_array('catdesc', $used_tables) || in_array('catp', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category ptc ON (ptc.product_id = p.product_id)";
        }
        if (in_array('catd', $used_tables) || in_array('catdescd', $used_tables) || in_array('catpd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category ptcd ON (ptcd.product_id = pd.product_id)";
        }
        if (in_array('cat', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "category cat ON (cat.category_id = ptc.category_id)";
        }
        if (in_array('catd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "category catd ON (catd.category_id = ptcd.category_id)";
        }
        if (in_array('catdesc', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "category_description catdesc ON (catdesc.category_id = ptc.category_id AND catdesc.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        
        if (in_array('catdescd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "category_description catdescd ON (catdescd.category_id = ptcd.category_id AND catdescd.language_id = '" . (int) $this->config->get('config_language_id') . "')";
        }
        if (in_array('catp', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "category_path catp ON (catp.category_id = ptc.category_id)";
            $sql .= " LEFT JOIN (SELECT MAX(cp.level) lvl FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category ptc ON (ptc.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "category_path cp ON (ptc.category_id = cp.category_id) WHERE p.product_id IN (" . implode(',', $src_prod) . ")) maxlvl ON (TRUE)";
        }
        if (in_array('catpd', $used_tables)) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "category_path catpd ON (catpd.category_id = ptcd.category_id)";
            
        }
        $matching_str      = "";
        if (isset($dest_ar['condition'])) {
	        $dest_sql_imploded = implode($dest_ar['condition'] . ' ', $dest_sql);
	        if ($dest_sql_imploded != '') {
	            $number_attr = preg_match_all('/AND matching_attr.+?[0-9]+\'/', htmlspecialchars_decode($dest_sql_imploded), $matches_attr);
	            if ($number_attr > 0) {
	                $matching_str .= $matching_str == "" ? $this->str_replace_once('AND', ' HAVING', implode(' ', $matches_attr[0])) : ' ' . implode(' ', $matches_attr[0]);
	                $dest_sql_imploded = preg_replace('/AND matching_attr.+?[0-9]+\'/', '', $dest_sql_imploded);
	            }
	            $number_opt = preg_match_all('/AND matching_opt.+?[0-9]+/', htmlspecialchars_decode($dest_sql_imploded), $matches_opt);
	            if ($number_opt > 0) {
	                $matching_str .= $matching_str == "" ? $this->str_replace_once('AND', ' HAVING', implode(' ', $matches_opt[0])) : ' ' . implode(' ', $matches_opt[0]);
	                $dest_sql_imploded = preg_replace('/AND matching_opt.+?[0-9]+\'/', '', $dest_sql_imploded);
	            }
	            $atributes = array();
	            
	            
	            if (isset($dest_ar['condition'])) {
	                $condition = $dest_ar['condition'];
	                $sql .= " WHERE " . $dest_sql_imploded;
	                
	            }
	        }
        }
        
        $sql .= " GROUP BY pd.product_id" . $matching_str;
		if ($this->db->escape($settings['sort']) == "sortprice") {
			$sql .= " ORDER BY ABS(p.price - pd.price)";
		}
		else {
			$sql .= " ORDER BY " . $this->db->escape($settings['sort']);
		}
		$sql .= " " . ($settings['sort_order'] == 0 ? ' DESC' : ' ASC') . " LIMIT " . (int) $settings['limit'];
		//print_r($sql);
        $query = $this->db->query($sql);
        
        
        foreach ($query->rows as $row) {
            $products[] = $row['product_id'];
        }
        return $products;
    }
    
    private function parseToSQL($group, $settings, $src_prod, $used_tables)
    {
        $append_sql = '';
        
        
        if (isset($group['rules']) && is_array($group['rules']) && count($group['rules']) > 0) {
            
            $part = array();
            foreach ($group['rules'] as $rule) {
                
                if (isset($rule['field'])) {
                    
                    $src_field  = $this->db->escape(str_replace('d.', '.', $rule['field']));
                    $dest_field = $this->db->escape($rule['field']);
                    
                    if ($rule['operator'] === 'equal') {
                        if ($rule['type'] === 'integer') {
                            $part[] = $dest_field . " = '" . (int) $rule['value'] . "' ";
                        } elseif ($rule['type'] === 'double') {
                            $part[] = $dest_field . " = '" . (float) $rule['value'] . "' ";
                        } elseif ($rule['type'] === 'string') {
                            $part[] = $dest_field . " = '" . $this->db->escape($rule['value']) . "' ";
                        }
                    } elseif ($rule['operator'] === 'not_equal') {
                        if ($rule['type'] === 'integer') {
                            $part[] = $dest_field . " != '" . (int) $rule['value'] . "' ";
                        } elseif ($rule['type'] === 'double') {
                            $part[] = $dest_field . " != '" . (float) $rule['value'] . "' ";
                        } elseif ($rule['type'] === 'string') {
                            $part[] = $dest_field . " != '" . $this->db->escape($rule['value']) . "' ";
                        }
                    } elseif ($rule['operator'] === 'less') {
                        $part[] = $dest_field . " < '" . (int) $rule['value'] . "' ";
                    } elseif ($rule['operator'] === 'less_or_equal') {
                        $part[] = $dest_field . " <= '" . (int) $rule['value'] . "' ";
                    } elseif ($rule['operator'] === 'greater') {
                        $part[] = $dest_field . " > '" . (int) $rule['value'] . "' ";
                    } elseif ($rule['operator'] === 'greater_or_equal') {
                        $part[] = $dest_field . " >= '" . (int) $rule['value'] . "' ";
                    } elseif ($rule['operator'] === 'between') {
                        $part[] = $dest_field . " BETWEEN '" . (int) $rule['value'][0] . "' AND '" . (int) $rule['value'][1] . "' ";
                    } elseif ($rule['operator'] === 'not_between') {
                        $part[] = $dest_field . " NOT BETWEEN '" . (int) $rule['value'][0] . "' AND '" . (int) $rule['value'][1] . "' ";
                    } elseif ($rule['operator'] === 'contains') {
                        $part[] = $dest_field . " LIKE '%" . (int) $rule['value'] . "%' ";
                    } elseif ($rule['operator'] === 'not_contains') {
                        $part[] = $dest_field . " NOT LIKE '%" . (int) $rule['value'] . "%' ";
                    } elseif ($rule['operator'] === 'is_empty') {
                        $part[] = $dest_field . " = '' ";
                    } elseif ($rule['operator'] === 'is_not_empty') {
                        $part[] = $dest_field . " != '' ";
                    } elseif ($rule['operator'] === 'ac_equal') {
                        $part[] = $dest_field . " = '" . (int) $rule['value'][1] . "' ";
                    } elseif ($rule['operator'] === 'ac_not_equal') {
                        $part[] = $dest_field . " != '" . (int) $rule['value'][1] . "' ";
                    } elseif ($rule['operator'] === 'equal_source') {
                        
                        $part[] = $dest_field . " = " . $src_field . " ";
                        
                    } elseif ($rule['operator'] === 'not_equal_source') {
                        $part[] = $dest_field . " != " . $src_field . " ";
                    } elseif ($rule['operator'] === 'less_then_source') {
                        $part[] = $dest_field . " < " . $src_field . " - " . (float) $rule['value'] . " ";
                    } elseif ($rule['operator'] === 'greater_then_source') {
                        $part[] = $dest_field . " > " . $src_field . " + " . (float) $rule['value'] . " ";
                    } elseif ($rule['operator'] === 'equal_source_attribute') {
                        $tempstr    = '';
                        $attr_delim = $this->db->escape($settings['delim']);
                        if ($attr_delim != '' && count($src_prod) > 0 && in_array('pattr', $used_tables)) {
                            $sql_attr = "SELECT attribute_id, text FROM " . DB_PREFIX . "product_attribute";
                            $sql_attr .= " WHERE product_id IN (" . implode(',', $src_prod) . ") AND attribute_id = '" . (int) $rule['value'][1] . "'";
                            $query        = $this->db->query($sql_attr);
                            $atribute_row = $query->row['text'];
                            
                            if ($atribute_row) {
                                $atribute_values = explode($attr_delim, $atribute_row);
                                if (count($atribute_values) > 0) {
                                    foreach ($atribute_values as $attribute_text) {
                                        $attr_like = $this->db->escape($attribute_text);
                                        $tempstr .= ($tempstr == "" ? "" : " OR ") . $dest_field . " = '" . $attr_like . "' OR " . $dest_field . " LIKE '%" . $attr_delim . $attr_like . "' OR " . $dest_field . " LIKE '" . $attr_like . $attr_delim . "%' OR " . $dest_field . " LIKE '%" . $attr_delim . $attr_like . $attr_delim . "%'";
                                    }
                                }
                            }
                            
                        }
                        if ($tempstr != '') {
                            $part[] = "((" . $tempstr . ") AND pattr.attribute_id = '" . (int) $rule['value'][1] . "') ";
                        } else {
                            $part[] = "(" . $dest_field . " = " . $src_field . " AND pattr.attribute_id = '" . (int) $rule['value'][1] . "') ";
                        }
                    } elseif ($rule['operator'] === 'not_equal_source_attribute') {
                        $tempstr    = '';
                        $attr_delim = $this->db->escape($settings['delim']);
                        if ($attr_delim != '' && count($src_prod) > 0 && in_array('pattr', $used_tables)) {
                            $sql_attr = "SELECT attribute_id, text FROM " . DB_PREFIX . "product_attribute";
                            $sql_attr .= " WHERE product_id IN (" . implode(',', $src_prod) . ") AND attribute_id = '" . (int) $rule['value'][1] . "'";
                            $query        = $this->db->query($sql_attr);
                            $atribute_row = $query->row['text'];
                            
                            if ($atribute_row) {
                                $atribute_values = explode($attr_delim, $atribute_row);
                                if (count($atribute_values) > 0) {
                                    foreach ($atribute_values as $attribute_text) {
                                        $attr_like = $this->db->escape($attribute_text);
                                        $tempstr .= ($tempstr == "" ? "" : " AND ") . $dest_field . " != '" . $attr_like . "' AND " . $dest_field . " NOT LIKE '%" . $attr_delim . $attr_like . "' AND " . $dest_field . " NOT LIKE '" . $attr_like . $attr_delim . "%' AND " . $dest_field . " NOT LIKE '%" . $attr_delim . $attr_like . $attr_delim . "%'";
                                    }
                                }
                            }
                            
                        }
                        if ($tempstr != '') {
                            $part[] = "((" . $tempstr . ") AND pattr.attribute_id = '" . (int) $rule['value'][1] . "') ";
                        } else {
                            $part[] = "(" . $dest_field . " != " . $src_field . " AND pattr.attribute_id = '" . (int) $rule['value'][1] . "') ";
                        }
                    } elseif ($rule['operator'] === 'equal_source_option') {
                        $part[] = "(" . $dest_field . " = " . $src_field . " AND popt.option_id = '" . (int) $rule['value'][1] . "') ";
                    } elseif ($rule['operator'] === 'ac_max_level') {
                        $part[] = $dest_field . " = maxlvl.lvl ";
                    } elseif ($rule['operator'] === 'ac_option_equal') {
                        $part[] = "(" . $dest_field . " = " . (int) $rule['value'][3] . "' AND " . $dest_field . " = '" . (int) $rule['value'][1] . "') ";
                    } elseif ($rule['operator'] === 'ac_option_not_equal') {
                        $part[] = "(" . $dest_field . " != " . (int) $rule['value'][3] . "' AND " . $dest_field . " = '" . (int) $rule['value'][1] . "') ";
                    }
                    
                    
                }
                if (isset($rule['rules'])) {
                    $part[] = '(' . implode($rule['condition'] . ' ', $this->parseToSQL($rule, $settings, $src_prod, $used_tables)) . ') ';
                }
                
            }
            return $part;
        }
    }
    private function str_replace_once($search, $replace, $text)
    {
        $pos = strpos($text, $search);
        return $pos !== false ? substr_replace($text, $replace, $pos, strlen($search)) : $text;
    }
    private function fill_used_tables($arr, &$used_tables)
    {
        
        if (is_array($arr)) {
            
            foreach ($arr as $key => $val) {
                if ($key === 'operator' && $val === 'not_equal_source') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'equal_source') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                
                if ($key === 'operator' && $val === 'equal_source_attribute') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'not_equal_source_attribute') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'equal_source_option') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'not_equal_source_option') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'less_then_source') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'greater_then_source') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'operator' && $val === 'ac_max_level') {
                    $used_tables[] = substr($arr['field'], 0, strpos($arr['field'], ".") - 1);
                }
                if ($key === 'field') {
                    
                    $search_table = substr($val, 0, strpos($val, '.'));
                    
                    if (!in_array($search_table, $used_tables)) {
                        $used_tables[] = $search_table;
                    }
                }
                $this->fill_used_tables($val, $used_tables);
            }
        }
    }
}
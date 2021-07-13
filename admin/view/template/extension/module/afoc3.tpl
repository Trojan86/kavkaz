<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a href="<?php echo $adaptation; ?>" data-toggle="tooltip" title="<?php echo $adaptation_text; ?>" class="btn btn-success" target="_blank"><i class="fa fa-download"></i></a>
        <button type="submit" form="form-module" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
          <ul class="nav nav-tabs">
             <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
             <li><a href="#tab-cond-source" data-toggle="tab"><?php echo $tab_cond_source; ?></a></li>
             <li><a href="#tab-cond-dest" data-toggle="tab"><?php echo $tab_cond_dest; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">
  		        <div class="form-group">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                  <?php if ($error_name) { ?>
				  <div class="text-danger"><?php echo $error_name; ?></div>
				  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-preset"><?php echo $entry_preset; ?></label>
                <div class="col-sm-10">
                  <select name="preset" id="input-preset" class="form-control">
					<?php foreach ($preset_list as $preset_key => $preset_item) { ?>
					    <option value="<?php echo $preset_key; ?>" <?php if ($preset_key == $preset) { ?>selected="selected"<?php } ?>><?php echo $preset_item['name']; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-attr"><?php echo $entry_attr; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="attr_name" value="<?php echo $attr_name; ?>" placeholder="<?php echo $entry_attr; ?>" id="input-attr" class="form-control" />
                  <input type="hidden" name="attr" value="<?php echo $attr; ?>" class="attribute_val"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-option"><?php echo $entry_option; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="option_name" value="<?php echo $option_name; ?>" placeholder="<?php echo $entry_option; ?>" id="input-option" class="form-control" />
                  <input type="hidden" name="option" value="<?php echo $option; ?>" class="option_val"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_title; ?></label>
                <div class="col-sm-10">
				  <?php foreach ($languages as $language) { ?>
				      <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
					  <input type="text" name="title[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($title[$language['language_id']]) ? $title[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control" />
					  </div>
				  <?php } ?>
                </div>
              </div>
              <div class="form-group">
				<label class="col-sm-2 control-label" for="input-width"><?php echo $entry_width; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="width" value="<?php echo $width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-width" class="form-control" />
				  <?php if ($error_width) { ?>
				  <div class="text-danger"><?php echo $error_width; ?></div>
				  <?php } ?>
				</div>
			  </div>
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-height"><?php echo $entry_height; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="height" value="<?php echo $height; ?>" placeholder="<?php echo $entry_height; ?>" id="input-height" class="form-control" />
				  <?php if ($error_height) { ?>
				  <div class="text-danger"><?php echo $error_height; ?></div>
				  <?php } ?>
				</div>
			  </div>
              <div class="form-group">
				<label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
				</div>
			  </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-delim"><?php echo $entry_delim; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="delim" value="<?php echo $delim; ?>" placeholder="<?php echo $entry_delim; ?>" id="input-delim" class="form-control" />
                </div>
              </div>
              
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort"><?php echo $entry_sort; ?></label>
                <div class="col-sm-10">
                  <select name="sort" id="input-sort" class="form-control">
					<?php foreach ($tables as $table) { ?>
					  <?php foreach ($table as $column) { ?>
						<option value="<?php echo $column['prefix']; ?>d.<?php echo $column['name']; ?>" <?php if ($column['prefix'] . 'd.' . $column['name'] == $sort) { ?>selected="selected"<?php } ?>><?php echo $column['label']; ?></option>
					  <?php } ?>
					<?php } ?>
					<option value="sortprice" <?php if ("sortprice" == $sort) { ?>selected="selected"<?php } ?>><?php echo $entry_sortprice; ?></option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                <div class="col-sm-10">
                  <select name="sort_order" id="input-sort-order" class="form-control">
				    <?php if ($sort_order) { ?>
					<option value="1" selected="selected"><?php echo $entry_asc; ?></option>
                    <option value="0"><?php echo $entry_desc; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $entry_asc; ?></option>
                    <option value="0" selected="selected"><?php echo $entry_desc; ?></option>
					<?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
				<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
				<div class="col-sm-10">
				  <select name="status" id="input-status" class="form-control">
					<?php if ($status) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select>
				</div>
			  </div>
              
            </div>
            
            <div class="tab-pane" id="tab-cond-source">
              <div id="cond-source"></div>
              <input type="hidden" name="source_sql" id="source-sql"/>
              <input type="hidden" name="source_json" id="source-json"/>
            </div>
            <div class="tab-pane" id="tab-cond-dest">
              <div id="cond-dest"></div>
              <input type="hidden" name="dest_sql" id="dest-sql"/>
              <input type="hidden" name="dest_json" id="dest-json"/>
            </div>
          </div>
          
		        
		</form>
      </div>
    </div>
  </div>
  <script>
    
    $('#cond-source').queryBuilder({
      plugins: ['bt-tooltip-errors'],
      
      icons: {
  			add_group: 'fa fa-plus',
  			add_rule: 'fa fa-plus',
  			remove_group: 'fa fa-times',
  			remove_rule: 'fa fa-times',
  			sort: 'fa fa-sort',
  			error: 'fa fa-exclamation-circle'
  		},
      operators: $.fn.queryBuilder.constructor.DEFAULTS.operators.concat([
			{ type: 'ac_equal',  nb_inputs: 2, multiple: false, apply_to: ['string'] },
			{ type: 'ac_not_equal',  nb_inputs: 2, multiple: false, apply_to: ['string'] },
			{ type: 'ac_option_equal',  nb_inputs: 4, multiple: false, apply_to: ['string'] },
			{ type: 'ac_option_not_equal',  nb_inputs: 4, multiple: false, apply_to: ['string'] }
  		]),  
  		lang: {
        operators: {
          ac_equal: 'равно',
          ac_not_equal: 'не равно',
          ac_option_equal: 'равно',
          ac_option_not_equal: 'не равно'
		}
      },
      sqlOperators: {
        ac_equal: { op: ' = ' },
        ac_not_equal: { op: ' <> ' },
        ac_option_equal: { op: ' = ' },
        ac_option_not_equal: { op: ' <> ' }
      },
      filters: [
        <?php foreach ($tables as $table) { ?>
		<?php foreach ($table as $column) { ?>
        {
          id: '<?php echo $column['prefix']; ?>.<?php echo $column['name']; ?>',
          label: '<?php echo $column['label']; ?>',
          type: '<?php echo $column['type']; ?>',
          <?php if ($column['type'] == 'datetime') { ?>
          validation: {
            format: 'MM.YYYY-MM-DD'
          },
          plugin: 'datetimepicker',
          plugin_config: {
            language: 'ru',
      			pickDate: true,
      			pickTime: true,
      			icons: {
                time: "fa fa-clock-o",
                date: "fa fa-calendar",
                up: "fa fa-arrow-up",
                down: "fa fa-arrow-down"
            }
          },
          <?php } ?>
		  <?php if ($column['type'] == 'date') { ?>
          validation: {
            format: 'YYYY-MM-DD'
          },
          plugin: 'datetimepicker',
          plugin_config: {
            language: 'ru',
      			pickDate: true,
      			pickTime: false,
      			icons: {
                time: "fa fa-clock-o",
                date: "fa fa-calendar",
                up: "fa fa-arrow-up",
                down: "fa fa-arrow-down"
            }
          },
          <?php } ?>
		  <?php if ($column['name'] == 'option_value_id') { ?>
            input: function(rule, name) {
              
              var html = '';
              var new_name = name.match( /.+[_]/i );
              var index_el = name.replace(new_name, '', name);
              if (index_el == '0') {
                html += '<input class="form-control" type="text" name="' + name + '">';
              }
              if (index_el == '1') {
                html += '<input class="form-control option_val" type="hidden" name="' + name + '">';
                var $container = rule.$el.find('.rule-value-container');
                
                $container.on('change', '[name='+ name +']', function(){
                  var $option_el = $container.find('[name='+ name +']');
                  $.ajax({
              			url: 'index.php?route=extension/module/afoc3/getOptionValues&token=<?php echo $token; ?>&option_id=' + $option_el.val(),
              			dataType: 'json',
              			success: function(json) {
              				json.unshift({
              					option_value_id: 0,
              					name: '<?php echo $text_none; ?>'
              				});
              
              				h = $.map(json, function(item) {
              				  var h ='';
              				  if ($container.find('[name$=_3]').val() == item['option_value_id']) {
              				    h += '  <option value="' + item['option_value_id'] + '" selected="selected">' + item['name'] + '</option>';
              				  }
              				  else {
              				    h += '  <option value="' + item['option_value_id'] + '">' + item['name'] + '</option>';
              				  }
              				  return h;
              				});
              				$container.find('[name$=_2]').html(h).trigger('change');
              				//$container.find('[name$=_3]').val('').trigger('change');
              			}
              		});
                  
                });
              }
              if (index_el == '2') {
                html += '<select class="form-control" name="' + name + '"><select>';
                var $container = rule.$el.find('.rule-value-container');
                $container.on('change', '[name='+ name +']', function(){
                  $container.find('[name$=_3]').val(this.value).trigger('change');
                });
              }
              if (index_el == '3') {
                html += '<input class="form-control option_val_val" type="hidden" name="' + name + '">';
              }
              return html;
            },
          <?php } ?>
		  <?php if (count($column['values']) > 0) { ?>
            input: 'select',
            values: {
			<?php foreach ($column['values'] as $val_key => $value) { ?>
			  <?php echo $val_key; ?>:'<?php echo $value; ?>',
			<?php } ?>
            },
          <?php } ?>
          <?php if ($column['name'] == 'option_id' || $column['name'] == 'manufacturer_id' || $column['name'] == 'parent_id' || $column['name'] == 'product_id' || $column['name'] == 'attribute_id' || $column['name'] == 'category_id') { ?>
            operators: ['ac_equal', 'ac_not_equal'],
          <?php } elseif ($column['name'] == 'level') { ?>
			operators: ['equal', 'not_equal'],
		  <?php } elseif ($column['name'] == 'option_value_id') { ?>
		    operators: ['ac_option_equal', 'ac_option_not_equal', 'equal_source_option'],
		  <?php } else { ?>
            operators: [<?php echo $column['operators']; ?>],
          <?php } ?>
          
          
          optgroup: '<?php echo $column['group']; ?>'
        },
        <?php } ?>
        <?php } ?>
        
        ]
    })
    .on('ruleToSQL.queryBuilder.filter', function (e, rule) {
      if (rule.operator === 'ac_equal') {
        e.value+= "'" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'ac_not_equal') {
        e.value+= "'" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'ac_option_equal') {
        e.value+= "'" + parseInt(rule.value[3]) + "' AND popt.option_id = '" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'ac_option_not_equal') {
        e.value+= "'" + parseInt(rule.value[3]) + "' AND popt.option_id = '" + parseInt(rule.value[1]) + "'";
      }
      
    });
    $('#cond-source').on('afterCreateRuleInput.queryBuilder', function (e, rule) {
      setCategoryAutocompete(rule.$el.find('input.input-category'));
      setProductAutocompete(rule.$el.find('input.input-product'));
      setManufacturerAutocompete(rule.$el.find('input.input-manufacturer'));
      setAttributeAutocompete(rule.$el.find('input.input-attribute'));
      setOptionAutocompete(rule.$el.find('input.input-option'));
    });
    
    $('#cond-source').on('afterUpdateRuleOperator.queryBuilder afterUpdateRuleFilter.queryBuilder', function (e, rule) {
      if (rule.operator.type == 'ac_equal' || rule.operator.type == 'ac_not_equal') {
        rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().prop("type","hidden");
        if (rule.filter.field.indexOf('.product_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control product_val');
          setProductAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.category_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control category_val');
          setCategoryAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.parent_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control category_val');
          setCategoryAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.manufacturer_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control manufacturer_val');
          setManufacturerAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.attribute_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control attribute_val');
          setAttributeAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.option_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control option_val');
          setOptionAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
      }
      if (rule.operator.type == 'ac_option_equal' || rule.operator.type == 'ac_option_not_equal') {
        setOptionValueAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
      }
    });
	<?php if (isset($source_json) && $source_json != '') { ?>
	  $('#cond-source').queryBuilder('setRules', JSON.parse('<?php echo $source_json; ?>'));
	<?php } ?>
    
    $('#cond-dest').queryBuilder({
      plugins: ['bt-tooltip-errors'],
      
      icons: {
  			add_group: 'fa fa-plus',
  			add_rule: 'fa fa-plus',
  			remove_group: 'fa fa-times',
  			remove_rule: 'fa fa-times',
  			sort: 'fa fa-sort',
  			error: 'fa fa-exclamation-circle'
  		},
      
      operators: $.fn.queryBuilder.constructor.DEFAULTS.operators.concat([
        { type: 'ac_equal',  nb_inputs: 2, multiple: false, apply_to: ['string'] },
  			{ type: 'ac_not_equal',  nb_inputs: 2, multiple: false, apply_to: ['string'] },
  			{ type: 'equal_source',  nb_inputs: 0, multiple: false, apply_to: ['string'] },
			  { type: 'less_then_source',  nb_inputs: 1, multiple: false, apply_to: ['integer', 'double'] },
  			{ type: 'greater_then_source',  nb_inputs: 1, multiple: false, apply_to: ['integer', 'double'] },
  			{ type: 'not_equal_source',  nb_inputs: 0, multiple: false, apply_to: ['string'] },
  			{ type: 'equal_source_attribute',  nb_inputs: 2, multiple: false, apply_to: ['string'] },
  			{ type: 'equal_source_option',  nb_inputs: 2, multiple: false, apply_to: ['string'] },
  			{ type: 'ac_max_level',  nb_inputs: 0, multiple: false, apply_to: ['string'] },
  			{ type: 'ac_option_equal',  nb_inputs: 4, multiple: false, apply_to: ['string'] },
  			{ type: 'ac_option_not_equal',  nb_inputs: 4, multiple: false, apply_to: ['string'] }
  		]),
  		lang: {
        operators: {
          ac_equal: 'равно',
          ac_not_equal: 'не равно',
		      ac_max_level: 'самый нижний ур. приемника',
          equal_source: 'равно приемнику',
          not_equal_source: 'не равно приемнику',
		      less_then_source: 'меньше приемника на',
          greater_then_source: 'больше приемника на',
          equal_source_attribute: 'равно атрибуту приемника',
          equal_source_option: 'равно опции приемника',
          ac_option_equal: 'равно',
          ac_option_not_equal: 'не равно'
        }
      },
      sqlOperators: {
        ac_equal: { op: ' = ' },
        ac_not_equal: { op: ' <> ' },
		    ac_max_level: { op: ' = ' },
        equal_source: { op: ' = ' },
        not_equal_source: { op: ' <> ' },
		    less_then_source: { op: ' < ' },
        greater_then_source: { op: ' > ' },
        equal_source_attribute: { op: ' = ' },
        equal_source_option: { op: ' = ' },
        ac_option_equal: { op: ' = ' },
        ac_option_not_equal: { op: ' <> ' }
        
      },
      filters: [
        <?php foreach ($tables as $table) { ?>
		<?php foreach ($table as $column) { ?>
        {
          id: '<?php echo $column['prefix']; ?>d.<?php echo $column['name']; ?>',
          label: '<?php echo $column['label']; ?>',
          type: '<?php echo $column['type']; ?>',
          <?php if ($column['type'] == 'datetime') { ?>
          validation: {
            format: 'MM.YYYY-MM-DD'
          },
          plugin: 'datetimepicker',
          plugin_config: {
            language: 'ru',
      			pickDate: true,
      			pickTime: true,
      			icons: {
                time: "fa fa-clock-o",
                date: "fa fa-calendar",
                up: "fa fa-arrow-up",
                down: "fa fa-arrow-down"
            }
          },
          <?php } ?>
		  <?php if ($column['type'] == 'date') { ?>
          validation: {
            format: 'YYYY-MM-DD'
          },
          plugin: 'datetimepicker',
          plugin_config: {
            language: 'ru',
      			pickDate: true,
      			pickTime: false,
      			icons: {
                time: "fa fa-clock-o",
                date: "fa fa-calendar",
                up: "fa fa-arrow-up",
                down: "fa fa-arrow-down"
            }
          },
          <?php } ?>
		  <?php if ($column['name'] == 'option_value_id') { ?>
            input: function(rule, name) {
              
              var html = '';
              var new_name = name.match( /.+[_]/i );
              var index_el = name.replace(new_name, '', name);
              if (index_el == '0') {
                html += '<input class="form-control" type="text" name="' + name + '">';
              }
              if (index_el == '1') {
                html += '<input class="form-control option_val" type="hidden" name="' + name + '">';
                var $container = rule.$el.find('.rule-value-container');
                
                $container.on('change', '[name='+ name +']', function(){
                  var $option_el = $container.find('[name='+ name +']');
                  $.ajax({
              			url: 'index.php?route=extension/module/afoc3/getOptionValues&token=<?php echo $token; ?>&option_id=' + $option_el.val(),
              			dataType: 'json',
              			success: function(json) {
              				json.unshift({
              					option_value_id: 0,
              					name: '<?php echo $text_none; ?>'
              				});
              
              				h = $.map(json, function(item) {
              				  var h ='';
              				  if ($container.find('[name$=_3]').val() == item['option_value_id']) {
              				    h += '  <option value="' + item['option_value_id'] + '" selected="selected">' + item['name'] + '</option>';
              				  }
              				  else {
              				    h += '  <option value="' + item['option_value_id'] + '">' + item['name'] + '</option>';
              				  }
              				  return h;
              				});
              				$container.find('[name$=_2]').html(h).trigger('change');
              				//$container.find('[name$=_3]').val('').trigger('change');
              			}
              		});
                  
                });
              }
              if (index_el == '2') {
                html += '<select class="form-control" name="' + name + '"><select>';
                var $container = rule.$el.find('.rule-value-container');
                $container.on('change', '[name='+ name +']', function(){
                  $container.find('[name$=_3]').val(this.value).trigger('change');
                });
              }
              if (index_el == '3') {
                html += '<input class="form-control option_val_val" type="hidden" name="' + name + '">';
              }
              return html;
            },
          <?php } ?>
		  <?php if (count($column['values']) > 0) { ?>
            input: 'select',
            values: {
			<?php foreach ($column['values'] as $val_key => $value) { ?>
			  <?php echo $val_key; ?>:'<?php echo $value; ?>',
			<?php } ?>
            },
          <?php } ?>
		  <?php if ($column['name'] == 'text' || $column['name'] == 'pattr') { ?>
            operators: [<?php echo $column['operators']; ?>, 'equal_source_attribute'],
          <?php } elseif ($column['name'] == 'option_id' || $column['name'] == 'manufacturer_id' || $column['name'] == 'parent_id' || $column['name'] == 'product_id' || $column['name'] == 'attribute_id' || $column['name'] == 'category_id') { ?>
            operators: ['ac_equal', 'ac_not_equal', 'equal_source', 'not_equal_source', 'less_then_source', 'greater_then_source'],
		  <?php } elseif ($column['name'] == 'option_value_id') { ?>
			operators: ['ac_option_equal', 'ac_option_not_equal','equal_source_option'],
		  <?php } elseif ($column['name'] == 'level') { ?>
			operators: ['equal', 'not_equal', 'ac_max_level'],
		  <?php } else { ?>
            operators: [<?php echo $column['operators']; ?>, 'equal_source', 'not_equal_source'<?php if ($column['type'] == 'integer' || $column['type'] == 'double') { ?>, 'less_then_source', 'greater_then_source'<?php } ?>],
          <?php } ?>
          
          
          optgroup: '<?php echo $column['group']; ?>'
        },
        <?php } ?>
        <?php } ?>
        {
          id: 'matching_attr',
          label: '<?php echo $matching_attr; ?>',
          type: 'integer',
          optgroup: '<?php echo $eantry_product_attribute; ?>'
        },
        {
          id: 'matching_opt',
          label: '<?php echo $matching_opt; ?>',
          type: 'integer',
          optgroup: '<?php echo $eantry_product_option; ?>'
        },
        ]
    })
    .on('ruleToSQL.queryBuilder.filter', function (e, rule) {
      if (rule.operator === 'ac_equal') {
        e.value+= "'" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'ac_not_equal') {
        e.value+= "'" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'equal_source') {
        e.value+= rule.field.replace('d.', '.');
      }
	    if (rule.operator === 'less_then_source') {
        e.value+= rule.field.replace('d.', '.') + " - " + parseFloat(rule.value[0]);
      }
	    if (rule.operator === 'greater_then_source') {
        e.value+= rule.field.replace('d.', '.') + " + " + parseFloat(rule.value[0]);
      }
      if (rule.operator === 'not_equal_source') {
        e.value+= rule.field.replace('d.', '.');
      }
      if (rule.operator === 'equal_source_attribute') {
        e.value+= rule.field.replace('d.', '.') + " AND pattr.attribute_id = '" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'equal_source_option') {
        e.value+= rule.field.replace('d.', '.') + " AND popt.option_id = '" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'ac_max_level') {
        e.value+= "maxlvl.lvl";
      }
      if (rule.operator === 'ac_option_equal') {
        e.value+= "'" + parseInt(rule.value[3]) + "' AND poptd.option_id = '" + parseInt(rule.value[1]) + "'";
      }
      if (rule.operator === 'ac_option_not_equal') {
        e.value+= "'" + parseInt(rule.value[3]) + "' AND poptd.option_id = '" + parseInt(rule.value[1]) + "'";
      }
    });
    $('#cond-dest').on('afterCreateRuleInput.queryBuilder', function (e, rule) {
      setCategoryAutocompete(rule.$el.find('input.input-category'));
      setProductAutocompete(rule.$el.find('input.input-product'));
      setManufacturerAutocompete(rule.$el.find('input.input-manufacturer'));
      setAttributeAutocompete(rule.$el.find('input.input-attribute'));
      setOptionAutocompete(rule.$el.find('input.input-option'));
    });
    

    $('#cond-dest').on('afterUpdateRuleOperator.queryBuilder afterUpdateRuleFilter.queryBuilder', function (e, rule) {
      if (rule.operator.type == 'equal_source_attribute') {
        rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().prop("type","hidden");
        rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().addClass("attribute_val");
        setAttributeAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
      }
      if (rule.operator.type == 'equal_source_option') {
        rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().prop("type","hidden");
        rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().addClass("option_val");
        setOptionAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
      }
      if (rule.operator.type == 'ac_equal' || rule.operator.type == 'ac_not_equal') {
        rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().prop("type","hidden");
        if (rule.filter.field.indexOf('.product_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control product_val');
          setProductAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.category_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control category_val');
          setCategoryAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.parent_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control category_val');
          setCategoryAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.manufacturer_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control manufacturer_val');
          setManufacturerAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.attribute_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control attribute_val');
          setAttributeAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
        if (rule.filter.field.indexOf('.option_id') >= 0) {
          rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).last().attr('class','form-control option_val');
          setOptionAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
        }
      }
      if (rule.operator.type == 'ac_option_equal' || rule.operator.type == 'ac_option_not_equal') {
        setOptionValueAutocompete(rule.$el.find($.fn.queryBuilder.constructor.selectors.rule_value).first());
      }
    }); 
	<?php if (isset($dest_json) && $dest_json != '') { ?>
	  $('#cond-dest').queryBuilder('setRules', JSON.parse('<?php echo $dest_json; ?>'));
	<?php } ?>
    
function setCategoryAutocompete($el) {
  if ($el.length > 0) {
    $el.autocomplete({
    'source': function(request, response) {
    		$.ajax({
    			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
    			dataType: 'json',
    			success: function(json) {

    				response($.map(json, function(item) {
    					return {
    						label: item['name'],
    						value: item['category_id']
    					}
    				}));
    			}
    		});
    	},
    	'select': function(item) {
    		$(this).val(item['label']);
    		$(this).parent().find('.category_val').val(item['value']).trigger('change');
    	}
    });
  }
}
function setProductAutocompete($el) {
  if ($el.length > 0) {
    $el.autocomplete({
    'source': function(request, response) {
    		$.ajax({
    			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
    			dataType: 'json',
    			success: function(json) {

    				response($.map(json, function(item) {
    					return {
    						label: item['name'],
    						value: item['product_id']
    					}
    				}));
    			}
    		});
    	},
    	'select': function(item) {
    		$(this).val(item['label']);
    		$(this).parent().find('.product_val').val(item['value']).trigger('change');
    	}
    });
  }
}
function setManufacturerAutocompete($el) {
  if ($el.length > 0) {
    $el.autocomplete({
    'source': function(request, response) {
    		$.ajax({
    			url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
    			dataType: 'json',
    			success: function(json) {

    				response($.map(json, function(item) {
    					return {
    						label: item['name'],
    						value: item['manufacturer_id']
    					}
    				}));
    			}
    		});
    	},
    	'select': function(item) {
    		$(this).val(item['label']);
    		$(this).parent().find('.manufacturer_val').val(item['value']).trigger('change');
    	}
    });
  }
}

function setAttributeAutocompete($el) {
  if ($el.length > 0) {
    $el.autocomplete({
    'source': function(request, response) {
    		$.ajax({
    			url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
    			dataType: 'json',
    			success: function(json) {

    				response($.map(json, function(item) {
    					return {
    					  category: item.attribute_group,
    						label: item['name'],
    						value: item['attribute_id']
    					}
    				}));
    			}
    		});
    	},
    	'select': function(item) {
    		$(this).val(item['label']);
    		$(this).parent().find('.attribute_val').val(item['value']).trigger('change');
    	}
    });
  }
}
function setOptionAutocompete($el) {
  if ($el.length > 0) {
    $el.autocomplete({
    'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item['category'],
						label: item['name'],
						value: item['option_id'],
						type: item['type'],
						option_value: item['option_value']
					}
				}));
			}
		});
	},
    	'select': function(item) {
    		$(this).val(item['label']);
    		$(this).parent().find('.option_val').val(item['value']).trigger('change');
    	}
    });
  }
}

function setOptionValueAutocompete($el) {
  if ($el.length > 0) {
    $el.autocomplete({
    'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item['category'],
						label: item['name'],
						value: item['option_id'],
						type: item['type'],
						option_value: item['option_value']
					}
				}));
			}
		});
	},
    	'select': function(item) {
    		$(this).val(item['label']);
    		$(this).parent().find('.option_val').val(item['value']).trigger('change');
    		
    	}
    });
  }
}

$('#input-preset').on('change', function(){
  if (this.value == 'oneattr') {
    $('#input-attr').parent().parent().show();
  }
  else {
    $('#input-attr').parent().parent().hide();
    $('#input-attr').val('');
    $('#input-attr').parent().find('.attribute_val').val('');
  }
  if (this.value == 'oneopt') {
    $('#input-option').parent().parent().show();
  }
  else {
    $('#input-option').parent().parent().hide();
    $('#input-option').val('');
    $('#input-option').parent().find('.option_val').val('');
  }
  if (this.value == 'advanced') {
     $('a[href="#tab-cond-source"]').show();
     $('a[href="#tab-cond-dest"]').show();
  }
  else {
    $('a[href="#tab-cond-source"]').hide();
     $('a[href="#tab-cond-dest"]').hide();
  }
  <?php foreach ($preset_list as $preset_key => $preset_item) { ?>
	<?php if (isset($preset_item['source_json']) &&  $preset_item['source_json'] != '' && isset($preset_item['dest_json']) &&  $preset_item['dest_json'] != '') { ?>
	  if (this.value == '<?php echo $preset_key; ?>') {
        $('#cond-dest').queryBuilder('setRules', JSON.parse('<?php echo $preset_item['dest_json']; ?>'));
        $('#cond-source').queryBuilder('setRules', JSON.parse('<?php echo $preset_item['source_json']; ?>'));  
      }
	<?php } ?>
  <?php } ?>
});

$('#input-option').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/option/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						category: item['category'],
						label: item['name'],
						value: item['option_id'],
						type: item['type'],
						option_value: item['option_value']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$(this).val(item['label']);
		$(this).parent().find('.option_val').val(item['value']);
	}
});

$('#input-attr').autocomplete({
	'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							category: item.attribute_group,
							label: item.name,
							value: item.attribute_id
						}
					}));
				}
			});
		},
		'select': function(item) {
			$(this).val(item['label']);
    	$(this).parent().find('.attribute_val').val(item['value']);
    	$('#cond-dest').queryBuilder('setRules', JSON.parse('{"condition":"AND","rules":[{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"greater_then_source","value":"-10"},{"id":"pd.status","field":"pd.status","type":"string","input":"select","operator":"equal","value":"1"},{"id":"pd.product_id","field":"pd.product_id","type":"string","input":"text","operator":"not_equal_source","value":null},{"condition":"AND","rules":[{"condition":"AND","rules":[{"id":"pattrd.text","field":"pattrd.text","type":"string","input":"text","operator":"equal_source_attribute","value":["' + item['label'] + '","' + item['value'] + '"]},{"id":"pattrd.attribute_id","field":"pattrd.attribute_id","type":"string","input":"text","operator":"ac_equal","value":["' + item['label'] + '","' + item['value'] + '"]}]}]},{"id":"matching_attr","field":"matching_attr","type":"integer","input":"number","operator":"equal","value":1}],"valid":true}'));
		}
});

$('#input-preset').trigger('change');
$(document).on('submit','#form-module',function(){
    var group_dest = $('#cond-dest').queryBuilder('getModel');
    var have_filter_dest = false;
    var allright = true;
    group_dest.rules.forEach(function(element) {
      if (element.filter != null) {
        have_filter_dest = true;  
      }
    });
    if (have_filter_dest) {
      var result_dest = $('#cond-dest').queryBuilder('getSQL', $(this).data('stmt'));
      if (result_dest != null) {
        $('#dest-sql').val(result_dest.sql);
        var dest_json = $('#cond-dest').queryBuilder('getRules');
        if (dest_json != null) {
          $('#dest-json').val(JSON.stringify(dest_json));
        }
      }
      else {
        allright = false;
      }
    }
    else {
      $('#dest-sql').val('');
      $('#dest-json').val('');
    }
    
    
    var group_source = $('#cond-source').queryBuilder('getModel');
    var have_filter_source = false;
    group_source.rules.forEach(function(element) {
      if (element.filter != null) {
        have_filter_source = true;  
      }
    });
    if (have_filter_source) {
      var result_source = $('#cond-source').queryBuilder('getSQL', $(this).data('stmt'));
      if (result_source != null) {
        $('#source-sql').val(result_source.sql);
        var source_json = $('#cond-source').queryBuilder('getRules');
        if (source_json != null) {
          $('#source-json').val(JSON.stringify(source_json));
        }
      }
      else {
        allright = false;
      }
    }
    else {
      $('#source-sql').val('');
      $('#source-json').val('');
    }
    if (allright) {
      $('#cond-source input, #cond-source select').attr('name', ''); 
      $('#cond-dest input, #cond-dest select').attr('name', '');
    }
    else {
      return false;
    }
});
  </script>

<?php echo $footer; ?>
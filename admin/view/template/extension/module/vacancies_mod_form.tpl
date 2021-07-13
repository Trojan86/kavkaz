<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-vacancies" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-vacancies" class="form-horizontal">
          <ul class="nav nav-vacanciess">
            <li class="active"><a href="#vacancies-general" data-toggle="vacancies"><?php echo $vacancies_general; ?></a></li>
            <li><a href="#vacancies-data" data-toggle="vacancies"><?php echo $vacancies_data; ?></a></li>
          </ul>
          <div class="vacancies-content">
            <div class="vacancies-pane active" id="vacancies-general">
              <ul class="nav nav-vacanciess" id="language">
                <?php foreach ($languages as $language) { ?>
                <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="vacancies"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                <?php } ?>
              </ul>
              <div class="vacancies-content">
                <?php foreach ($languages as $language) { ?>
                <div class="vacancies-pane" id="language<?php echo $language['language_id']; ?>">
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="vacancies_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($vacancies_description[$language['language_id']]) ? $vacancies_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                      <?php if (isset($error_name[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
                <?php } ?>
              </div>
            </div>
            <div class="vacancies-pane" id="vacancies-data">
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <div class="checkbox">
                      <label>
                        <?php if (in_array(0, $vacancies_store)) { ?>
                        <input type="checkbox" name="vacancies_store[]" value="0" checked="checked" />
                        <?php echo $text_default; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="vacancies_store[]" value="0" />
                        <?php echo $text_default; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php foreach ($stores as $store) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($store['store_id'], $vacancies_store)) { ?>
                        <input type="checkbox" name="vacancies_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                        <?php echo $store['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="vacancies_store[]" value="<?php echo $store['store_id']; ?>" />
                        <?php echo $store['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
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
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-products"><?php echo $entry_products; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="products_input" value="" placeholder="<?php echo $entry_products; ?>" id="input-products" class="form-control" />
                  <div id="products" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($products as $products) { ?>
                    <div id="products<?php echo $products['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $products['name']; ?>
                      <input type="hidden" name="products[]" value="<?php echo $products['product_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <!-- <div class="form-group">
                <label class="col-sm-2 control-label" for="input-category"><?php echo $entry_category; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="category" value="" placeholder="<?php echo $entry_category; ?>" id="input-category" class="form-control" />
                  <div id="vacancies-in-category" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($vacancies_to_categories as $vacancies_to_category) { ?>
                    <div id="vacancies-in-category<?php echo $vacancies_to_category['category_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $vacancies_to_category['name']; ?>
                      <input type="hidden" name="vacancies_to_category[]" value="<?php echo $vacancies_to_category['category_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div> -->
            </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
    $('#language a:first').vacancies('show');
    //--></script>
  <script type="text/javascript"><!--
    $('input[name=\'products_input\']').autocomplete({
      source: function(request, response) {
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
      select: function(item) {
        $('input[name=\'products\']').val('');

        $('#products' + item['value']).remove();

        $('#products').append('<div id="products' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="products[]" value="' + item['value'] + '" /></div>');
      }
    });

    $('#products').delegate('.fa-minus-circle', 'click', function() {
      $(this).parent().remove();
    });
    //--></script>
  <script type="text/javascript"><!--
    $('input[name=\'products_name\']').autocomplete({
      source: function(request, response) {
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
      select: function(item) {
        $('input[name=\'product_name\']').val('');

        $('#custom-product-vacancies-product' + item['value']).remove();

        $('#custom-product-vacancies-product').append('<div id="custom-product-vacancies-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');
      }
    });

    $('#custom-product-vacancies-product').delegate('.fa-minus-circle', 'click', function() {
      $(this).parent().remove();
    });

    // Category
    $('input[name=\'category\']').autocomplete({
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
        $('input[name=\'category\']').val('');

        $('#vacancies-in-category' + item['value']).remove();

        $('#vacancies-in-category').append('<div id="vacancies-in-category' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="vacancies_to_category[]" value="' + item['value'] + '" /></div>');
      }
    });

    $('#vacancies-in-category').delegate('.fa-minus-circle', 'click', function() {
      $(this).parent().remove();
    });

    //--></script>
</div>
<?php echo $footer; ?>
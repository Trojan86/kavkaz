<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-review').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
      <h1><i class="fa fa-comments"></i> <?php echo $heading_title; ?><div style="position: absolute;margin-top:3px;margin-left:140px;font-size:12px;"><a href="http://vanstudio.co.ua" target="_blank">by vanstudio</a></h1>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-author"><?php echo $entry_author; ?></label>
                <input type="text" name="filter_author" value="<?php echo $filter_author; ?>" placeholder="<?php echo $entry_author; ?>" id="input-author" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $entry_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                <select name="filter_status" id="input-status" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_status && !is_null($filter_status)) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-rating"><?php echo $entry_rating; ?></label>
                <select name="filter_rating" id="input-rating" class="form-control">
                  <option value="*"></option>
                  <option value="0" <?php if ($filter_rating=='0') { ?>selected="selected"<?php } ?>>0</option>
                  <option value="1" <?php if ($filter_rating==1) { ?>selected="selected"<?php } ?>>1</option>
                  <option value="2" <?php if ($filter_rating==2) { ?>selected="selected"<?php } ?>>2</option>
                  <option value="3" <?php if ($filter_rating==3) { ?>selected="selected"<?php } ?>>3</option>
                  <option value="4" <?php if ($filter_rating==4) { ?>selected="selected"<?php } ?>>4</option>
                  <option value="5" <?php if ($filter_rating==5) { ?>selected="selected"<?php } ?>>5</option>
                </select>
              </div>
              <div class="pull-left">
              <?php if (isset($href_import)) { ?>
              <button onclick="confirm('<?php echo $text_confirm_remove; ?>') ? window.location.href = '<?php echo $href_import; ?>'+'&delete=1' : window.location.href = '<?php echo $href_import; ?>'" class="btn btn-success"><i class="fa fa-download"></i> <?php echo $text_import; ?></button>
              <?php } ?>
              <?php if (isset($href_import_sr)) { ?>
              <button onclick="confirm('<?php echo $text_confirm_remove_sr; ?>') ? window.location.href = '<?php echo $href_import_sr; ?>'+'&delete=1' : window.location.href = '<?php echo $href_import_sr; ?>'" class="btn btn-success"><i class="fa fa-download"></i> <?php echo $text_import_sr; ?></button>
              <?php } ?>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-language"><?php echo $entry_language; ?></label>
                <select name="filter_language" id="input-language" class="form-control">
                  <option value="*"></option>
                  <?php foreach($languages as $language){ ?>
                  <option value="<?php echo $language['language_id']; ?>" <?php if ($language['language_id']==$filter_language) { ?>selected="selected"<?php } ?>><?php echo $language['name']; ?></option>
                  <?php } ?>
                </select>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-store"><?php echo $entry_store; ?></label>
                <select name="filter_store" id="input-store" class="form-control">
                  <option value="*"></option>
                  <option value="0" <?php if ($filter_store=='0') { ?>selected="selected"<?php } ?>><?php echo $text_default; ?></option>
                  <?php foreach($stores as $store){ ?>
                  <option value="<?php echo $store['store_id']; ?>" <?php if ($store['store_id']==$filter_store) { ?>selected="selected"<?php } ?>><?php echo $store['name']; ?></option>
                  <?php } ?>
                </select>
              </div>
            <div class="pull-right">
              <button type="button" id="button-clear" class="btn btn-default"><i class="fa fa-eraser"></i> <?php echo $button_clear; ?></button>
              <button type="button" id="button-filter" class="btn btn-primary"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
            </div>
            </div>
          </div>
        </div>
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-review">
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td class="text-center"><?php echo $column_image; ?></td>
                  <td class="text-left"><?php if ($sort == 'r.author') { ?>
                    <a href="<?php echo $sort_author; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_author; ?>"><?php echo $column_author; ?></a>
                    <?php } ?></td>
                  <td class="text-left">
                    <?php echo $column_text; ?>
                  </td>
                  <td class="text-right"><?php if ($sort == 'r.rating') { ?>
                    <a href="<?php echo $sort_rating; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_rating; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_rating; ?>"><?php echo $column_rating; ?></a>
                    <?php } ?></td>
                  <td class="text-center"><?php if ($sort == 'r.status') { ?>
                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                    <?php } ?></td>
                  <td class="text-center"><?php if ($sort == 'r.date_added') { ?>
                    <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($testimonials) { ?>
                <?php foreach ($testimonials as $testimonial) { ?>
                <tr>
                  <td class="text-center"><?php if (in_array($testimonial['testimonial_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $testimonial['testimonial_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $testimonial['testimonial_id']; ?>" />
                    <?php } ?></td>
                  <td class="text-center"><?php if ($testimonial['image']) { ?>
                  <img src="<?php echo $testimonial['image']; ?>" alt="" class="img-thumbnail" />
                  <?php } else { ?>
                  <span class="img-thumbnail list"><i class="fa fa-camera fa-2x"></i></span>
                  <?php } ?></td>
                  <td class="text-left"><?php echo $testimonial['customer']; ?><?php echo $testimonial['author']; ?></td>
                  <td class="text-left"><?php echo $testimonial['text']; ?></td>
                  <td class="text-right">
                    <?php for($i=0; $i < $testimonial['rating']; $i++){ ?>
                    <i style="color:#FFD700;w" class="fa fa-star"></i>
                    <?php } ?>
                  </td>
                  <td class="text-center"><?php echo $testimonial['status']; ?></td>
                  <td class="text-center"><?php echo $testimonial['date_added']; ?></td>
                  <td class="text-right"><a href="<?php echo $testimonial['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = '<?php echo html_entity_decode($action); ?>';

    var filter_store = $('select[name=\'filter_store\']').val();

    if (filter_store != '*') {
      url += '&filter_store=' + encodeURIComponent(filter_store);
    }

    var filter_language = $('select[name=\'filter_language\']').val();

    if (filter_language != '*') {
      url += '&filter_language=' + encodeURIComponent(filter_language);
    }

    var filter_rating = $('select[name=\'filter_rating\']').val();

    if (filter_rating != '*') {
      url += '&filter_rating=' + encodeURIComponent(filter_rating);
    }

    var filter_author = $('input[name=\'filter_author\']').val();
	
	if (filter_author) {
		url += '&filter_author=' + encodeURIComponent(filter_author);
	}
	
	var filter_status = $('select[name=\'filter_status\']').val();
	
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status); 
	}		
			
	var filter_date_added = $('input[name=\'filter_date_added\']').val();
	
	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	location = url;
});

$('#button-clear').on('click', function() {
  location = '<?php echo html_entity_decode($action); ?>';
});
//--></script> 
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-carousel" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a onclick="$('#apply').attr('value', '1'); $('#form-testimonials').submit();" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-refresh"></i></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-testimonials" class="form-horizontal">
          <input type="hidden" name="apply" id="apply" value="0">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-developer" data-toggle="tab"><i class="fa fa-life-ring"></i> <?php echo $tab_developer; ?></a></li>
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
                <label class="col-sm-2 control-label" for="input-layout"><?php echo $entry_layout; ?></label>
                <div class="col-sm-10">
                  <select name="layout_id" id="input-layout" class="form-control">
                    <option value="0" <?php if($layout_id==0){ ?>selected="selected"<?php } ?>><?php echo $text_vertical; ?></option>
                    <option value="1" <?php if($layout_id==1){ ?>selected="selected"<?php } ?>><?php echo $text_horizontal; ?></option>
                    <option value="2" <?php if($layout_id==2){ ?>selected="selected"<?php } ?>><?php echo $text_slide; ?></option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-order"><?php echo $entry_order; ?></label>
                <div class="col-sm-10">
                  <select name="order" id="input-order" class="form-control">
                    <option value="0" <?php if($order==0){ ?>selected="selected"<?php } ?>><?php echo $text_last_all; ?></option>
                    <option value="1" <?php if($order==1){ ?>selected="selected"<?php } ?>><?php echo $text_rang_all; ?></option>
                    <option value="2" <?php if($order==2){ ?>selected="selected"<?php } ?>><?php echo $text_last; ?></option>
                    <option value="3" <?php if($order==3){ ?>selected="selected"<?php } ?>><?php echo $text_rang; ?></option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-review"><?php echo $entry_review; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="testimonial" value="" placeholder="<?php echo $entry_review; ?>" id="input-review" class="form-control" />
                  <div id="selected-review" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($testimonials as $testimonial) { ?>
                    <div id="selected-review<?php echo $testimonial['testimonial_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $testimonial['text']; ?>
                      <input type="hidden" name="testimonial[]" value="<?php echo $testimonial['testimonial_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-text-limit"><?php echo $entry_text_limit; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="text_limit" value="<?php echo $text_limit; ?>" placeholder="<?php echo $entry_text_limit; ?>" id="input-text-limit" class="form-control" />
                    </div>
                </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-text-align"><?php echo $entry_text_align; ?></label>
                <div class="col-sm-10">
                  <select name="text_align" id="input-text-align" class="form-control">
                    <option value="left" <?php if($text_align=='left'){ ?>selected="selected"<?php } ?>><?php echo $text_left; ?></option>
                    <option value="center" <?php if($text_align=='center'){ ?>selected="selected"<?php } ?>><?php echo $text_center; ?></option>
                    <option value="right" <?php if($text_align=='right'){ ?>selected="selected"<?php } ?>><?php echo $text_right; ?></option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                <div class="col-sm-10">
                  <select name="image" id="input-image" class="form-control">
                    <option value="0" <?php if ($image==0) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                    <option value="1" <?php if ($image==1) { ?>selected="selected"<?php } ?>><?php echo $text_top; ?></option>
                    <option value="2" <?php if ($image==2) { ?>selected="selected"<?php } ?>><?php echo $text_left; ?></option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-image-width">
                      <?php echo $entry_image_size; ?>
                </label>
                <div class="col-sm-10">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="image_width" value="<?php echo $image_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-width" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="image_height" value="<?php echo $image_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                    </div>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-all-button"><?php echo $entry_button_all; ?></label>
                <div class="col-sm-10">
                  <select name="button_all" id="input-all-button" class="form-control">
                    <option value="1" <?php if ($button_all==1) { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                    <option value="0" <?php if ($button_all==0) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-multilang"><?php echo $entry_multilang; ?></label>
                <div class="col-sm-10">
                  <select name="multilang" id="input-multilang" class="form-control">
                    <?php if ($multilang) { ?>
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
                <label class="col-sm-2 control-label" for="input-multistore"><?php echo $entry_multistore; ?></label>
                <div class="col-sm-10">
                  <select name="multistore" id="input-multistore" class="form-control">
                    <?php if ($multistore) { ?>
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
              <fieldset>
                <legend><?php echo $text_slideshow; ?></legend>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-slide-limit"><?php echo $entry_slide_limit; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="slide_limit" value="<?php echo $slide_limit; ?>" placeholder="<?php echo $entry_slide_limit; ?>" id="input-slide-limit" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-navigation"><?php echo $entry_navigation; ?></label>
                  <div class="col-sm-10">
                    <select name="navigation" id="input-navigation" class="form-control">
                      <option value="false" <?php if ($navigation=='false') { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                      <option value="true" <?php if ($navigation=='true') { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-pagination"><?php echo $entry_pagination; ?></label>
                  <div class="col-sm-10">
                    <select name="pagination" id="input-pagination" class="form-control">
                      <option value="false" <?php if ($pagination=='false') { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                      <option value="true" <?php if ($pagination=='true') { ?>selected="selected"<?php } ?>><?php echo $text_enabled; ?></option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-speed"><?php echo $entry_speed; ?></label>
                  <div class="col-sm-10">
                    <select name="slide_speed" id="input-speed" class="form-control">
                      <option value="6000" <?php if ($slide_speed=='6000') { ?>selected="selected"<?php } ?>><?php echo $text_very_slow; ?></option>
                      <option value="5000" <?php if ($slide_speed=='5000') { ?>selected="selected"<?php } ?>><?php echo $text_slower; ?></option>
                      <option value="4000" <?php if ($slide_speed=='4000') { ?>selected="selected"<?php } ?>><?php echo $text_slow; ?></option>
                      <option value="3000" <?php if ($slide_speed=='3000') { ?>selected="selected"<?php } ?>><?php echo $text_medium; ?></option>
                      <option value="2000" <?php if ($slide_speed=='2000') { ?>selected="selected"<?php } ?>><?php echo $text_fast; ?></option>
                      <option value="1500" <?php if ($slide_speed=='1500') { ?>selected="selected"<?php } ?>><?php echo $text_faster; ?></option>
                      <option value="1000" <?php if ($slide_speed=='1000') { ?>selected="selected"<?php } ?>><?php echo $text_very_fast; ?></option>
                    </select>
                  </div>
                </div>
              </fieldset>
              <div class="tab-pane">
                <ul class="nav nav-tabs" id="language">
                  <?php foreach ($languages as $language) { ?>
                  <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="<?php echo file_exists('language/'.$language['code'].'/'.$language['code'].'.png')?'language/'.$language['code'].'/'.$language['code'].'.png':'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                  <?php } ?>
                </ul>
                <div class="tab-content">
                  <?php foreach ($languages as $language) { ?>
                  <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $entry_title; ?></label>
                      <div class="col-sm-10">
                        <input type="text" name="module_description[<?php echo $language['language_id']; ?>][title]" placeholder="<?php echo $entry_title; ?>" id="input-heading<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['title']) ? $module_description[$language['language_id']]['title'] : ''; ?>" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="input-all-text<?php echo $language['language_id']; ?>"><?php echo $entry_all_text; ?></label>
                      <div class="col-sm-10">
                        <input type="text" name="module_description[<?php echo $language['language_id']; ?>][all_text]" placeholder="<?php echo $entry_all_text; ?>" id="input-all-text<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['all_text']) ? $module_description[$language['language_id']]['all_text'] : ''; ?>" class="form-control" />
                      </div>
                    </div>
                  </div>
                  <?php } ?>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="tab-developer">
              <div class="container-fluid">
                <div class="alert alert-info">
                  <div id="mod-notification"><i class="fa fa-spinner"> </i> <?php echo $text_load_message; ?></div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
    $('#language a:first').tab('show');
    //--></script>
  <script type="text/javascript"><!--
    $('input[name=\'testimonial\']').autocomplete({
      source: function(request, response) {
        $.ajax({
          url: '<?php echo html_entity_decode($autocomplete); ?>&filter_text=' +  encodeURIComponent(request),
          dataType: 'json',
          success: function(json) {
            response($.map(json, function(item) {
              return {
                label: item['text'],
                value: item['testimonial_id']
              }
            }));
          }
        });
      },
      select: function(item) {
        $('input[name=\'testimonial\']').val('');

        $('#selected-review' + item['value']).remove();

        $('#selected-review').append('<div id="selected-review' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="testimonial[]" value="' + item['value'] + '" /></div>');
      }
    });

    $('#selected-review').delegate('.fa-minus-circle', 'click', function() {
      $(this).parent().remove();
    });
    //--></script>
  <script type="text/javascript"><!--
    function getNotifications() {
      $('#mod-notification').empty().html('<div id="mod-notification"><i class="fa fa-spinner"> <?php echo $text_load_message; ?></div>');
      setTimeout(
              function(){
                $.ajax({
                  type: 'GET',
                  url: '<?php echo html_entity_decode($notification); ?>',
                  dataType: 'json',
                  success: function(json) {
                    if (json['error']) {
                      $('#mod-notification').empty().html(json['error']+' <span style="cursor:pointer;float:right;" onclick="getNotifications();"><i class="fa fa-refresh"></i> <?php echo $text_retry; ?></span>');
                    } else if (json['message']) {
                      $('#mod-notification').html(json['message']);
                    }
                  },
                  failure: function(){
                    $('#mod-notification').html('<?php echo $error_notification; ?> <span style="cursor:pointer;float:right;" onclick="getNotifications();"><i class="fa fa-refresh"></i> <?php echo $text_retry; ?></span>');
                  },
                  error: function() {
                    $('#mod-notification').html('<?php echo $error_notification; ?> <span style="cursor:pointer;float:right;" onclick="getNotifications();"><i class="fa fa-refresh"></i> <?php echo $text_retry; ?></span>');
                  }
                });
              },
              500
      );
    }

    $(document).ready(function() {
      getNotifications();
    });
    //--></script>
</div>
<?php echo $footer; ?>
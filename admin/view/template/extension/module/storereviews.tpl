<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="reviews" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="reviews" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo (isset($name) ? $name : '') ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-header"><?php echo $entry_title; ?></label>
            <div class="col-sm-10">
              <?php foreach ($languages as $language) { ?>
                <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                  <input type="text" name="storereviews[module_header][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($storereviews['module_header'][$language['language_id']]) ? $storereviews['module_header'][$language['language_id']] : ''); ?>" placeholder="<?php echo $entry_title; ?>" id="input-header" class="form-control" />
                </div>
                <?php if (isset($error_header[$language['language_id']]) && $error_header[$language['language_id']]) { ?>
                  <div class="text-danger"><?php echo $error_header[$language['language_id']]; ?></div>
                <?php } ?>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
            <div class="col-sm-10">
              <input type="text" name="storereviews[limit]" value="<?php echo (isset($storereviews['limit']) ? $storereviews['limit'] : '') ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
            </div>
          </div>
    <div class="form-group">
     <label class="col-sm-2 control-label"><?php echo $text_only_photo; ?></label>
     <div class="col-sm-10">
       <div class="onoffswitch">
         <input value="1" type="checkbox" name="storereviews[only_photo]" class="onoffswitch-checkbox" id="config-only-photo" <?php echo(isset($storereviews['only_photo']) ? 'checked' : '') ?>>
         <label class="onoffswitch-label" for="config-only-photo">
           <span class="onoffswitch-inner"></span>
           <span class="onoffswitch-switch"></span>
         </label>
       </div>
     </div>
   </div>
   <div class="form-group">
    <label class="col-sm-2 control-label"><?php echo $text_only_video; ?></label>
    <div class="col-sm-10">
      <div class="onoffswitch">
        <input value="1" type="checkbox" name="storereviews[only_video]" class="onoffswitch-checkbox" id="config-only-video" <?php echo(isset($storereviews['only_video']) ? 'checked' : '') ?>>
        <label class="onoffswitch-label" for="config-only-video">
          <span class="onoffswitch-inner"></span>
          <span class="onoffswitch-switch"></span>
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
   <label class="col-sm-2 control-label"><?php echo $text_auto; ?></label>
   <div class="col-sm-10">
     <div class="onoffswitch">
       <input value="1" type="checkbox" name="storereviews[autoplay]" class="onoffswitch-checkbox" id="config-autoplay" <?php echo(isset($storereviews['autoplay']) ? 'checked' : '') ?>>
       <label class="onoffswitch-label" for="config-autoplay">
         <span class="onoffswitch-inner"></span>
         <span class="onoffswitch-switch"></span>
       </label>
     </div>
   </div>
 </div>
 <div class="form-group">
   <label class="col-sm-2 control-label" for="input-speed"><?php echo $autoplay_speed; ?></label>
   <div class="col-sm-10">
     <input type="text" name="storereviews[autoplay_speed]" value="<?php echo (isset($storereviews['autoplay_speed']) ? $storereviews['autoplay_speed'] : '2000') ?>" placeholder="<?php echo $entry_autoplay_speed; ?>" id="input-speed" class="form-control" />
   </div>
 </div>
  <div class="form-group">
    <label class="col-sm-2 control-label" for="sort-order"><?= $text_default_sorting; ?></label>
    <div class="col-sm-10">
        <select id="sort-order" class="form-control" name="storereviews[sort_order]">
          <?php foreach ($sorts as $key => $value) { ?>
          <?php if ($value == (!empty($storereviews['sort_order'])? $storereviews['sort_order']:'date_added')) { ?>
          <option value="<?php echo $value; ?>" selected="selected"><?php echo $key; ?></option>
          <?php } else { ?>
          <option value="<?php echo $value; ?>"><?php echo $key; ?></option>
          <?php } ?>
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
        </form>
      </div>
    </div>
  </div>
</div>
	<style>
	.onoffswitch {
        position: relative;
		width: 75px;
		background-color: white;
		background-image: linear-gradient(to bottom, #eeeeee, white 25px);
		border-radius: 18px;
		box-shadow: 0 -1px white inset, 0 1px 1px rgba(0, 0, 0, 0.05) inset;
		padding: 3px;
        -webkit-user-select:none;
		-moz-user-select:none;
		-ms-user-select: none;
    }
    .onoffswitch-checkbox {
        display: none;
    }
    .onoffswitch-label {
        display: block;
		overflow: hidden;
		cursor: pointer;
		border-radius: 15px;
		margin-bottom:1px;
    }
    .onoffswitch-inner {
        display: block;
		width: 200%;
		margin-left: -100%;
        transition: background 0.2s ease-in 0s;
    }
    .onoffswitch-inner:before, .onoffswitch-inner:after {
        display: block;
		float: left;
		width: 50%;
		height: 29px;
		padding: 0;
		line-height: 29px;
        font-size: 14px;
		color: white;
		font-family: Trebuchet, Arial, sans-serif; font-weight: bold;
        box-sizing: border-box;
    }
    .onoffswitch-inner:before {
        content: "<?php echo $text_yes?>";
        padding-left: 13px;
		color: #ffffff;
		background: linear-gradient(45deg, #13bc4f, #02ce4d);
		box-shadow: 0 1px 2px rgba(0, 0, 0, 0.15) inset, 0 0 3px rgba(0, 0, 0, 0.2) inset;
		text-shadow: 0 1px rgba(0, 0, 0, 0.2);
		border-radius: 18px;
		font-size:13px;
    }
    .onoffswitch-inner:after {
        content: "<?php echo $text_no?>";
        padding-right: 9px;
		box-shadow: 0 1px 2px rgba(0, 0, 0, 0.15) inset, 0 0 3px rgba(0, 0, 0, 0.2) inset;
		text-shadow: 0 1px rgba(255, 255, 255, 0.5);
		color: #aaa;
		background:#eceeef none repeat scroll 0 0;
        text-align: right;
		border-radius: 18px;
		font-size:13px;
    }
    .onoffswitch-switch {
        display: block;
		width: 25px;
		height:25px;
        box-shadow:-1px 1px 5px rgba(0, 0, 0, 0.2), 0 1px rgba(0, 0, 0, 0.02) inset;
        background: #f9f9f9 linear-gradient(to bottom, #eeeeee, white) repeat scroll 0 0;
        position: absolute;
		top: 5px;
		bottom: 4px;
        right: 45px;
        border: 4px solid #FFFFFF;
		border-radius: 15px;
        transition: all 0.2s ease-in 0s;
    }
    .onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-inner {
        margin-left: 0;
    }
    .onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-switch {
        right: 5px;
		box-shadow:-1px 1px 5px rgba(0, 0, 0, 0.2), 0 1px rgba(0, 0, 0, 0.02) inset;
        background: #f9f9f9 linear-gradient(to bottom, #eeeeee, white) repeat scroll 0 0;

    }

</style>
<?php echo $footer; ?>

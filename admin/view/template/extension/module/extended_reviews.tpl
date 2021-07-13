<?php echo  $header . $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button id="save-settings" type="submit" form="extended_reviews_settings" data-toggle="tooltip" title="<?php echo  $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo  $cancel; ?>" data-toggle="tooltip" title="<?php echo  $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo  $heading_title; ?></h1>
      <ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
          <li><a href="<?php echo  $breadcrumb['href']; ?>"><?php echo  $breadcrumb['text']; ?></a></li>
      <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo  $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } elseif ($success){ ?>
    <div class="alert alert-success"><i class="fa fa-check"></i> <?php echo  $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } ?>

<?php if (isset($extended_reviews['key']) && !empty($extended_reviews['key']) && $license){ ?>
    <div class="panel panel-default">
      <form action="<?php echo  $action; ?>" method="post" enctype="multipart/form-data" id="extended_reviews_settings" class="form-horizontal">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#main-settings" data-toggle="tab" aria-expanded="false"><?php echo $text_main_settings;?></a></li>
            <li class=""><a href="#media-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_media_settings;?></a></li>
            <li class=""><a href="#carousel-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_owl_settings; ?></a></li>
            <li class=""><a href="#reward-settings" data-toggle="tab" aria-expanded="true"><?php echo $rewards_title;?></a></li>
            <li class=""><a href="#api-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_api; ?></a></li>
            <li class=""><a href="#tab-support" data-toggle="tab" aria-expanded="true"><?php echo $text_support; ?></a></li>
          </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="main-settings">
            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo  $entry_status; ?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="status_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[status]" value="0" <?php echo  !empty($extended_reviews['status']) && $extended_reviews['status'] ? '' : 'checked'; ?>>
                  <label for="status_off"><?php echo $text_on;?></label>
                      <input id="status_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[status]" value="1" <?php echo  !empty($extended_reviews['status']) && $extended_reviews['status'] ? 'checked' : ''; ?>>
                      <label for="status_on"><?php echo $text_off;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"><?php echo $text_link_allreviews; ?></label>
              <div class="col-sm-6">
                  <div class="row" style="padding: 10px">
                      <a href = "<?php echo $reviews_link; ?>" target="_blank"><?php echo $reviews_link; ?></a>
                  </div>
                </div>
            </div>


            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-header"><?php echo $entry_title; ?></label>
              <div class="col-sm-3">
                <?php foreach ($languages as $language) { ?>
                  <div class="input-group"><span class="input-group-addon"><?php echo $language['name']; ?></span>
                    <input type="text" name="extended_reviews_settings[module_header][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($extended_reviews['module_header'][$language['language_id']]) ? $extended_reviews['module_header'][$language['language_id']] : ''); ?>" placeholder="<?php echo $entry_title; ?>" id="input-header" class="form-control" />
                  </div>
                  <?php if (isset($error_header[$language['language_id']]) && $error_header[$language['language_id']]) { ?>
                    <div class="text-danger"><?php echo $error_header[$language['language_id']]; ?></div>
                  <?php } ?>
                <?php } ?>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo  $entry_automoderate; ?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="automoderate_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[automoderate]" value="0" <?php echo  !empty($extended_reviews['automoderate']) && $extended_reviews['automoderate'] ? '' : 'checked'; ?>>
                  <label for="automoderate_off"><?php echo $text_yes;?></label>
                      <input id="automoderate_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[automoderate]" value="1" <?php echo  !empty($extended_reviews['automoderate']) && $extended_reviews['automoderate'] ? 'checked' : ''; ?>>
                      <label for="automoderate_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="sort_order"><?php echo  $text_default_sorting; ?></label>
              <div class="col-sm-3">
                  <select id="sort_order" class="form-control" name="extended_reviews_settings[sort_order]">
                    <?php foreach ($sorts as $key => $value) { ?>
                    <?php if ($value == (!empty($extended_reviews['sort_order'])? $extended_reviews['sort_order']:'date_added')) { ?>
                    <option value="<?php echo $value; ?>" selected="selected"><?php echo $key; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $value; ?>"><?php echo $key; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="admin-name"><?php echo $entry_admin_name; ?></label>
              <div class="col-sm-6">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="extended_reviews_settings[admin_name]" value="<?php echo  !empty($extended_reviews['admin_name']) ? $extended_reviews['admin_name'] : 'Admin' ;?>" placeholder="<?php echo $entry_admin_name; ?>" id="admin-name" class="form-control">
                    </div>
                  </div>
                </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="max-limit"><?php echo $text_num_reviews; ?></label>
              <div class="col-sm-6">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="extended_reviews_settings[limit]" value="<?php echo  !empty($extended_reviews['limit']) ? $extended_reviews['limit'] : 10 ;?>" placeholder="<?php echo $text_num_reviews; ?>" id="max-limit" class="form-control">
                    </div>
                  </div>
                </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_micro; ?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="micro_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[micro]" value="0" <?php echo  !empty($extended_reviews['micro']) && $extended_reviews['micro'] ? '' : 'checked'; ?>>
                  <label for="micro_off"><?php echo $text_yes;?></label>
                      <input id="micro_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[micro]" value="1" <?php echo  (!empty($extended_reviews['micro']) && $extended_reviews['micro']) || !isset($extended_reviews['micro']) ? 'checked' : ''; ?>>
                      <label for="micro_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_limitations;?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="limitations_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[limitations]" value="0" <?php echo  !empty($extended_reviews['limitations']) && $extended_reviews['limitations'] ? '' : 'checked'; ?>>
                  <label for="limitations_off"><?php echo $text_yes;?></label>
                      <input id="limitations_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[limitations]" value="1" <?php echo  !empty($extended_reviews['limitations']) && $extended_reviews['limitations'] ? 'checked' : ''; ?>>
                      <label for="limitations_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_answer;?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="answer_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[answer]" value="0" <?php echo  !empty($extended_reviews['answer']) && $extended_reviews['answer'] ? '' : 'checked'; ?>>
                  <label for="answer_off"><?php echo $text_yes;?></label>
                      <input id="answer_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[answer]" value="1" <?php echo  !empty($extended_reviews['answer']) && $extended_reviews['answer'] ? 'checked' : ''; ?>>
                      <label for="answer_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_captcha;?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="captcha_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[captcha]" value="0" <?php echo  !empty($extended_reviews['captcha']) && $extended_reviews['captcha'] ? '' : 'checked'; ?>>
                  <label for="captcha_off"><?php echo $text_yes;?></label>
                      <input id="captcha_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[captcha]" value="1" <?php echo  !empty($extended_reviews['captcha']) && $extended_reviews['captcha'] ? 'checked' : ''; ?>>
                      <label for="captcha_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_mail_alert;?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="mail_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[mail_alert]" value="0" <?php echo !empty($extended_reviews['mail_alert']) && $extended_reviews['mail_alert'] ? '' : 'checked'; ?>>
                  <label for="mail_off"><?php echo $text_yes;?></label>
                      <input id="mail_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[mail_alert]" value="1" <?php echo !empty($extended_reviews['mail_alert']) && $extended_reviews['mail_alert'] ? 'checked' : ''; ?>>
                      <label for="mail_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo  $text_register; ?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="review_access_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[review_access]" value="0" <?php echo  !empty($extended_reviews['review_access']) && $extended_reviews['review_access'] ? '' : 'checked'; ?>>
                  <label for="review_access_off"><?php echo $text_yes;?></label>
                      <input id="review_access_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[review_access]" value="1" <?php echo  !empty($extended_reviews['review_access']) && $extended_reviews['review_access'] ? 'checked' : ''; ?>>
                      <label for="review_access_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_likes;?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="likes_access_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[likes_access]" value="0" <?php echo  !empty($extended_reviews['likes_access']) && $extended_reviews['likes_access'] ? '' : 'checked'; ?>>
                  <label for="likes_access_off"><?php echo $text_yes;?></label>
                      <input id="likes_access_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[likes_access]" value="1" <?php echo  !empty($extended_reviews['likes_access']) && $extended_reviews['likes_access'] ? 'checked' : ''; ?>>
                      <label for="likes_access_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="input-container"><?php echo $text_answer_register;?></label>
              <div class="col-sm-6">
                <div class="radio-group-lite">
                  <input id="answer_access_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[answer_access]" value="0" <?php echo  !empty($extended_reviews['answer_access']) && $extended_reviews['answer_access'] ? '' : 'checked'; ?>>
                  <label for="answer_access_off"><?php echo $text_yes;?></label>
                      <input id="answer_access_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[answer_access]" value="1" <?php echo  !empty($extended_reviews['answer_access']) && $extended_reviews['answer_access'] ? 'checked' : ''; ?>>
                      <label for="answer_access_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
                </div>
              </div>
            </div>
        </div>
        <div class="tab-pane" id="media-settings">
          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container"><?php echo $text_add_photo;?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="photo_status_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[photo_status]" value="0" <?php echo  !empty($extended_reviews['photo_status']) && $extended_reviews['photo_status'] ? '' : 'checked'; ?>>
                <label for="photo_status_off"><?php echo $text_yes;?></label>
                    <input id="photo_status_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[photo_status]" value="1" <?php echo  !empty($extended_reviews['photo_status']) && $extended_reviews['photo_status'] ? 'checked' : ''; ?>>
                    <label for="photo_status_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_imgbb_help; ?>"><?php echo $text_imgbb_on;?></span></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="photo_hosting_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[photo_hosting]" value="0" <?php echo  !empty($extended_reviews['photo_hosting']) && $extended_reviews['photo_hosting'] ? '' : 'checked'; ?>>
                <label for="photo_hosting_off"><?php echo $text_yes;?></label>
                    <input id="photo_hosting_on" class="hide-radio radio-on" type="radio" onclick="changeImageSizes();" name="extended_reviews_settings[photo_hosting]" value="1" <?php echo  !empty($extended_reviews['photo_hosting']) && $extended_reviews['photo_hosting'] ? 'checked' : ''; ?>>
                    <label for="photo_hosting_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="image-max-count">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_key_help; ?>"><?php echo $text_imgbb_key; ?></span></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[api_key]" value="<?php echo  !empty($extended_reviews['api_key']) ? $extended_reviews['api_key'] : '' ;?>" placeholder="Ваш ключ для загрузки изображений на хостинг imgbb.com" id="api_key" class="form-control">
                  </div>
                </div>
              </div>
              <div class="col-sm-12" style = "text-align: center">
                Ключ можно получить по адресу: api.imgbb.com
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_youtube_help; ?>"><?php echo $text_add_video;?></span></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="video_status_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[video_status]" value="0" <?php echo  !empty($extended_reviews['video_status']) && $extended_reviews['video_status'] ? '' : 'checked'; ?>>
                <label for="video_status_off"><?php echo $text_yes;?></label>
                    <input id="video_status_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[video_status]" value="1" <?php echo  !empty($extended_reviews['video_status']) && $extended_reviews['video_status'] ? 'checked' : ''; ?>>
                    <label for="video_status_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container"><?php echo $text_all_media;?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="all_media_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[all_media]" value="0" <?php echo  !empty($extended_reviews['all_media']) && $extended_reviews['all_media'] ? '' : 'checked'; ?>>
                <label for="all_media_off"><?php echo $text_yes;?></label>
                    <input id="all_media_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[all_media]" value="1" <?php echo  !empty($extended_reviews['all_media']) && $extended_reviews['all_media'] ? 'checked' : ''; ?>>
                    <label for="all_media_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_delete_help; ?>"><?php echo $text_delete_images;?></span></label>
            <div class="col-sm-6" id="delete-images-container">
            <button type="button" id="button-unused-images-delete"  class="btn btn-danger"><?php echo $text_delete?></button>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="image-width"><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_size_control; ?>"><?php echo $text_popup_size;?></span></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_width]" value="<?php echo  !empty($extended_reviews['image_width']) ? $extended_reviews['image_width'] : 0 ;?>" placeholder="Ширина" id="image-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_height]" value="<?php echo  !empty($extended_reviews['image_height']) ? $extended_reviews['image_height'] : 0 ;?>" placeholder="Высота" id="image-height" class="form-control">
                  </div>
                </div>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="image-max-width"><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_max_size; ?>"><?php echo $text_size_limit;?></span></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_width]" value="<?php echo  !empty($extended_reviews['image_max_width']) ? $extended_reviews['image_max_width'] : 5000 ;?>" placeholder="Ширина" id="image-max-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_height]" value="<?php echo  !empty($extended_reviews['image_max_height']) ? $extended_reviews['image_max_height'] : 5000 ;?>" placeholder="Высота" class="form-control">
                  </div>
                </div>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="image-max-width">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_max_weight; ?>"><?php echo $text_weight_limit;?></span></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_size]" value="<?php echo  !empty($extended_reviews['image_max_size']) ? $extended_reviews['image_max_size'] : 5 ;?>" placeholder="<?php echo $text_weight_limit;?>" id="image-max-size" class="form-control">
                  </div>
                </div>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="image-max-count"><?php echo $text_count_limit;?></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_count]" value="<?php echo  !empty($extended_reviews['image_max_count']) ? $extended_reviews['image_max_count'] : 10 ;?>" placeholder="<?php echo $text_count_limit;?>" id="image-max-count" class="form-control">
                  </div>
                </div>
              </div>
          </div>
        </div>

        <div class="tab-pane" id="carousel-settings">
          <ul class="nav nav-tabs">
          <li class="active"><a href="#product-carousel" data-toggle="tab" aria-expanded="true"><?php echo $text_owl_prod; ?></a></li>
          <li class=""><a href="#reviews-carousel" data-toggle="tab" aria-expanded="true"><?php echo $text_owl_rev; ?></a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="product-carousel">
          <h2 class="text-center"><?php echo $text_owl_product; ?></h2>
          <br>
          <h3><?php echo $text_owl_photo; ?></h3>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container"><?php echo  $entry_status; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="owl_photo_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[owl_photo_status]" value="0" <?php echo  !empty($extended_reviews['owl_photo_status']) && !$extended_reviews['owl_photo_status'] ? 'checked' : ''; ?>>
                <label for="owl_photo_off"><?php echo $text_on;?></label>
                    <input id="owl_photo_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[owl_photo_status]" value="1" <?php echo  !isset($extended_reviews['owl_photo_status']) || $extended_reviews['owl_photo_status'] ? 'checked' : ''; ?>>
                    <label for="owl_photo_on"><?php echo $text_off;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 col-lg-4 control-label" for="thumb-width"><?php echo $text_owl_size; ?></label>
            <div class="col-sm-6 col-lg-4">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[thumb_width]" value="<?php echo  !empty($extended_reviews['thumb_width']) ? $extended_reviews['thumb_width'] : 100 ;?>" placeholder="Ширина" id="thumb-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[thumb_height]" value="<?php echo  !empty($extended_reviews['thumb_height']) ? $extended_reviews['thumb_height'] : 100 ;?>" placeholder="Высота" class="form-control">
                  </div>
                </div>
              </div>
          </div>
          <div class="form-group">
            <label class="col-sm-6 col-lg-4 col-xs-8 control-label" for="border-radius-photo"><?php echo $text_owl_radius; ?></label>
            <div class="col-sm-2 col-lg-1 col-xs-4">
                <input type="text" name="extended_reviews_settings[border_radius_photo]" value="<?php echo  !empty($extended_reviews['border_radius_photo']) ? $extended_reviews['border_radius_photo'] : 2 ;?>" id="border-radius-photo" class="form-control">
              </div>
          </div>
          <br>
          <h4><?php echo $text_owl_count; ?></h4>
          <div class="row">
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-photo-1200"><?php echo $text_owl_screen; ?> 1200px+</label>
            <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[photo_carousel_1200]" value="<?php echo  !empty($extended_reviews['photo_carousel_1200']) ? $extended_reviews['photo_carousel_1200'] : 6 ;?>" id="carousel-photo-1200" class="form-control">
              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-photo-1199"><?php echo $text_owl_screen; ?> 769px - 1199px</label>
            <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[photo_carousel_1199]" value="<?php echo  !empty($extended_reviews['photo_carousel_1199']) ? $extended_reviews['photo_carousel_1199'] : 5 ;?>" id="carousel-photo-1199" class="form-control">
              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-photo-768"><?php echo $text_owl_screen; ?> 481px - 768px</label>
            <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[photo_carousel_768]" value="<?php echo  !empty($extended_reviews['photo_carousel_768']) ? $extended_reviews['photo_carousel_768'] : 4 ;?>" id="carousel-photo-768" class="form-control">
              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-photo-480"><?php echo $text_owl_screen; ?> 341px - 480px</label>
            <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[photo_carousel_480]" value="<?php echo  !empty($extended_reviews['photo_carousel_480']) ? $extended_reviews['photo_carousel_480'] : 3 ;?>" id="carousel-photo-480" class="form-control">
              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-photo-360"><?php echo $text_owl_screen; ?> 340px-</label>
                  <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[photo_carousel_340]" value="<?php echo  !empty($extended_reviews['photo_carousel_340']) ? $extended_reviews['photo_carousel_340'] : 2 ;?>" id="carousel-photo-360" class="form-control">
              </div>
          </div>
          </div>
          <hr>
          <br>
          <h3><?php echo $text_owl_video; ?></h3>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container"><?php echo  $entry_status; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="owl_video_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[owl_video_status]" value="0" <?php echo  !empty($extended_reviews['owl_video_status']) && !$extended_reviews['owl_video_status'] ? 'checked' : ''; ?>>
                <label for="owl_video_off"><?php echo $text_on;?></label>
                    <input id="owl_video_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[owl_video_status]" value="1" <?php echo  !isset($extended_reviews['owl_video_status']) || $extended_reviews['owl_video_status'] ? 'checked' : ''; ?>>
                    <label for="owl_video_on"><?php echo $text_off;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 col-lg-4 control-label" for="video-thumb-width"><?php echo $text_owl_size; ?></label>
            <div class="col-sm-6 col-lg-4">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[video_thumb_width]" value="<?php echo  !empty($extended_reviews['video_thumb_width']) ? $extended_reviews['video_thumb_width'] : 160 ;?>" placeholder="Ширина" id="video-thumb-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[video_thumb_height]" value="<?php echo  !empty($extended_reviews['video_thumb_height']) ? $extended_reviews['video_thumb_height'] : 100 ;?>" placeholder="Высота" class="form-control">
                  </div>
                </div>
              </div>
          </div>
          <div class="form-group">
            <label class="col-sm-6 col-lg-4 col-xs-8 control-label" for="border-radius-video"><?php echo $text_owl_radius; ?></label>
            <div class="col-sm-2 col-lg-1 col-xs-4">
                <input type="text" name="extended_reviews_settings[border_radius_video]" value="<?php echo  !empty($extended_reviews['border_radius_video']) ? $extended_reviews['border_radius_video'] : 2 ;?>" id="border-radius-video" class="form-control">
              </div>
          </div>
          <h4><?php echo $text_owl_count; ?></h4>
          <div class="row">
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-video-1200"><?php echo $text_owl_screen; ?> 1200px+</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[video_carousel_1200]" value="<?php echo  !empty($extended_reviews['video_carousel_1200']) ? $extended_reviews['video_carousel_1200'] : 4 ;?>" id="carousel-video-1200" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-video-1199"><?php echo $text_owl_screen; ?> 769px - 1199px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[video_carousel_1199]" value="<?php echo  !empty($extended_reviews['video_carousel_1199']) ? $extended_reviews['video_carousel_1199'] : 3 ;?>" id="carousel-video-1199" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-video-768"><?php echo $text_owl_screen; ?> 481px - 768px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[video_carousel_768]" value="<?php echo  !empty($extended_reviews['video_carousel_768']) ? $extended_reviews['video_carousel_768'] : 3 ;?>" id="carousel-video-768" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-video-480"><?php echo $text_owl_screen; ?> 341px - 480px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[video_carousel_480]" value="<?php echo  !empty($extended_reviews['video_carousel_480']) ? $extended_reviews['video_carousel_480'] : 2 ;?>" id="carousel-video-480" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="carousel-video-360"><?php echo $text_owl_screen; ?> 340px-</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[video_carousel_340]" value="<?php echo  !empty($extended_reviews['video_carousel_340']) ? $extended_reviews['video_carousel_340'] : 1 ;?>" id="carousel-video-360" class="form-control">

              </div>
          </div>
        </div>
          <br>
        </div>
        <div class="tab-pane" id="reviews-carousel">
          <h2 class="text-center"><?php echo $text_owl_reviews; ?></h2>
          <br>
          <h3><?php echo $text_owl_photo; ?></h3>
          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container"><?php echo  $entry_status; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="all_owl_photo_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[all_owl_photo_status]" value="0" <?php echo  !empty($extended_reviews['all_owl_photo_status']) && !$extended_reviews['all_owl_photo_status'] ? 'checked' : ''; ?>>
                <label for="all_owl_photo_off"><?php echo $text_on;?></label>
                    <input id="all_owl_photo_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[all_owl_photo_status]" value="1" <?php echo  !isset($extended_reviews['all_owl_photo_status']) || $extended_reviews['all_owl_photo_status'] ? 'checked' : ''; ?>>
                    <label for="all_owl_photo_on"><?php echo $text_off;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-6 col-lg-4 control-label" for="all-thumb-width"><?php echo $text_owl_size; ?></label>
            <div class="col-sm-6 col-lg-4 ">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[all_thumb_width]" value="<?php echo  !empty($extended_reviews['all_thumb_width']) ? $extended_reviews['all_thumb_width'] : 110 ;?>" placeholder="Ширина" id="all-thumb-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[all_thumb_height]" value="<?php echo  !empty($extended_reviews['all_thumb_height']) ? $extended_reviews['all_thumb_height'] : 110 ;?>" placeholder="Высота" class="form-control">
                  </div>
                </div>
              </div>
          </div>
          <div class="form-group">
            <label class="col-sm-6 col-lg-4 col-xs-8 control-label" for="all-border-radius-photo"><?php echo $text_owl_radius; ?></label>
            <div class="col-sm-2 col-lg-1 col-xs-4">
                <input type="text" name="extended_reviews_settings[all_border_radius_photo]" value="<?php echo  !empty($extended_reviews['all_border_radius_photo']) ? $extended_reviews['all_border_radius_photo'] : 2 ;?>" id="all-border-radius-photo" class="form-control">
              </div>
          </div>
          <br>
          <h4><?php echo $text_owl_count; ?></h4>
          <div class="row">
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-photo-1200"><?php echo $text_owl_screen; ?> 1200px+</label>
            <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[all_photo_carousel_1200]" value="<?php echo  !empty($extended_reviews['all_photo_carousel_1200']) ? $extended_reviews['all_photo_carousel_1200'] : 7 ;?>" id="all-carousel-photo-1200" class="form-control">
              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-photo-1199"><?php echo $text_owl_screen; ?> 769px - 1199px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_photo_carousel_1199]" value="<?php echo  !empty($extended_reviews['all_photo_carousel_1199']) ? $extended_reviews['all_photo_carousel_1199'] : 5 ;?>" id="all-carousel-photo-1199" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-photo-768"><?php echo $text_owl_screen; ?> 481px - 768px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_photo_carousel_768]" value="<?php echo  !empty($extended_reviews['all_photo_carousel_768']) ? $extended_reviews['all_photo_carousel_768'] : 4 ;?>" id="all-carousel-photo-768" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-photo-480"><?php echo $text_owl_screen; ?> 341px - 480px</label>
                  <div class="col-sm-4">
                    <input type="text" name="extended_reviews_settings[all_photo_carousel_480]" value="<?php echo  !empty($extended_reviews['all_photo_carousel_480']) ? $extended_reviews['all_photo_carousel_480'] : 3 ;?>" id="all-carousel-photo-480" class="form-control">
              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-photo-360"><?php echo $text_owl_screen; ?> 340px-</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_photo_carousel_340]" value="<?php echo  !empty($extended_reviews['all_photo_carousel_340']) ? $extended_reviews['all_photo_carousel_340'] : 2 ;?>" id="all-carousel-photo-360" class="form-control">

              </div>
          </div>
        </div>
          <hr>
          <br>
          <h3><?php echo $text_owl_video; ?></h3>
          <div class="form-group">
            <label class="col-sm-6 control-label" for="input-container"><?php echo  $entry_status; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="all_owl_video_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[all_owl_video_status]" value="0" <?php echo  !empty($extended_reviews['all_owl_video_status']) && !$extended_reviews['all_owl_video_status'] ? 'checked' : ''; ?>>
                <label for="all_owl_video_off"><?php echo $text_on;?></label>
                    <input id="all_owl_video_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[all_owl_video_status]" value="1" <?php echo  !isset($extended_reviews['all_owl_video_status']) || $extended_reviews['all_owl_video_status'] ? 'checked' : ''; ?>>
                    <label for="all_owl_video_on"><?php echo $text_off;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-6 col-lg-4 control-label" for="all-video-thumb-width"><?php echo $text_owl_size; ?></label>
            <div class="col-sm-6 col-lg-4">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[all_video_thumb_width]" value="<?php echo  !empty($extended_reviews['all_video_thumb_width']) ? $extended_reviews['all_video_thumb_width'] : 160 ;?>" placeholder="Ширина" id="all-video-thumb-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[all_video_thumb_height]" value="<?php echo  !empty($extended_reviews['all_video_thumb_height']) ? $extended_reviews['all_video_thumb_height'] : 100 ;?>" placeholder="Высота" class="form-control">
                  </div>
                </div>
              </div>
          </div>
          <div class="form-group">
            <label class="col-sm-6 col-lg-4 col-xs-8 control-label" for="all_border-radius-video"><?php echo $text_owl_radius; ?></label>
            <div class="col-sm-2 col-lg-1 col-xs-4">
                <input type="text" name="extended_reviews_settings[all_border_radius_video]" value="<?php echo  !empty($extended_reviews['all_border_radius_video']) ? $extended_reviews['all_border_radius_video'] : 2 ;?>" id="all-border-radius-video" class="form-control">
              </div>
          </div>
          <h4><?php echo $text_owl_count; ?></h4>
          <div class="row">
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-video-1200"><?php echo $text_owl_screen; ?> 1200px+</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_video_carousel_1200]" value="<?php echo  !empty($extended_reviews['all_video_carousel_1200']) ? $extended_reviews['all_video_carousel_1200'] : 5 ;?>" id="all-carousel-video-1200" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-video-1199"><?php echo $text_owl_screen; ?> 769px - 1199px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_video_carousel_1199]" value="<?php echo  !empty($extended_reviews['all_video_carousel_1199']) ? $extended_reviews['all_video_carousel_1199'] : 4 ;?>" id="all-carousel-video-1199" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-video-768"><?php echo $text_owl_screen; ?> 481px - 768px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_video_carousel_768]" value="<?php echo  !empty($extended_reviews['all_video_carousel_768']) ? $extended_reviews['all_video_carousel_768'] : 3 ;?>" id="all-carousel-video-768" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-video-480"><?php echo $text_owl_screen; ?> 341px - 480px</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_video_carousel_480]" value="<?php echo  !empty($extended_reviews['all_video_carousel_480']) ? $extended_reviews['all_video_carousel_480'] : 2 ;?>" id="all-carousel-video-480" class="form-control">

              </div>
          </div>
          <div class="form-group col-lg-4 col-md-6 col-xs-12">
            <label class="col-sm-8 control-label" for="all-carousel-video-360"><?php echo $text_owl_screen; ?> 340px-</label>
            <div class="col-sm-4">

                    <input type="text" name="extended_reviews_settings[all_video_carousel_340]" value="<?php echo  !empty($extended_reviews['all_video_carousel_340']) ? $extended_reviews['all_video_carousel_340'] : 1 ;?>" id="all-carousel-video-360" class="form-control">

              </div>
          </div>
          </div>
        </div>
      </div>
    </div>


        <div class="tab-pane" id="reward-settings">
          <div class="form-group">
            <label class="col-sm-6 control-label"><?php echo $rewards_status;?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                    <input id="reward_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[reward]" value="0" <?php echo  !empty($extended_reviews['reward']) && $extended_reviews['reward'] ? '' : 'checked'; ?>>
                    <label for="reward_off"><?php echo $text_yes;?></label>
                    <input id="reward_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[reward]" value="1" <?php echo  !empty($extended_reviews['reward']) && $extended_reviews['reward'] ? 'checked' : ''; ?>>
                    <label for="reward_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="bonus-count"><?php echo $text_bonus;?></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus]" value="<?php echo  !empty($extended_reviews['bonus']) ? $extended_reviews['bonus'] : 0 ;?>" placeholder="Введите количество бонусов получаемых за отзыв" id="bonus-count" class="form-control">
                  </div>
                </div>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="bonus-photo"><?php echo $text_bonus_photo;?></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus_photo]" value="<?php echo  !empty($extended_reviews['bonus_photo']) ? $extended_reviews['bonus_photo'] : 0 ;?>" placeholder="Введите количество бонусов получаемых за отзыв с фото" id="bonus-photo" class="form-control">
                  </div>
                </div>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="bonus-video"><?php echo $text_bonus_video;?></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus_video]" value="<?php echo  !empty($extended_reviews['bonus_video']) ? $extended_reviews['bonus_video'] : 0 ;?>" placeholder="Введите количество бонусов получаемых за отзыв с видео" id="bonus-video" class="form-control">
                  </div>
                </div>
              </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label">
              <span data-toggle="tooltip" title="" data-original-title="<?php echo $text_likes_help; ?>"><?php echo $text_bonus_likes_status;?></span></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="likes_reward_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[likes_reward]" value="0" <?php echo  !empty($extended_reviews['likes_reward']) && $extended_reviews['likes_reward'] ? '' : 'checked'; ?>>
                <label for="likes_reward_off"><?php echo $text_yes;?></label>
                <input id="likes_reward_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[likes_reward]" value="1" <?php echo  !empty($extended_reviews['likes_reward']) && $extended_reviews['likes_reward'] ? 'checked' : ''; ?>>
                <label for="likes_reward_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
            </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label" for="bonus-likes"><?php echo $text_bonus_likes;?></label>
            <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus_likes]" value="<?php echo  !empty($extended_reviews['bonus_likes']) ? $extended_reviews['bonus_likes'] : 0 ;?>" placeholder="Введите количество бонусов выдаваемых за полученный к отзыву лайк" id="bonus-likes" class="form-control">
                  </div>
                </div>
              </div>
          </div>
        </div>


        <div class="tab-pane" id="api-settings">
          <div class = "clarification-for-users"><?php echo $api_notifications; ?></div>

          <div class="form-group">
            <label class="col-sm-6 control-label"><?php echo $text_dropzone; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="dropzone_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[dropzone]" value="0" <?php echo  !empty($extended_reviews['dropzone']) && $extended_reviews['dropzone'] ? '' : 'checked'; ?>>
                <label for="dropzone_off"><?php echo $text_yes;?></label>
                <input id="dropzone_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[dropzone]" value="1" <?php echo  (!empty($extended_reviews['dropzone']) && $extended_reviews['dropzone']) || !isset($extended_reviews['dropzone'])  ? 'checked' : ''; ?>>
                <label for="dropzone_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
            </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label"><?php echo $text_carousel; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="carousel_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[carousel]" value="0" <?php echo  !empty($extended_reviews['carousel']) && $extended_reviews['carousel'] ? '' : 'checked'; ?>>
                <label for="carousel_off"><?php echo $text_yes;?></label>
                <input id="carousel_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[carousel]" value="1" <?php echo  (!empty($extended_reviews['carousel']) && $extended_reviews['carousel']) || !isset($extended_reviews['carousel']) ? 'checked' : ''; ?>>
                <label for="carousel_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
            </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label"><?php echo $text_magnific; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="magnific_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[magnific]" value="0" <?php echo  !empty($extended_reviews['magnific']) && $extended_reviews['magnific'] ? '' : 'checked'; ?>>
                <label for="magnific_off"><?php echo $text_yes;?></label>
                <input id="magnific_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[magnific]" value="1" <?php echo  !empty($extended_reviews['magnific']) && $extended_reviews['magnific'] ? 'checked' : ''; ?>>
                <label for="magnific_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
            </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label"><?php echo $text_bootstrap_css; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="bootstrap_css_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[bootstrap_css]" value="0" <?php echo  !empty($extended_reviews['bootstrap_css']) && $extended_reviews['bootstrap_css'] ? '' : 'checked'; ?>>
                <label for="bootstrap_css_off"><?php echo $text_yes;?></label>
                <input id="bootstrap_css_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[bootstrap_css]" value="1" <?php echo  !empty($extended_reviews['bootstrap_css']) && $extended_reviews['bootstrap_css'] ? 'checked' : ''; ?>>
                <label for="bootstrap_css_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
            </div>
            </div>
          </div>

          <div class="form-group">
            <label class="col-sm-6 control-label"><?php echo $text_bootstrap_js; ?></label>
            <div class="col-sm-6">
              <div class="radio-group-lite">
                <input id="bootstrap_js_off" class="hide-radio radio-off" type="radio" name="extended_reviews_settings[bootstrap_js]" value="0" <?php echo  !empty($extended_reviews['bootstrap_js']) && $extended_reviews['bootstrap_js'] ? '' : 'checked'; ?>>
                <label for="bootstrap_js_off"><?php echo $text_yes;?></label>
                <input id="bootstrap_js_on" class="hide-radio radio-on" type="radio" name="extended_reviews_settings[bootstrap_js]" value="1" <?php echo  !empty($extended_reviews['bootstrap_js']) && $extended_reviews['bootstrap_js'] ? 'checked' : ''; ?>>
                <label for="bootstrap_js_on"><?php echo $text_no;?><span class="onoffswitch-inner"></span><span class="onoffswitch-switch"></span></label>
            </div>
            </div>
          </div>

        </div>



        <div class="tab-pane" id="tab-support">
          <div class="form-group">
            <div class="col-sm-12">
              <?php echo $text_thanks; ?>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-3"><?php echo $text_contacts; ?></div>
            <div class="col-sm-9">
              <?php echo $text_email; ?> <a href="mailto:Felin0603@gmail.com">Felin0603@gmail.com</a><br>
              <?php echo $text_site; ?> <a href="http://extended-reviews.com/" target="_blank">http://extended-reviews.com/</a><br>
              Opencartforum: <a href="https://opencartforum.com/profile/827231-censorid/" target="_blank">https://opencartforum.com/profile/827231-censorid/</a>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-3"><?php echo $text_module_reviews; ?></div>
            <div class="col-sm-9">
              Opencartforum: <a href="https://opencartforum.com/files/file/7202-otzyvy-s-foto-i-video-laykami-i-kommentariyami/?tab=reviews" target="_blank">opencartforum.com</a><br>
            </div>
          </div>
        </div>






      </div>
      <input type="hidden" name="extended_reviews_settings[key]" value="<?php echo  !empty($extended_reviews['key']) ? $extended_reviews['key'] : 0 ;?>">
      <input type="hidden" name="extended_reviews_settings[license]" value="<?php echo  !empty($license) ? $license : 0 ;?>">
    </form>
    </div>
<?php } else { ?>
  <form action="<?php echo  $action; ?>" method="post" enctype="multipart/form-data" id="extended_reviews_key" class="form-horizontal">
  <?php if ($error_license){ ?>
    <div class="alert"><i class="fa fa-exclamation-circle"></i> <?php echo  $error_license; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } ?>
  <div class="col-md-offset-3 col-md-5 col-sm-12">
    <label for="input-text-plus"><?php echo $text_license_key?></label>
    <div class="input-group">
    <input type="text" name="extended_reviews_settings[key]" value="" placeholder="<?php echo $text_entry_key;?>" id="key" class="form-control">
    <span class="input-group-btn"> <button id="save-settings" type="submit" form="extended_reviews_key" data-toggle="tooltip" title="<?php echo  $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i><?php echo $text_license_key_save;?></button></span>
  </div>
  </div>
</form>
<?php } ?>
  </div>
</div>
<?php echo $footer; ?>
<script>
$('#button-unused-images-delete').on('click', function(){
  $.ajax({
    url: 'index.php?route=extension/module/extended_reviews/deleteUnusedImages&token=<?php echo $token; ?>',
    type: 'post',
    data: { review_id : null } ,
    success: function(json) {
        $('#delete-images-container .alert').remove();
        $('#delete-images-container').append('<div class="alert alert-success m-20"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; Delete ' + json['count'] + ' images</div>');
  }
  });
});
function changeImageSizes(){
  $('#image-width').val('1000');
  $('#image-height').val('1000');
}
</script>

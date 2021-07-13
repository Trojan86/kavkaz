<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" onclick="$('#apply').attr('value', '0'); " form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a onclick="$('#apply').attr('value', '1'); $('#form').submit();" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success"><i class="fa fa-refresh"></i></a>
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
        <form action="" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
            <input type="hidden" name="apply" id="apply" value="0">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-general" data-toggle="tab"><i class="fa fa-sliders tab-icon"></i> <?php echo $tab_general; ?></a></li>
                <li><a href="#tab-data" data-toggle="tab"><i class="fa fa-cogs tab-icon"></i> <?php echo $tab_data; ?></a></li>
                <li><a href="#tab-rating" data-toggle="tab"><i class="fa fa-star-o tab-icon"></i> <?php echo $tab_rating; ?></a></li>
                <li><a href="#tab-image" data-toggle="tab"><i class="fa fa-picture-o tab-icon"></i> <?php echo $tab_image; ?></a></li>
                <li><a href="#tab-design" data-toggle="tab"><i class="fa fa-file-image-o tab-icon"></i> <?php echo $tab_design; ?></a></li>
                <li><a href="#tab-developer" data-toggle="tab"><i class="fa fa-life-ring tab-icon"></i> <?php echo $tab_developer; ?></a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab-general">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-review-status"><span data-toggle="tooltip" title="<?php echo $help_review; ?>"><?php echo $entry_review; ?></span></label>
                        <div class="col-sm-10">
                            <select name="testimonial_tm_status" id="input-review-status" class="form-control">
                                <option value="0" <?php if (!isset($testimonial_tm_status) || $testimonial_tm_status==0) { ?>selected="selected"<?php } ?>><?php echo $text_all; ?></option>
                                <option value="1" <?php if (isset($testimonial_tm_status) && $testimonial_tm_status==1) { ?>selected="selected"<?php } ?>><?php echo $text_after_login; ?></option>
                                <option value="2" <?php if (isset($testimonial_tm_status) && $testimonial_tm_status==2) { ?>selected="selected"<?php } ?>><?php echo $text_after_purchase; ?></option>
                                <option value="3" <?php if (isset($testimonial_tm_status) && $testimonial_tm_status==3) { ?>selected="selected"<?php } ?>><?php echo $text_disable; ?></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-approve"><span data-toggle="tooltip" title="<?php echo $help_approve_rating; ?>"><?php echo $entry_approve; ?></span></label>
                        <div class="col-sm-10">
                            <select name="testimonial_approve" id="input-approve" class="form-control">
                                <option value="0" <?php if (!isset($testimonial_approve) || $testimonial_approve==0) { ?>selected="selected"<?php } ?>><?php echo $text_disabled; ?></option>
                                <option value="1" <?php if (isset($testimonial_approve) && $testimonial_approve==1) { ?>selected="selected"<?php } ?>>1</option>
                                <option value="2" <?php if (isset($testimonial_approve) && $testimonial_approve==2) { ?>selected="selected"<?php } ?>>2</option>
                                <option value="3" <?php if (isset($testimonial_approve) && $testimonial_approve==3) { ?>selected="selected"<?php } ?>>3</option>
                                <option value="4" <?php if (isset($testimonial_approve) && $testimonial_approve==4) { ?>selected="selected"<?php } ?>>4</option>
                                <option value="5" <?php if (isset($testimonial_approve) && $testimonial_approve==5) { ?>selected="selected"<?php } ?>>5</option>
                                <option value="10" <?php if (isset($testimonial_approve) && $testimonial_approve==10) { ?>selected="selected"<?php } ?>><?php echo $text_all; ?></option>
                            </select>
                        </div>
                    </div>
                    <?php if(!$store_id){ ?>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-keyword"><span data-toggle="tooltip" title="<?php echo $help_keyword; ?>"><?php echo $entry_keyword; ?></span></label>
                            <div class="col-sm-10">
                                <input type="text" name="keyword" value="<?php echo isset($keyword)?$keyword:''; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
                                <?php if ($error_keyword) { ?>
                                <div class="text-danger"><?php echo $error_keyword; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                    <?php } ?>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_multilang; ?>"><?php echo $entry_multilang; ?></span></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_multilang" value="1" <?php if (isset($testimonial_multilang) && $testimonial_multilang) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_multilang" value="0" <?php if (!isset($testimonial_multilang) || !$testimonial_multilang) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <?php if(!$store_id){ ?>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_multistore; ?>"><?php echo $entry_multistore; ?></span></label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_multistore" value="1" <?php if (isset($testimonial_multistore) && $testimonial_multistore) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_multistore" value="0" <?php if (!isset($testimonial_multistore) || !$testimonial_multistore) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                    <?php } ?>
                    <?php if(substr(VERSION, 0, 7) < '2.3.0.0'){ ?>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_mail; ?>"><?php echo $entry_mail; ?></span></label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_mail" value="1" <?php if (isset($testimonial_mail) && $testimonial_mail) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_mail" value="0" <?php if (!isset($testimonial_mail) || !$testimonial_mail) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                    <?php } ?>
                    <ul class="nav nav-tabs" id="language">
                        <?php foreach ($languages as $language) { ?>
                        <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="<?php echo file_exists('language/'.$language['code'].'/'.$language['code'].'.png')?'language/'.$language['code'].'/'.$language['code'].'.png':'view/image/flags/'.$language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <div class="tab-content">
                        <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_name; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="testimonial_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name<?php echo $language['language_id']; ?>" class="form-control" />
                                    <?php if (isset($error_name[$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="testimonial_description[<?php echo $language['language_id']; ?>][description]" rows="5" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control summernote"><?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['description'] : ''; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="testimonial_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
                                    <?php if (isset($error_meta_title[$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="testimonial_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
                                <div class="col-sm-10">
                                    <textarea name="testimonial_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($testimonial_description[$language['language_id']]) ? $testimonial_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                </div>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <div class="tab-pane" id="tab-data">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-review-template">
                            <span data-toggle="tooltip" title="<?php echo $help_template; ?>">
                                <?php echo $entry_template; ?>
                            </span>
                        </label>
                        <div class="col-sm-10">
                            <select name="testimonial_template" id="input-review-template" class="form-control">
                                <option value="0" <?php if (!isset($testimonial_template) || $testimonial_template==0) { ?>selected="selected"<?php } ?>>Default</option>
                                <option value="1" <?php if (isset($testimonial_template) && $testimonial_template==1) { ?>selected="selected"<?php } ?>>Template 1</option>
                                <option value="2" <?php if (isset($testimonial_template) && $testimonial_template==2) { ?>selected="selected"<?php } ?>>Template 2</option>
                                <option value="3" <?php if (isset($testimonial_template) && $testimonial_template==3) { ?>selected="selected"<?php } ?>>Template 3</option>
                                <option value="4" <?php if (isset($testimonial_template) && $testimonial_template==4) { ?>selected="selected"<?php } ?>>Template 4</option>
                                <option value="5" <?php if (isset($testimonial_template) && $testimonial_template==5) { ?>selected="selected"<?php } ?>>Template 5</option>
                                <option value="6" <?php if (isset($testimonial_template) && $testimonial_template==6) { ?>selected="selected"<?php } ?>>Template 6</option>
                                <option value="7" <?php if (isset($testimonial_template) && $testimonial_template==7) { ?>selected="selected"<?php } ?>>Template 7</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-review-theme">
                            <span data-toggle="tooltip" title="<?php echo $help_theme ?>">
                                <?php echo $entry_theme; ?>
                            </span>
                        </label>
                        <div class="col-sm-10">
                            <select name="testimonial_theme" id="input-review-theme" class="form-control">
                                <option value="0" <?php if (!isset($testimonial_theme) || $testimonial_theme==0) { ?>selected="selected"<?php } ?>>Default</option>
                                <option value="1" <?php if (isset($testimonial_theme) && $testimonial_theme==1) { ?>selected="selected"<?php } ?>>Not standard</option>
                                <option value="2" <?php if (isset($testimonial_theme) && $testimonial_theme==2) { ?>selected="selected"<?php } ?>>Not standard + Bootstrap</option>
                                <option value="3" <?php if (isset($testimonial_theme) && $testimonial_theme==3) { ?>selected="selected"<?php } ?>>Universal</option>
                                <option value="4" <?php if (isset($testimonial_theme) && $testimonial_theme==4) { ?>selected="selected"<?php } ?>>Pavilion(Shoppica)</option>
                                <option value="5" <?php if (isset($testimonial_theme) && $testimonial_theme==5) { ?>selected="selected"<?php } ?>>Journal</option>
                                <option value="6" <?php if (isset($testimonial_theme) && $testimonial_theme==6) { ?>selected="selected"<?php } ?>>Customized</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_sort; ?>"><?php echo $entry_sort; ?></span></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_sort" value="1" <?php if (isset($testimonial_sort) && $testimonial_sort) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_sort" value="0" <?php if (!isset($testimonial_sort) || !$testimonial_sort) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_count; ?>"><?php echo $entry_count; ?></span></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_count" value="1" <?php if (isset($testimonial_count) && $testimonial_count) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_count" value="0" <?php if (!isset($testimonial_count) || !$testimonial_count) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_popup; ?>"><?php echo $entry_popup; ?></span></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_popup" value="1" <?php if (isset($testimonial_popup) && $testimonial_popup) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_popup" value="0" <?php if (!isset($testimonial_popup) || !$testimonial_popup) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_email; ?>"><?php echo $entry_email; ?></span></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_email" value="1" <?php if (isset($testimonial_email) && $testimonial_email) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_email" value="" <?php if (!isset($testimonial_email) || !$testimonial_email) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_email_required; ?>"><?php echo $entry_email_required; ?></span></label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_email_required" value="1" <?php if (isset($testimonial_email_required) && $testimonial_email_required) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_email_required" value="" <?php if (!isset($testimonial_email_required) || !$testimonial_email_required) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <?php if(substr(VERSION, 0, 7) < '2.1.0.1'){ ?>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_captcha; ?>"><?php echo $entry_captcha; ?></span></label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_captcha" value="1" <?php if (isset($testimonial_captcha) && $testimonial_captcha) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_captcha" value="" <?php if (!isset($testimonial_captcha) || !$testimonial_captcha) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                    <?php } ?>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                             <span data-toggle="tooltip" title="<?php echo $help_date_added; ?>">
                                <?php echo $entry_date_added; ?>
                             </span>
                        </label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_date" value="1" <?php if (isset($testimonial_date) && $testimonial_date) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_date" value="" <?php if (!isset($testimonial_date) || !$testimonial_date) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-date-format"><span data-toggle="tooltip" data-html="true" data-trigger="click" title="<?php echo htmlspecialchars($help_date_format); ?>"><?php echo $entry_date_format; ?></span></label>
                        <div class="col-sm-10">
                            <input type="text" name="testimonial_date_format" value="<?php echo isset($testimonial_date_format) ? $testimonial_date_format : ''; ?>" placeholder="<?php echo $entry_date_format; ?>" id="input-date-format" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">
                            <span data-toggle="tooltip" title="<?php echo $help_registered; ?>">
                                <?php echo $entry_registered; ?>
                            </span>
                        </label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_registered" value="1" <?php if (isset($testimonial_registered) && $testimonial_registered) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_yes; ?>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="testimonial_registered" value="" <?php if (!isset($testimonial_registered) || !$testimonial_registered) { ?>checked="checked"<?php } ?> />
                                <?php echo $text_no; ?>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-registered-color"><span data-toggle="tooltip" title="<?php echo $help_color; ?>"><?php echo $entry_registered_color; ?></span> <i class="fa fa-check" style="color:<?php echo isset($testimonial_registered_color) ? $testimonial_registered_color : ''; ?>;"></i></label>
                        <div class="col-sm-10">
                            <input type="text" name="testimonial_registered_color" value="<?php echo isset($testimonial_registered_color) ? $testimonial_registered_color : ''; ?>" placeholder="<?php echo $entry_registered_color; ?>" id="input-registered-color" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-review-limit"><span data-toggle="tooltip" title="<?php echo $help_limit; ?>"><?php echo $entry_limit; ?></span></label>
                        <div class="col-sm-10">
                            <input type="text" name="testimonial_limit" value="<?php echo isset($testimonial_limit) ? $testimonial_limit : ''; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-review-limit" class="form-control" />
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab-rating">
                    <div class="tab-content">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><?php echo $entry_rating; ?></label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_rating" value="1" <?php if (isset($testimonial_rating) && $testimonial_rating) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_rating" value=""  <?php if (!isset($testimonial_rating) || !$testimonial_rating) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                <span data-toggle="tooltip" title="<?php echo $help_rating_required; ?>">
                                    <?php echo $entry_rating_required; ?>
                                </span>
                            </label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_rating_required" value="1" <?php if (isset($testimonial_rating_required) && $testimonial_rating_required) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_rating_required" value="" <?php if (!isset($testimonial_rating_required) || !$testimonial_rating_required) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-review-stars"><span data-toggle="tooltip" title="<?php echo $help_star; ?>"><?php echo $entry_rating_star; ?></span></label>
                            <div class="col-sm-10">
                                <select name="testimonial_stars" id="input-review-stars" class="form-control">
                                    <option value="0" <?php if (!isset($testimonial_stars) || $testimonial_stars==0) { ?>selected="selected"<?php } ?>>Default</option>
                                    <option value="1" <?php if (isset($testimonial_stars) && $testimonial_stars==1) { ?>selected="selected"<?php } ?>>1</option>
                                    <option value="2" <?php if (isset($testimonial_stars) && $testimonial_stars==2) { ?>selected="selected"<?php } ?>>2</option>
                                    <option value="3" <?php if (isset($testimonial_stars) && $testimonial_stars==3) { ?>selected="selected"<?php } ?>>3</option>
                                    <option value="4" <?php if (isset($testimonial_stars) && $testimonial_stars==4) { ?>selected="selected"<?php } ?>>4</option>
                                    <option value="5" <?php if (isset($testimonial_stars) && $testimonial_stars==5) { ?>selected="selected"<?php } ?>>5</option>
                                    <option value="6" <?php if (isset($testimonial_stars) && $testimonial_stars==6) { ?>selected="selected"<?php } ?>>6</option>
                                    <option value="7" <?php if (isset($testimonial_stars) && $testimonial_stars==7) { ?>selected="selected"<?php } ?>>7</option>
                                    <option value="8" <?php if (isset($testimonial_stars) && $testimonial_stars==8) { ?>selected="selected"<?php } ?>>8</option>
                                    <option value="9" <?php if (isset($testimonial_stars) && $testimonial_stars==9) { ?>selected="selected"<?php } ?>>9</option>
                                    <option value="10" <?php if (isset($testimonial_stars) && $testimonial_stars==10) { ?>selected="selected"<?php } ?>>10</option>
                                    <option value="11" <?php if (isset($testimonial_stars) && $testimonial_stars==11) { ?>selected="selected"<?php } ?>>11</option>
                                    <option value="12" <?php if (isset($testimonial_stars) && $testimonial_stars==12) { ?>selected="selected"<?php } ?>>12</option>
                                    <option value="13" <?php if (isset($testimonial_stars) && $testimonial_stars==13) { ?>selected="selected"<?php } ?>>13</option>
                                    <option value="14" <?php if (isset($testimonial_stars) && $testimonial_stars==14) { ?>selected="selected"<?php } ?>>14</option>
                                    <option value="15" <?php if (isset($testimonial_stars) && $testimonial_stars==15) { ?>selected="selected"<?php } ?>>15</option>
                                    <option value="16" <?php if (isset($testimonial_stars) && $testimonial_stars==16) { ?>selected="selected"<?php } ?>>16</option>

                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-pttrn"><?php echo $entry_rating_pattern; ?></label>
                            <div class="col-sm-10">
                                <div class="rating-block">
                                <div class="cell"><span>1</span></div>
                                <div class="cell"><span>2</span></div>
                                <div class="cell"><span>3</span></div>
                                <div class="cell"><span>4</span></div>
                                <div class="cell"><span>5</span></div>
                                <div class="cell"><span>6</span></div>
                                <div class="cell"><span>7</span></div>
                                <div class="cell"><span>8</span></div>
                                <div class="cell"><span>9</span></div>
                                <div class="cell"><span>10</span></div>
                                <div class="cell"><span>11</span></div>
                                <div class="cell"><span>12</span></div>
                                <div class="cell"><span>13</span></div>
                                <div class="cell"><span>14</span></div>
                                <div class="cell"><span>15</span></div>
                                <div class="cell"><span>16</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-review-icon"><?php echo $entry_rating_icon; ?></label>
                            <div class="col-sm-10">
                                <select name="testimonial_icon" id="input-review-icon" class="form-control">
                                    <option value="0" <?php if (!isset($testimonial_icon) || $testimonial_icon==0) { ?>selected="selected"<?php } ?>>&#xf006 Star</option>
                                    <option value="1" <?php if (isset($testimonial_icon) && $testimonial_icon==1) { ?>selected="selected"<?php } ?>>&#xf087 Thumb Up</option>
                                    <option value="2" <?php if (isset($testimonial_icon) && $testimonial_icon==2) { ?>selected="selected"<?php } ?>>&#xf091 Trophy</option>
                                    <option value="3" <?php if (isset($testimonial_icon) && $testimonial_icon==3) { ?>selected="selected"<?php } ?>>&#xf118 Smile</option>
                                    <option value="4" <?php if (isset($testimonial_icon) && $testimonial_icon==4) { ?>selected="selected"<?php } ?>>&#xf0a3 Certificate</option>
                                    <option value="5" <?php if (isset($testimonial_icon) && $testimonial_icon==5) { ?>selected="selected"<?php } ?>>&#xf08a Heart</option>
                                    <option value="6" <?php if (isset($testimonial_icon) && $testimonial_icon==6) { ?>selected="selected"<?php } ?>>&#xf10c Circle</option>
                                    <option value="7" <?php if (isset($testimonial_icon) && $testimonial_icon==7) { ?>selected="selected"<?php } ?>>&#xf00c Check</option>
                                    <option value="8" <?php if (isset($testimonial_icon) && $testimonial_icon==8) { ?>selected="selected"<?php } ?>>&#xf05d Check & Circle</option>
                                    <option value="9" <?php if (isset($testimonial_icon) && $testimonial_icon==9) { ?>selected="selected"<?php } ?>>&#xf097 Bookmark</option>
                                    <option value="10" <?php if (isset($testimonial_icon) && $testimonial_icon==10) { ?>selected="selected"<?php } ?>>&#xf069 Asterisk</option>
                                    <option value="11" <?php if (isset($testimonial_icon) && $testimonial_icon==11) { ?>selected="selected"<?php } ?>>&#xf005 + &#xf1db Star & Circle</option>
                                    <option value="12" <?php if (isset($testimonial_icon) && $testimonial_icon==12) { ?>selected="selected"<?php } ?>>&#xf005 + &#xf111 Star & Circle</option>
                                    <option value="13" <?php if (isset($testimonial_icon) && $testimonial_icon==13) { ?>selected="selected"<?php } ?>>&#xf006 + &#xf1db Star & Circle</option>
                                    <option value="14" <?php if (isset($testimonial_icon) && $testimonial_icon==14) { ?>selected="selected"<?php } ?>>&#xf006 + &#xf111 Star & Circle</option>
                                    <option value="15" <?php if (isset($testimonial_icon) && $testimonial_icon==15) { ?>selected="selected"<?php } ?>>&#xf005 + &#xf096 Star & Square</option>
                                    <option value="16" <?php if (isset($testimonial_icon) && $testimonial_icon==16) { ?>selected="selected"<?php } ?>>&#xf005 + &#xf0c8 Star & Square</option>
                                    <option value="17" <?php if (isset($testimonial_icon) && $testimonial_icon==17) { ?>selected="selected"<?php } ?>>&#xf006 + &#xf096 Star & Square</option>
                                    <option value="18" <?php if (isset($testimonial_icon) && $testimonial_icon==18) { ?>selected="selected"<?php } ?>>&#xf006 + &#xf0c8 Star & Square</option>
                                    <option value="19" <?php if (isset($testimonial_icon) && $testimonial_icon==19) { ?>selected="selected"<?php } ?>>&#xf046 Check & Square</option>
                                    <option value="20" <?php if (isset($testimonial_icon) && $testimonial_icon==20) { ?>selected="selected"<?php } ?>>&#xf058 Check & Circle</option>
                                    <option value="21" <?php if (isset($testimonial_icon) && $testimonial_icon==21) { ?>selected="selected"<?php } ?>>&#xf11d Flag</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-rating-color; ?>"><span data-toggle="tooltip" title="<?php echo $help_color_star; ?>"><?php echo $entry_rating_color; ?></span> <i class="fa fa-star" style="color:<?php echo isset($testimonial_icon_color) ? $testimonial_icon_color : ''; ?>;" ></i></label>
                            <div class="col-sm-10">
                                <input type="text" name="testimonial_icon_color" value="<?php echo isset($testimonial_icon_color) ? $testimonial_icon_color : ''; ?>" placeholder="<?php echo $entry_rating_color; ?>" id="input-rating-color" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-rating-border; ?>"><span data-toggle="tooltip" title="<?php echo $help_color_border; ?>"><?php echo $entry_rating_border; ?></span> <i class="fa fa-star-o" style="color:<?php echo isset($testimonial_icon_border) ? $testimonial_icon_border : ''; ?>;"></i></label>
                            <div class="col-sm-10">
                                <input type="text" name="testimonial_icon_border" value="<?php echo isset($testimonial_icon_border) ? $testimonial_icon_border : ''; ?>" placeholder="<?php echo $entry_rating_border; ?>" id="input-rating-border" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-icon-size"><?php echo $entry_rating_size; ?></label>
                            <div class="col-sm-10">
                                <select name="testimonial_icon_size" id="input-icon-size" class="form-control">
                                    <option value="8" <?php if (!isset($testimonial_icon_size) || $testimonial_icon_size==8) { ?>selected="selected"<?php } ?>>8</option>
                                    <option value="9" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==9) { ?>selected="selected"<?php } ?>>9</option>
                                    <option value="10" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==10) { ?>selected="selected"<?php } ?>>10</option>
                                    <option value="11" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==11) { ?>selected="selected"<?php } ?>>11</option>
                                    <option value="12" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==12) { ?>selected="selected"<?php } ?>>12</option>
                                    <option value="13" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==13) { ?>selected="selected"<?php } ?>>13</option>
                                    <option value="14" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==14) { ?>selected="selected"<?php } ?>>14</option>
                                    <option value="15" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==15) { ?>selected="selected"<?php } ?>>15</option>
                                    <option value="16" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==16) { ?>selected="selected"<?php } ?>>16</option>
                                    <option value="17" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==17) { ?>selected="selected"<?php } ?>>17</option>
                                    <option value="18" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==18) { ?>selected="selected"<?php } ?>>18</option>
                                    <option value="19" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==19) { ?>selected="selected"<?php } ?>>19</option>
                                    <option value="20" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==20) { ?>selected="selected"<?php } ?>>20</option>
                                    <option value="21" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==21) { ?>selected="selected"<?php } ?>>21</option>
                                    <option value="22" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==22) { ?>selected="selected"<?php } ?>>22</option>
                                    <option value="23" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==23) { ?>selected="selected"<?php } ?>>23</option>
                                    <option value="24" <?php if (isset($testimonial_icon_size) && $testimonial_icon_size==24) { ?>selected="selected"<?php } ?>>24</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab-image">
                    <div class="tab-content">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><?php echo $entry_image; ?></label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_image" value="1" <?php if (isset($testimonial_image) && $testimonial_image) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_image" value="" <?php if (!isset($testimonial_image) || !$testimonial_image) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                <span data-toggle="tooltip" title="<?php echo $help_image_required; ?>">
                                    <?php echo $entry_image_required; ?>
                                </span>
                            </label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_image_required" value="1" <?php if (isset($testimonial_image_required) && $testimonial_image_required) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_yes; ?>
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="testimonial_image_required" value="" <?php if (!isset($testimonial_image_required) || !$testimonial_image_required) { ?>checked="checked"<?php } ?> />
                                    <?php echo $text_no; ?>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-image-width">
                                <span data-toggle="tooltip" title="<?php echo $help_image_size; ?>">
                                    <?php echo $entry_image_size; ?>
                                </span>
                            </label>
                            <div class="col-sm-10">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="text" name="testimonial_image_width" value="<?php echo isset($testimonial_image_width)?$testimonial_image_width:''; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-width" class="form-control" />
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" name="testimonial_image_height" value="<?php echo isset($testimonial_image_height)?$testimonial_image_height:''; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                                    </div>
                                </div>
                                <?php if ($error_image) { ?>
                                <div class="text-danger"><?php echo $error_image; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-file-size; ?>"><span data-toggle="tooltip" title="<?php echo $help_file_size; ?>"><?php echo $entry_file_size; ?></span></label>
                            <div class="col-sm-10">
                                <input type="text" name="testimonial_file_size" value="<?php echo isset($testimonial_file_size) ? $testimonial_file_size : ''; ?>" placeholder="<?php echo $entry_file_size; ?>" id="input-file-size" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-default-image">
                                <span data-toggle="tooltip" title="<?php echo $help_default_image; ?>">
                                    <?php echo $entry_default_image; ?>
                                </span>
                            </label>
                            <div class="col-sm-10">
                                <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                                <input type="hidden" name="testimonial_default_image" value="<?php echo isset($testimonial_default_image)?$testimonial_default_image:''; ?>" id="input-default-image" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="tab-design">
                    <div class="tab-content">
                        <table id="module" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <td class="text-left"><?php echo $entry_module; ?></td>
                                <td class="text-left"><?php echo $entry_position; ?></td>
                                <td class="text-right"><?php echo $entry_sort_order; ?></td>
                                <td></td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php $module_row = 0; ?>
                            <?php if(isset($testimonial_parts)) { ?>
                            <?php foreach ($testimonial_parts as $part) { ?>
                            <tr id="module-row<?php echo $module_row; ?>">
                                <td class="text-left">
                                    <select name="testimonial_parts[<?php echo $module_row; ?>][code]" class="form-control">
                                        <option value="description" <?php if('description' == $part['code']){ ?>selected="selected"<?php } ?>><?php echo $text_module_desc; ?></option>
                                        <option value="rating" <?php if('rating' == $part['code']){ ?>selected="selected"<?php } ?>><?php echo $text_module_rating; ?></option>
                                        <option value="popup" <?php if('popup' == $part['code']){ ?>selected="selected"<?php } ?>><?php echo $text_module_form; ?></option>
                                        <option value="panel" <?php if('panel' == $part['code']){ ?>selected="selected"<?php } ?>><?php echo $text_module_panel; ?></option>
                                    </select>
                                </td>
                                <td class="text-left">
                                    <select name="testimonial_parts[<?php echo $module_row; ?>][position]" class="form-control">
                                        <option value="1" <?php if (1 == $part['position']) { ?>selected="selected"<?php } ?>><?php echo $text_top_left; ?></option>
                                        <option value="2" <?php if (2 == $part['position']) { ?>selected="selected"<?php } ?>><?php echo $text_top_center; ?></option>
                                        <option value="3" <?php if (3 == $part['position']) { ?>selected="selected"<?php } ?>><?php echo $text_top_right; ?></option>
                                        <option value="4" <?php if (4 == $part['position']) { ?>selected="selected"<?php } ?>><?php echo $text_bottom_left; ?></option>
                                        <option value="5" <?php if (5 == $part['position']) { ?>selected="selected"<?php } ?>><?php echo $text_bottom_center; ?></option>
                                        <option value="6" <?php if (6 == $part['position']) { ?>selected="selected"<?php } ?>><?php echo $text_bottom_right; ?></option>
                                    </select>
                                </td>
                                <td class="text-right">
                                    <input type="text" name="testimonial_parts[<?php echo $module_row; ?>][sort_order]" value="<?php echo $part['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" />
                                </td>
                                <td class="text-left">
                                    <button type="button" onclick="$('#module-row<?php echo $module_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger">
                                        <i class="fa fa-minus-circle"></i>
                                    </button>
                                </td>
                            </tr>
                            <?php $module_row++; ?>
                            <?php } ?>
                            <?php } ?>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="3"></td>
                                <td class="text-left"><button type="button" onclick="addModule();" data-toggle="tooltip" title="<?php echo $button_module_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                            </tr>
                            </tfoot>
                        </table>
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
    <script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
    <link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
    <script type="text/javascript" src="view/javascript/summernote/opencart.js"></script>
    <script type="text/javascript"><!--
        <?php foreach ($languages as $language) { ?>
            $('#input-description<?php echo $language['language_id']; ?>').summernote({height: 150});
        <?php } ?>
        //--></script>
    <script type="text/javascript"><!--
        $('#language a:first').tab('show');
        $('#translation a:first').tab('show');
        $('#option a:first').tab('show');
        //--></script>
    <script type="text/javascript"><!--
        var module_row = <?php echo $module_row; ?>;

        function addModule() {
            html  = '<tr id="module-row' + module_row + '">';
            html += '  <td class="text-left"><select name="testimonial_parts[' + module_row + '][code]" class="form-control">';
            html += '    <option value="description"><?php echo $text_module_desc; ?></option>';
            html += '    <option value="rating"><?php echo $text_module_rating; ?></option>';
            html += '    <option value="popup"><?php echo $text_module_form; ?></option>';
            html += '    <option value="panel"><?php echo $text_module_panel; ?></option>';
            html += '  </select></td>';
            html += '  <td class="text-left"><select name="testimonial_parts[' + module_row + '][position]" class="form-control">';
            html += '    <option value="1"><?php echo $text_top_left; ?></option>';
            html += '    <option value="2"><?php echo $text_top_center; ?></option>';
            html += '    <option value="3"><?php echo $text_top_right; ?></option>';
            html += '    <option value="4"><?php echo $text_bottom_left; ?></option>';
            html += '    <option value="5"><?php echo $text_bottom_center; ?></option>';
            html += '    <option value="6"><?php echo $text_bottom_right; ?></option>';
            html += '  </select></td>';
            html += '  <td class="text-left"><input type="text" name="testimonial_parts[' + module_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
            html += '  <td class="text-left"><button type="button" onclick="$(\'#module-row' + module_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
            html += '</tr>';

            $('#module tbody').append(html);

            module_row++;
        }
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
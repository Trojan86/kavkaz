<!--form start-->
<?php echo $recaptcha_api; ?>
<?php if ($testimonial_tm_status) { ?>
    <?php if ($testimonial_popup) { ?>
            <div class="buttons clearfix">
                <button type="button" href="index.php?route=testimonial/testimonial/getpopupform" class="btn btn-primary <?php echo $class; ?>"
                        data-toggle="modal" data-target="#btn-popup<?php echo $module; ?>">
                    <?php echo $text_write; ?>
                </button>
            </div>
            <div class="modal fade" id="btn-popup<?php echo $module; ?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="tm-container">
                    <div class="modal-dialog">
                        <div class="modal-content"></div>
                    </div>
                </div>
            </div>
        <?php } else { ?>
        <div id="sr-form-content">
            <form class="form-horizontal" id="tm-form" method="post" enctype="multipart/form-data"
                  action="<?php echo $action; ?>">
                <div class="form-title"><?php echo $text_write; ?></div>
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                        <input type="text" name="name" value="<?php echo $name; ?>" id="input-name"
                               class="form-control"/>
                        <?php if ($error_name) { ?>
                        <div class="text-danger"><?php echo $error_name; ?></div>
                        <?php } ?>
                    </div>
                </div>
                <?php if ($testimonial_email) { ?>
                <div class="form-group <?php if($testimonial_email_required){ ?>required<?php } ?>">
                    <div class="col-sm-12">
                        <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                        <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control"/>
                        <?php if ($error_email) { ?>
                        <div class="text-danger"><?php echo $error_email; ?></div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                    <textarea name="text" rows="5" id="input-review"
                                              class="form-control"><?php echo $text; ?></textarea>
                        <?php if ($error_text) { ?>
                        <div class="text-danger"><?php echo $error_text; ?></div>
                        <?php } ?>
                        <div class="help-block"><?php echo $text_note; ?></div>
                    </div>
                </div>
                <?php if($testimonial_image){ ?>
                <div class="form-group <?php echo ($testimonial_image_required ? 'required' : ''); ?>">
                    <div class="col-sm-12">
                        <label class="control-label before-upload" for="input-image"><?php echo $entry_image; ?></label>
                        <label class="upload-label">
                            <span class="btn btn-default btn-file"><?php echo $button_upload; ?></span>
                            <mark class="form-control"><?php echo $entry_choose_image; ?></mark>
                            <input name="image" type="file" id="input-image" accept="image/*">
                        </label>
                        <?php if ($error_image) { ?>
                        <div class="text-danger"><?php echo $error_image; ?></div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php if($testimonial_rating){ ?>
                <div class="form-group <?php if($testimonial_rating_required){ ?>required<?php } ?>">
                    <?php if(!$testimonial_stars){ ?>
                    <div class="col-sm-12">
                        <label class="control-label"><?php echo $entry_rating; ?></label>
                        &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                        <input type="radio" name="rating" value="1" <?php if($rating==1){ ?>checked<?php } ?>/>
                        &nbsp;
                        <input type="radio" name="rating" value="2" <?php if($rating==2){ ?>checked<?php } ?>/>
                        &nbsp;
                        <input type="radio" name="rating" value="3" <?php if($rating==3){ ?>checked<?php } ?>/>
                        &nbsp;
                        <input type="radio" name="rating" value="4" <?php if($rating==4){ ?>checked<?php } ?>/>
                        &nbsp;
                        <input type="radio" name="rating" value="5" <?php if($rating==5){ ?>checked<?php } ?>/>
                        &nbsp;<?php echo $entry_good; ?>
                        <br/>
                        <?php if ($error_rating) { ?>
                        <div class="text-danger"><?php echo $error_rating; ?></div>
                        <?php } ?>
                    </div>
                    <?php } else{ ?>
                    <div class="col-sm-12">
                        <div class="rating-radio star-tmp<?php echo $testimonial_stars; ?>">
                            <input type="radio" name="rating" value="1" class="star-1"
                                   id="star-1" <?php if($rating==1){ ?>checked<?php } ?>/>
                            <label class="star-1" for="star-1"></label>

                            <input type="radio" name="rating" value="2" class="star-2"
                                   id="star-2" <?php if($rating==2){ ?>checked<?php } ?>/>
                            <label class="star-2" for="star-2"></label>

                            <input type="radio" name="rating" value="3" class="star-3"
                                   id="star-3" <?php if($rating==3){ ?>checked<?php } ?>/>
                            <label class="star-3" for="star-3"></label>

                            <input type="radio" name="rating" value="4" class="star-4"
                                   id="star-4" <?php if($rating==4){ ?>checked<?php } ?>/>
                            <label class="star-4" for="star-4"></label>

                            <input type="radio" name="rating" value="5" class="star-5"
                                   id="star-5" <?php if($rating==5){ ?>checked<?php } ?>/>
                            <label class="star-5" for="star-5"></label>
                            <span></span>
                        </div>
                        <?php if ($error_rating) { ?>
                        <div class="text-danger"><?php echo $error_rating; ?></div>
                        <?php } ?>
                    </div>
                    <?php } ?>

                </div>
                <?php } ?>
                <?php if (isset($site_key) && $site_key) { ?>
                <?php if ($testimonial_captcha) { ?>
                <div class="form-group">
                    <div class="col-sm-12">
                        <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
                        <?php if ($error_captcha) { ?>
                        <div class="text-danger"><?php echo $error_captcha; ?></div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>
                <?php } elseif(isset($captcha) && $captcha){ ?>
                <?php echo $captcha; ?>
                <?php } ?>
                <div class="buttons clearfix">
                    <div class="pull-right">
                        <button type="submit" id="btn-add-review" data-loading-text="<?php echo $text_loading; ?>"
                                class="btn btn-primary"><?php echo $button_continue; ?></button>
                    </div>
                </div>
            </form>
        </div>
    <?php } ?>
<?php } else { ?>
<?php echo $text_login; ?>
<?php } ?>
<!--form end-->

<script type="text/javascript"><!--
    $(document).ready(function() {
        $('#btn-popup'+<?php echo $module; ?>).on('show.modal', function (event) { });
    });
    //--></script>
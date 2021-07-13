<?php echo $recaptcha_api; ?>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h4 class="modal-title" id="exampleModalLabel"><?php echo $text_write; ?></h4>
</div>
<div class="modal-body">
<form id="tm-form-popup" method="post" class="row" enctype="multipart/form-data" action="<?php echo $action; ?>">
    <span id="tm-box-message"></span>
    <div class="form-group required">
        <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
        <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
    </div>
    <?php if ($testimonial_email) { ?>
    <div class="form-group <?php if($testimonial_email_required){ ?>required<?php } ?>">
        <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
        <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control"/>
    </div>
    <?php } ?>
    <div class="form-group required">
        <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
        <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
        <div class="help-block"><?php echo $text_note; ?></div>
    </div>
    <?php if($testimonial_image){ ?>
    <div class="form-group<?php echo ($testimonial_image_required ? ' required' : ''); ?>">
        <label class="control-label before-upload" for="input-image"><?php echo $entry_image; ?></label>
        <label class="upload-label">
            <span class="button btn btn-default btn-file"><?php echo $button_upload; ?></span>
            <mark class="form-control"><?php echo $entry_choose_image; ?></mark>
            <input name="image" type="file" id="input-image" accept="image/*">
        </label>
    </div>
    <?php } ?>
    <?php if($testimonial_rating){ ?>
    <div class="form-group <?php if($testimonial_rating_required){ ?>required<?php } ?>">
        <?php if(!$testimonial_stars){ ?>
        <label class="control-label"><?php echo $entry_rating; ?></label>
        &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
        <input type="radio" name="rating" value="1" />
        &nbsp;
        <input type="radio" name="rating" value="2" />
        &nbsp;
        <input type="radio" name="rating" value="3" />
        &nbsp;
        <input type="radio" name="rating" value="4" />
        &nbsp;
        <input type="radio" name="rating" value="5" />
        &nbsp;<?php echo $entry_good; ?>
        <br />
        <?php } else{ ?>
        <div class="rating-radio star-tmp<?php echo $testimonial_stars; ?>">
            <input type="radio" name="rating" value="1" class="star-1" id="star-1" />
            <label class="star-1" for="star-1">1</label>

            <input type="radio" name="rating" value="2" class="star-2" id="star-2" />
            <label class="star-2" for="star-2">2</label>

            <input type="radio" name="rating" value="3" class="star-3" id="star-3" />
            <label class="star-3" for="star-3">3</label>

            <input type="radio" name="rating" value="4" class="star-4" id="star-4" />
            <label class="star-4" for="star-4">4</label>

            <input type="radio" name="rating" value="5" class="star-5" id="star-5" />
            <label class="star-5" for="star-5">5</label>
            <span></span>
        </div>
        <?php } ?>
    </div>
    <?php } ?>
    <?php if (isset($site_key) && $site_key) { ?>
    <?php if ($testimonial_captcha) { ?>
    <div class="form-group">
        <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
    </div>
    <?php } ?>
    <?php } elseif(isset($captcha) && $captcha){ ?>
    <?php echo $captcha; ?>
    <?php } ?>
</form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_cancel; ?></button>
    <button type="button" id="tm-btn-add" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
</div>
<script type="text/javascript"><!--
    $('#tm-btn-add').on('click', function() {
        $.ajax({
            url: 'index.php?route=testimonial/testimonial/ajax_validate',
            type: 'post',
            dataType: 'json',
            data:  $("#tm-form-popup").serialize()+"&image=" + $('#tm-form-popup input[type=\'file\']').val(),
            beforeSend: function(){
                $('#tm-btn-add').button('loading');
            },
            complete: function() {
                $('#tm-btn-add').button('reset');
                if($("textarea").is("#g-recaptcha-response")){
                    grecaptcha.reset();
                }
            },
            success: function(json) {
                $('.alert-success, .alert-danger').remove();
                if (json['error']) {
                    $('#tm-box-message').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">×</button></div>');
                }else if(json['success']) {
                    $( "#tm-form-popup" ).submit();
                }
            }
        });
    });

    $('#input-image').on('change', function() {
        if('<?php echo $testimonial_file_size; ?>' && this.files[0] && (this.files[0].size > '<?php echo $testimonial_file_size; ?>')) {
            $('#input-image').val('');
            $('#tm-box-message').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_file_size; ?><button type="button" class="close" data-dismiss="alert">×</button></div>');
        }
    });

    $(function(){
        var wrapper = $( ".upload-label" ),
                inp = wrapper.find( "input" ),
                btn = wrapper.find( ".button" ),
                lbl = wrapper.find( "mark" );

        // Crutches for the :focus style:
        inp.focus(function(){
            wrapper.addClass( "focus" );
        }).blur(function(){
            wrapper.removeClass( "focus" );
        });

        var file_api = ( window.File && window.FileReader && window.FileList && window.Blob ) ? true : false;

        inp.change(function(){
            var file_name;
            if( file_api && inp[ 0 ].files[ 0 ] )
                file_name = inp[ 0 ].files[ 0 ].name;
            else
                file_name = inp.val().replace( "C:\\fakepath\\", '' );

            if( ! file_name.length )
                return;

            if( lbl.is( ":visible" ) ){
                console.log(file_name);
                lbl.text( file_name );
                btn.text( "<?php echo $button_upload; ?>" );
            }else
                btn.text( file_name );
        }).change();

    });
    $( window ).resize(function(){
        $( ".file_upload input" ).triggerHandler( "change" );
    });
  //--></script>


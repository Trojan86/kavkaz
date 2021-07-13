<div class="testimonial__container-dish testimonial__container-dish" id="review-extended">
  <?php if ($reviews) { ?>
  <?php if($extended_reviews['all_media'] && (!empty($total_videos) || !empty($total_images))){ ?>
  <div class="review-media-all">
    <?php if(!empty($total_videos)){ ?>
    <p class="review-all-photo-title"><?php echo $customers_video; ?></p>
    <div class="owl-carousel-videos">
      <?php foreach ($total_videos as $video) { ?>
      <div class="videos-thumbnails item"><a class="popup-youtube" href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img src="//img.youtube.com/vi/<?php echo $video; ?>/mqdefault.jpg" alt="" class="youtube-click">
          <svg viewBox="0 0 57 40" id="icon-youtube" xmlns="http://www.w3.org/2000/svg" width="30px" height="100%">
            <path fill= "#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path>
            <path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path></svg>
        </a></div>
      <?php } ?>
    </div>
    <?php } ?>
    <?php if(!empty($total_images)){ ?>
    <p class="review-all-photo-title"><?php echo $customers_photo; ?></p>
    <div class="owl-carousel-photo all-reviews-thumbnails">
      <?php foreach ($total_images as $images) { ?>
      <?php foreach ($images as $image) { ?>
      <div class="item ex-image-additional">
        <a class="ex-thumbnail" href="<?php echo $image['popup']; ?>"> <img src="<?php echo $image['thumb']; ?>" class = "<?php echo $image['type'] == '0' ? 'image-crop' : 'imgbb' ?>" /></a>
      </div>
      <?php } ?>
      <?php } ?>
    </div>
    <?php } ?>
  </div>
  <?php }?>
  <!--<div class="col-md-5 col-xs-12 fl-r pd-0">
      <a class="btn btn-blue to-write-review" href="javascript:;" onclick="$('html,body').animate({scrollTop: $('#form-review').offset().top}, 500);"><i class="fa fa-pencil"></i> <?php echo $text_write; ?></a>
    </div>-->
  <div class="testimonial__list-box">
    <ul class="testimonial__list">
      <?php foreach ($reviews as $review) { ?>
      <li class="testimonial__item">
        <div class="review-title-container testimonial__tittle-box">
          <img class="testimonial__avatar" src="catalog/view/theme/default/img/avatar-1.png" alt="avatar images">
          <div class="testimonial__tittle-left">
            <div class="rating-container">
              <?php if ($review['rating'] != 0){ ?>
              <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($review['rating'] < $i) { ?>
              <span class="fa star-stack"><i class="fa fa-star fa-stack-2x star-gray"></i></span>
              <?php } else { ?>
              <span class="fa star-stack"><i class="fa fa-star fa-stack-2x"></i></span>
              <?php } ?>
              <?php } ?>
              <?php } ?>
            </div>
            <div class="review-author">
              <span class="review-author-name" <?php echo $extended_reviews['micro'] ? 'itemprop="author"' : '';?>><?php echo $review['author']; ?></span>
              <?php if($review['purchased']){ ?>
              <span class='allready-buy'><i class="fa fa-shopping-cart" aria-hidden="true"></i> <?php echo $text_already_buy; ?></span>
              <?php } ?>
            </div>
          </div>
          <?php if($extended_reviews['micro']){?>
          <meta itemprop="name" content="<?php echo $review['pd_name']; ?>">
          <meta itemprop="datePublished" content="<?php echo $review['date_added']; ?>">
          <div itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
          <meta itemprop="worstRating" content = "1">
          <meta itemprop="ratingValue" content = "<?php echo $review['rating']; ?>">
          <meta itemprop="bestRating" content = "5">
          </div>
          <?php }?>
        </div>
        <div class="review-text-container testimonial__description-dish">
          <div class="comment-text testimonial__description-text">
            <p <?php echo $extended_reviews['micro'] ? 'itemprop="reviewBody"' : '';?>><?php echo $review['text']; ?></p>
            <?php if($extended_reviews['limitations']){ ?>
            <?php if($review['plus']){ ?>
            <p></span><strong class='plus'><?php echo $text_plus; ?> </strong><span><?php echo $review['plus']; ?></p>
            <?php } ?>
            <?php if($review['minus']){ ?>
            <p></span><strong class='minus'><?php echo $text_minus; ?> </strong><span><?php echo $review['minus']; ?></p>
            <?php } ?>
            <?php } ?>
          </div>
        </div>
        <?php if($extended_reviews['photo_status'] || $extended_reviews['video_status']){ ?>
        <div class="review-media-container">
          <?php if($extended_reviews['photo_status']){ ?>
          <?php if(!empty($review['images'])){ ?>
          <div class="owl-carousel-photo photo-thumbnails <?php echo !$extended_reviews['owl_photo_status'] ? 'reviews-thumbnails' : ''; ?>">
            <?php foreach($review['images'] as $image){ ?>
            <div class="item image-thumbnails ex-image-additional"><a class="ex-thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $review['pd_name']; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $review['pd_name']; ?>" alt="<?php echo $review['pd_name']; ?>" class = "<?php echo $image['type'] == '0' ? 'image-crop' : 'imgbb' ?>" /></a></div>
            <?php } ?>
          </div>
          <?php } ?>
          <?php } ?>
          <?php if($extended_reviews['video_status']){ ?>
          <?php if(!empty($review['videos'])){ ?>
          <div class="owl-carousel-videos <?php echo !$extended_reviews['owl_video_status'] ? 'reviews-thumbnails' : ''; ?>">
            <?php foreach($review['videos'] as $video){ ?>
            <div class="item videos-thumbnails"><a class="popup-youtube" href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img src="//img.youtube.com/vi/<?php echo $video; ?>/mqdefault.jpg" alt="" class="youtube-click">
                <svg viewBox="0 0 57 40" id="icon-youtube" xmlns="http://www.w3.org/2000/svg" width="30px" height="100%">
                  <path fill= "#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path>
                  <path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path></svg>
              </a></div>
            <?php } ?>
          </div>
          <?php } ?>
          <?php } ?>
        </div>
        <?php } ?>
        <div class="review-container-footer testimonial__bottom-box">
          <div class="review-date testimonial__data"><?php echo $review['date_added']; ?></div>
          <?php if($extended_reviews['answer']){ ?>
          <button type="button" class="btn btn-light fl-l review-answer-button" data-value="<?php echo $review['review_id'] ?>"><i class="fa fa-share mr"></i> <?php echo $text_reply; ?></button>
          <?php } ?>
          <div class="review_note" id="review-note-<?php echo $review['review_id'] ?>"></div>
        </div>
        <div class="review-answer-container" id="review_answer_container<?php echo $review['review_id'] ?>"></div>

        <?php if(!empty($review['admin_reply']) || !empty($review['children_reviews'])){ ?>
        <div class="review-childrens-container">
          <?php if(!empty($review['admin_reply'])){ ?>
          <div class="review-answer-title-container">
            <div class="review-author"><span class="review-author-name review-admin-name"><?php echo $review['admin_name']; ?></span><span class = "verification-check" data-toggle="tooltip" data-original-title="<?php echo $text_admin_answer; ?>"><i class="fa fa-check" aria-hidden="true"></i></span></div>
          </div>
          <div class="review-text-container">
            <div class="co-sm-12 comment-text">
              <p><?php echo $review['admin_reply']; ?></p>
            </div>
          </div>
          <?php } ?>
          <?php if(!empty($review['children_reviews'])){ ?>
          <?php foreach($review['children_reviews'] as $children_review){ ?>
          <div class="review-answer-title-container">
            <div class="review-author"><span class="review-author-name"><?php echo $children_review['author']; ?></span></div>
            <div class="review-date"><?php echo $children_review['date_added']; ?></div>
          </div>
          <div class="review-text-container">
            <div class="co-sm-12 comment-text">
              <p><?php echo $children_review['text']; ?></p>
            </div>
          </div>
          <?php } ?>
          <?php } ?>
        </div>
      </li>
      <?php }?>
    </ul>
  </div>
  <?php } ?>
  <div class="text-right"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <p><?php echo $text_no_reviews; ?></p>
  <?php } ?>
</div>

<!-- review-written-block -->

<form class="form-horizontal" id="form-answer-review">
  <div class="user-review-write-block testimonial__new-hide">
    <div class="wrap__title-box">
      <h2 class="wrap__title"><?php echo $leave_feedback; ?></h2>
    </div>
    <div class="testimonial-new__box">
      <img class="testimonial-new__avatar" src="catalog/view/theme/default/img/avatar-1.png" alt="avatar image">
      <div class="testimonial-new__description">
        <div class="testimonial-new__header">
          <img class="testimonial-new__avatar-mob" src="catalog/view/theme/default/img/avatar-1.png" alt="avatar image">
          <span>Ваша оценка</span>
          <div class="form-group required">
            <div class="testimonial-new__rating pointer__rating add-review-star-wrap" id="super-stars">
              <div class='star-block' value='1'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_bad; ?></span></div>
              <div class='star-block' value='2'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_soso; ?></span></div>
              <div class='star-block' value='3'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_normal; ?></span></div>
              <div class='star-block' value='4'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_good; ?></span></div>
              <div class='star-block' value='5'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_excellent; ?></span></div>
            </div>
            <input type="hidden" value="3" id="rating" name="rating">
          </div>
        </div>
        <div class="form-group required">
          <div class="col-sm-12">
            <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
            <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-answer-name" class="form-control" />
          </div>
        </div>
        <div class="testimonial-new__massage-box">
          <div class="required">
            <!--<label class="control-label" for="input-review"><?php echo $entry_review; ?></label>-->
            <textarea name="text" rows="5" id="input-answer-review" class="form-control testimonial-new__massage" placeholder="<?php echo $text_write; ?>"></textarea>
          </div>
        </div>
      </div>
    </div>
    <div class="review-form-write-footer">
      <?php if ($review_guest) { ?>
      <button type="button" class="btn btn-blue testimonial-new__btn button-answer-review" id="button-review-extended" data-loading-text="<?php echo $text_loading; ?>"><?php echo $leave_feedback; ?></button>
      <?php } else { ?>
      <div class="review-alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $text_login; ?></div>
      <?php }?>
    </div>
  </div>
  <input type="button" class="testimonial-new__btn" value="Оставить отзыв" data-submit="Отправить" id="show_testim_review_send">
</form>


<script>
  var product_id = <?php echo $product_id; ?>;
  var inputImageId = $("#input-image-id");
  var inputVideos = $("#input-video-links");
  var photoTab = $('.photo-tab');
  var tabPhoto = $('#tab-add-photo');
  var videoTab = $('.video-tab');
  var tabVideo = $('#tab-add-video');
  var images_id = [];
  var count = 0;
  <?php if($extended_reviews['photo_status']){ ?>
    Dropzone.autoDiscover = false;
    var myDropzone = new Dropzone("div#review-image", {
      url:"index.php?route=product/extended_reviews/check",
      maxFiles: <?php echo $extended_reviews['image_max_count']; ?>,
    maxFilesize: <?php echo $extended_reviews['image_max_size']; ?>,
    dictInvalidFileType: '<?php echo $error_invalid_type; ?>',
            dictFileTooBig: '<?php echo $error_too_big; ?>',
            dictRemoveFile: '<?php echo $text_remove; ?>',
            dictDefaultMessage: '<?php echo $text_loading; ?>',
            dictMaxFilesExceeded: '<?php echo $error_max_files; ?>',
            addRemoveLinks: true,
            timeout: 180000,
  <?php if($extended_reviews['image_width'] != 0 || $extended_reviews['image_height'] != 0){ ?>
      resizeWidth: <?php echo $extended_reviews['image_width']; ?>,
      resizeHeight: <?php echo $extended_reviews['image_height']; ?>,
      resizeMethod: 'contain',
              resizeQuality: 1.0,
    <?php }?>
    parallelUploads: 1,
            init: function(){
      $(this.element).html(this.options.dictDefaultMessage);
    },
    dictDefaultMessage: '<?php echo $dropzone_default_message; ?>',
            acceptedFiles:'.jpg, .jpeg, .png',
            error: function(file, errorMessage){
      $('.alert-success, .alert-danger').remove();
      $('.popup-footer').append('<div class="review-alert alert-danger" style="margin: 0 20%"><i class="fa fa-exclamation-circle"></i> '+ errorMessage +'</div>');
      myDropzone.removeFile(file);
    },
    success: function(file, responce){
      console.log(responce);
      if(responce.error){
        this.options.error(file, responce.error);
      }
      else{
        $('.alert-success, .alert-danger').remove();
        var btndelete = file.previewElement.querySelector(".dz-remove");
        btndelete.setAttribute("id", 'delete-midia-id-'+ responce.image_id);
        btndelete.setAttribute("num", count);
        images_id.push(responce.image_id);
        count++;
        this.defaultOptions.success(file);
      }

    },
    params: {'product-id':product_id}
            });

    myDropzone.on("removedfile", function (file) {
      var btndelete = file.previewElement.querySelector(".dz-remove");
      if(btndelete.hasAttribute("id")) {
        var iddelete = btndelete.getAttribute("id").split('-').pop();
        var countdelete = btndelete.getAttribute("num");
        $.ajax({
          url: 'index.php?route=product/extended_reviews/deleteImage',
          type: 'post',
          data: { image_id : iddelete } ,
          dataType: 'json',
          success: function(json) {
            images_id[countdelete] = null;
          }
        });
      }
    });
  <?php }?>
  $('#upload-files-button').on('click', function(){
    $.magnificPopup.close();
    $(photoTab).removeClass('active');
    $(tabPhoto).removeClass('active');
    $(videoTab).removeClass('active');
    $(tabVideo).removeClass('active');
    $('.images-user-content-block').append($('.dz-preview'));
    $('.images-user-content-block').append($('.vd-prev'));
    $('#review-image').removeClass('dz-started');
    if(! $(video_thumb_block).children('.vd-prev').length > 0) $('#video-caption').css('display', 'block');
  });
  $('#upload-files-cancel').on('click', function(){
    var delButtons = $('#review-image .dz-preview .dz-remove , #video-thumb-preview .vd-prev .remove_video');
    for(var i=0; i< delButtons.length; i++){
      delButtons[i].click();
    }
    $.magnificPopup.close();
    $(photoTab).removeClass('active');
    $(tabPhoto).removeClass('active');
    $(videoTab).removeClass('active');
    $(tabVideo).removeClass('active');
    $('#review-image').removeClass('dz-started');
  });
  var review_id;
  var note_block;
  var form = $('#form-answer-review');
  $(document).on('click','.review-answer-button',function(){
    review_id = $(this).data("value");
    var block = $('#review_answer_container'+review_id);
    note_block = $("#review-note-"+review_id);
  <?php if($answer_guest){ ?>
      if(!$(block).children(form).length > 0){
        $(form).hide().appendTo(block).slideDown(300);
      }
    <?php }else{ ?>
      $('.alert-success, .alert-danger').remove();
      $(note_block).append('<div class="review-alert alert-danger m-0"><i class="fa fa-exclamation-circle"></i> <?php echo $text_login; ?></div>');
    <?php } ?>
  });

  $('#review-cancel-button').on('click', function(){
    var block = $('#hidden-popups');
    $(form).slideUp(200).delay(300).queue(function (next) {
      $(this).appendTo(block);
      next();
    });
    $('.alert-success, .alert-danger').remove();
  });

  $('.button-answer-review').on('click',function(){
    var form = $('#form-answer-review');
    var btn = $(this);
    btn.button('loading');
    $.ajax({
      url: 'index.php?route=product/extended_reviews/writeAnswer&product-id=' + product_id + '&parent_id=' + review_id,
      type: 'post',
      dataType: 'json',
      data: $(form).serialize(),
      success: function(json) {
        $('.review-container-footer .review-alert').remove();
        if (json['error']) {
          $(note_block).append('<div class="review-alert alert-danger m-0"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
          btn.button('reset');
        }

        if (json['success']) {
          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          $('textarea[name=\'rating\']').val('3');
          $('#review-cancel-button').click();
          $(note_block).append('<div class="review-alert alert-success m-0"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
          btn.button('reset');
        }
      }
    });
//  grecaptcha.reset();
  });

  $('.review-vote-negative').on('click', function() {
    $('.review-container-footer .review-alert').remove();
    var id = $(this).data("value");
    var votename = "vote"+id;
    var note_block = $("#review-note-"+id);
  <?php if($likes_guest){ ?>
      if(localStorage.getItem(votename) == null){
        var vote_count_span = $('#vote_count_negative-'+id);
        var vote_count = parseInt(vote_count_span.data("value"));
        $.ajax({
          url: 'index.php?route=product/extended_reviews/minusReviewRating',
          type: 'post',
          data: { review_id : id } ,
          dataType: 'json',
          success: function(json) {
            if (json['success']) {
              $(vote_count_span).text(vote_count + 1);
              localStorage.setItem(votename , true);
            }
          }
        });
        $(note_block).append('<div class="review-alert alert-success m-0"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; <?php echo $thank_for_rating; ?></div>');
      }
      else{
        $(note_block).append('<div class="review-alert alert-warning m-0"><?php echo $already_rating; ?></div>');
      }
    <?php } else{ ?>
      $(note_block).append('<div class="review-alert alert-info m-0"><i class="fa fa-exclamation" aria-hidden="true"></i>&nbsp; <?php echo $text_login; ?></div>');
    <?php } ?>
  });
  $('.review-vote-positive').on('click', function() {
    $('.review-container-footer .review-alert').remove();
    var id = $(this).data("value");
    var votename = "vote"+id;
    var note_block = $("#review-note-"+id);
  <?php if($likes_guest){ ?>
      if(localStorage.getItem(votename) == null){
        var vote_count_span = $('#vote_count_positive-'+id);
        var vote_count = parseInt(vote_count_span.data("value"));
        $.ajax({
          url: 'index.php?route=product/extended_reviews/plusReviewRating',
          type: 'post',
          data: { review_id : id } ,
          dataType: 'json',
          success: function(json) {
            $('.success-note').remove();
            if (json['success']) {
              $(vote_count_span).text(vote_count + 1);
              localStorage.setItem(votename , true);
            }
          }
        });
        $(note_block).append('<div class="review-alert alert-success m-0"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; <?php echo $thank_for_rating; ?></div>');
      }
      else{
        $(note_block).append('<div class="review-alert alert-warning m-0"><?php echo $already_rating; ?></div>');
      }
    <?php } else{ ?>
      $(note_block).append('<div class="review-alert alert-info m-0"><i class="fa fa-exclamation" aria-hidden="true"></i>&nbsp; <?php echo $text_login; ?></div>');
    <?php } ?>
  });

  $('#super-stars > div').on('click', function(){
    $('#super-stars > div').removeClass('star-active');
    var id_val = $(this).index()+1;
    $('#super-stars > .star-block:nth-child(-n+' + id_val + ')').addClass('star-active');
    $('#rating').val(id_val);
  });

  $('.pagination li').on('click', function(){
    $('html,body').delay(100).animate({scrollTop: $('#input-sort').offset().top}, 300);
  });
</script>
<style>
  .ex-image-additional{
    height: <?php echo $extended_reviews['thumb_height']; ?>px;
    width: <?php echo $extended_reviews['thumb_width']; ?>px;
    border-radius: <?php echo $extended_reviews['border_radius_photo']; ?>px;
  }
  .ex-image-additional .image-crop{
    height: <?php echo $extended_reviews['thumb_height']*1.8; ?>px;
    width: <?php echo $extended_reviews['thumb_width']*1.8; ?>px;
  }
  .imgbb{
    height: <?php echo $extended_reviews['thumb_height']; ?>px;
    width: <?php echo $extended_reviews['thumb_width']; ?>px;
  }
  .videos-thumbnails img{
    height: <?php echo $extended_reviews['video_thumb_height']; ?>px;
    width: <?php echo $extended_reviews['video_thumb_width']; ?>px;
  }
  .videos-thumbnails a{
    height: <?php echo $extended_reviews['video_thumb_height']; ?>px;
    width: <?php echo $extended_reviews['video_thumb_width']; ?>px;
    border-radius: <?php echo $extended_reviews['border_radius_video']; ?>px;
  }
</style>
<script>
  $("#show_testim_review_send").on('click', function(){
    $('.testimonial__new-hide').show();
    $('#show_testim_review_send').hide();
  });
</script>
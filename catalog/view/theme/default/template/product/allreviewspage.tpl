<?php echo $header; ?>
<div class="container">
 <ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i+1<count($breadcrumbs)){ ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } else { ?>
				<li><?php echo $breadcrumb['text']; ?></li>
			<?php } ?>
		<?php } ?>
	</ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <?php if ($module_header) { ?>
      <h1 class="heading_title_reviews"><span><?php echo $module_header; ?></span></h1>
      <?php } ?>
      <?php if ($reviews) { ?>
      <div  id="review-extended">
        <?php foreach ($reviews as $review) { ?>
        <div class="review-list">
         <div class="review-thumb transition">
            <div class="image"><a href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" alt="<?php echo $review['prod_name']; ?>" title="<?php echo $review['prod_name']; ?>" class="img-responsive" /></a></div>
            <div class="caption" style="overflow:hidden">
              <div class="product-name"><h4><a href="<?php echo $review['prod_href']; ?>"><?php echo $review['prod_name']; ?></a></h4></div>
              <?php if ($review['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($review['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
              <p class="reviews-description"><?php echo $review['description']; ?></p><hr>
              <?php if($extended_reviews['limitations']){ ?>
              <?php if($review['plus']){ ?>
              <p></span><strong class='plus'><?php echo $text_plus; ?> </strong><span><?php echo $review['plus']; ?></p>
              <?php } ?>
              <?php if($review['minus']){ ?>
              <p></span><strong class='minus'><?php echo $text_minus; ?> </strong><span><?php echo $review['minus']; ?></p>
                <?php } ?>
              <?php } ?>

          <?php if(!empty($review['images'])){ ?>
              <div class="owl-carousel-photo thumbnails reviews-thumbnails">
            <?php foreach($review['images'] as $image){ ?>
                <div class="item image-thumbnails ex-image-additional"><a class="ex-thumbnail" href="<?php echo $image['popup']; ?>"> <img src="<?php echo $image['thumb']; ?>" class ="<?php echo $image['type'] == '0' ? 'image-crop' : 'imgbb' ?>" /></a></div>
              <?php } ?>
              </div>
          <?php } ?>

          <?php if(!empty($review['videos'])){ ?>
              <div class="owl-carousel-videos thumbnails">
            <?php foreach($review['videos'] as $video){ ?>
                <div class="item videos-thumbnails"><a class="popup-youtube" href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img src="//img.youtube.com/vi/<?php echo $video; ?>/mqdefault.jpg" alt="" class="youtube-click">
                  <svg viewBox="0 0 57 40" id="icon-youtube" xmlns="http://www.w3.org/2000/svg" width="30px" height="100%">
                    <path fill= "#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path>
                    <path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path></svg>
                </a></div>
          <?php } ?>
        </div>
          <?php } ?>
              <div class="reviews-sign">
                <div class="reviews-author">
				<i class="fa fa-user" aria-hidden="true"></i> <?php echo $review['author']; ?>
				<?php if($review['purchased']) {?><span class="purchased"><i class="fa fa-cart-plus" aria-hidden="true"></i> <?php echo $text_already_buy?></span><?php } ?>
				</div>
                <div class="reviews-date"><?php echo $review['date_added']; ?></div>
              </div>


              <div class="review-container-footer">
              <div class="review-rating-change-buttons">
              <span class="change-rating-button br-r">
                <a class="review-vote-positive" data-value="<?php echo $review['review_id'] ?>"><i class="fa fa-thumbs-o-up fa-custom-lg" aria-hidden="true"></i></a>
                <span class="review-vote-count" data-value="<?php echo $review['likes']; ?>" id="vote_count_positive-<?php echo $review['review_id'] ?>"><?php if($review['likes']>0) echo $review['likes']; ?></span>
              </span>
              <span class="change-rating-button">
                <a class="review-vote-negative" data-value="<?php echo $review['review_id'] ?>"><i class="fa fa-thumbs-o-down fa-custom-lg" aria-hidden="true"></i></a>
                <span class="review-vote-count" data-value="<?php echo $review['dislikes']; ?>" id="vote_count_negative-<?php echo $review['review_id'] ?>"><?php if($review['dislikes']>0) echo $review['dislikes']; ?></span>
              </span>
              </div>
              <?php if($extended_reviews['answer']){ ?>
              <button type="button" class="btn btn-light fl-l review-answer-button" data-value="<?php echo $review['review_id'] ?>" data-product="<?php echo $review['product_id'];?>"><i class="fa fa-share mr"></i> <?php echo $text_reply; ?></button>
              <?php } ?>
              <div class="review_note" id="review-note-<?php echo $review['review_id'] ?>"></div>
              </div>
              <div class="review-answer-container" id="review_answer_container<?php echo $review['review_id'] ?>"></div>
              <?php if(!empty($review['admin_reply']) || !empty($review['children_reviews'])){ ?>
              <div class="review-childrens-container">
              <?php if(!empty($review['admin_reply'])){ ?>
              <div class="review-answer-title-container">
                <div class="review-author"><span class="review-author-name"><?php echo $review['admin_name']; ?></span><span class = "verification-check" data-toggle="tooltip" data-original-title="<?php echo $text_admin_answer; ?>"><i class="fa fa-check" aria-hidden="true"></i></span></div>
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
              <?php }?>
            </div>
          </div>
        </div>
        <?php } ?>
        <!-- media-add-popup -->
          <div class="hidden" id="hidden-popups">
            <form class="form-horizontal" id="form-answer-review">
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-review"><?php echo $text_comment; ?></label>
                  <textarea name="text" rows="5" id="input-answer-review" class="form-control"></textarea>
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                  <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-answer-name" class="form-control" />
                </div>
              </div>
              <?php echo $captcha; ?>
              <button type="button" class="btn btn-blue fl-r button-answer-review"  data-loading-text="<?php echo $text_loading; ?>"><?php echo $leave_feedback; ?></button>
              <button type="button" class="btn btn-cancel fl-l" id="review-cancel-button"><?php echo $text_cancel; ?></button>
            </form>
          </div>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>


      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script>

$(document).ready(function() {
  <?php if($extended_reviews['all_owl_photo_status']){?>
  $('.owl-carousel-photo').owlCarousel({
    loop:true,
    margin:10,
    responsiveClass:true,
    items : <?php echo $extended_reviews['all_photo_carousel_1200']; ?>,
    pagination: true,
    navigation: true,
    navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
    itemsCustom : [
                  [0, <?php echo $extended_reviews['all_photo_carousel_340']; ?>],
                  [340, <?php echo $extended_reviews['all_photo_carousel_480']; ?>],
                  [480, <?php echo $extended_reviews['all_photo_carousel_768']; ?>],
                  [768, <?php echo $extended_reviews['all_photo_carousel_1199']; ?>],
                  [1200, <?php echo $extended_reviews['all_photo_carousel_1200']; ?>],
                ],
  });
  <?php }?>
  <?php if($extended_reviews['all_owl_video_status']){?>
  $('.owl-carousel-videos').owlCarousel({
      loop:true,
      margin:10,
      responsiveClass:true,
      pagination: true,
      items : <?php echo $extended_reviews['all_video_carousel_1200']; ?>,
      navigation: true,
      navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
      itemsCustom : [
                    [0, <?php echo $extended_reviews['all_video_carousel_340']; ?>],
                    [340, <?php echo $extended_reviews['all_video_carousel_480']; ?>],
                    [480, <?php echo $extended_reviews['all_video_carousel_768']; ?>],
                    [768, <?php echo $extended_reviews['all_video_carousel_1199']; ?>],
                    [1200, <?php echo $extended_reviews['all_video_carousel_1200']; ?>],
                  ],
  });
  <?php }?>
$('.image-thumbnails').magnificPopup({
  type:'image',
  delegate: 'a',
  gallery: {
    enabled:true,
  },
  callbacks: {
  open: function() {
  $('.container').addClass('blur');
  },
  close: function() {
  $('.container').removeClass('blur');
  }
  }
});
$('.popup-youtube, .popup-video, .popup-gmaps').magnificPopup({
    type: 'iframe',
    mainClass: 'mfp-fade',
    preloader: true,
    callbacks: {
    open: function() {
    $('.container').addClass('blur');
    },
    close: function() {
    $('.container').removeClass('blur');
    }
    }
});
});
var product_id;
var review_id;
var note_block;
var form = $('#form-answer-review');
$(document).on('click','.review-answer-button',function(){
  review_id = $(this).data("value");
  product_id = $(this).data("product");
  var block = $('#review_answer_container'+review_id);
  note_block = $("#review-note-"+review_id);
  <?php if($answer_guest){ ?>
    if(!$(block).children(form).length > 0){
  $(form).hide().appendTo(block).slideDown(300);
  }
  <?php }else{ ?>
    $('.alert-success, .alert-danger').remove();
    $(note_block).append('<div class="alert alert-danger m-0"><i class="fa fa-exclamation-circle"></i> <?php echo $text_login; ?></div>');
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
  $.ajax({
    url: 'index.php?route=product/extended_reviews/writeAnswer&product-id=' + product_id + '&parent_id=' + review_id,
    type: 'post',
    dataType: 'json',
    data: $(form).serialize(),
    success: function(json) {
      $('.review-container-footer .alert').remove();
      if (json['error']) {
        $(note_block).append('<div class="alert alert-danger m-0"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
      }

      if (json['success']) {
        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('#review-cancel-button').click();
        $(note_block).append('<div class="alert alert-success m-0"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
      }
    }
  });
});
$('.review-vote-negative').on('click', function() {
  $('.review-container-footer .alert').remove();
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
    $(note_block).append('<div class="alert alert-success m-0"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; <?php echo $thank_for_rating; ?></div>');
  }
  else{
    $(note_block).append('<div class="alert alert-warning m-0"><?php echo $already_rating; ?></div>');
  }
  <?php } else{ ?>
    $(note_block).append('<div class="alert alert-info m-0"><i class="fa fa-exclamation" aria-hidden="true"></i>&nbsp; <?php echo $text_login; ?></div>');
    <?php } ?>
});
$('.review-vote-positive').on('click', function() {
  $('.review-container-footer .alert').remove();
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
    $(note_block).append('<div class="alert alert-success m-0"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; <?php echo $thank_for_rating; ?></div>');
  }
  else{
      $(note_block).append('<div class="alert alert-warning m-0"><?php echo $already_rating; ?></div>');
  }
  <?php } else{ ?>
    $(note_block).append('<div class="alert alert-info m-0"><i class="fa fa-exclamation" aria-hidden="true"></i>&nbsp; <?php echo $text_login; ?></div>');
    <?php } ?>
});
</script>
<style>
.reviews-sign{
  overflow: hidden;
}
.ex-image-additional{
  height: <?php echo $extended_reviews['all_thumb_height']; ?>px;
  width: <?php echo $extended_reviews['all_thumb_width']; ?>px;
  border-radius: <?php echo $extended_reviews['all_border_radius_photo']; ?>px;
}
.ex-image-additional .image-crop{
  height: <?php echo $extended_reviews['all_thumb_height']*1.8; ?>px;
  width: <?php echo $extended_reviews['all_thumb_width']*1.8; ?>px;
}
.imgbb{
  height: <?php echo $extended_reviews['all_thumb_height']; ?>px;
  width: <?php echo $extended_reviews['all_thumb_width']; ?>px;
}
.videos-thumbnails img{
  height: <?php echo $extended_reviews['all_video_thumb_height']; ?>px;
  width: <?php echo $extended_reviews['all_video_thumb_width']; ?>px;
}
.videos-thumbnails a{
  height: <?php echo $extended_reviews['all_video_thumb_height']; ?>px;
  width: <?php echo $extended_reviews['all_video_thumb_width']; ?>px;
  border-radius: <?php echo $extended_reviews['all_border_radius_video']; ?>px;
}
</style>
<?php echo $footer; ?>

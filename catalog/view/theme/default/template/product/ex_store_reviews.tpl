<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
    <?php if($i+1<count($breadcrumbs)){ ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
    <?php } else { ?>
    <li><?php echo $module_header; ?></li>
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
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <?php if ($module_header) { ?>
      <h1><?php echo $module_header; ?></h1>
      <?php } ?>
      <?php if ($reviews) { ?>
      <div id="review-extended">
        <?php if($ex_store_reviews['all_media'] && (!empty($total_videos) || !empty($total_images))){ ?>
        <div class="review-media-all">
          <?php if(!empty($total_videos)){ ?>
          <p class="review-all-photo-title"><?php echo $customers_video; ?></p>
          <div class="owl-carousel-videos thumbnails">
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
        <div class="col-md-5 col-xs-12 fl-l pd-0">
          <div class="form-group input-group input-group-sm">
            <label class="input-group-addon" for="input-sort"><?php echo $sort_title; ?></label>
            <select id="input-sort" class="form-control" onchange="location = this.value;">
              <?php foreach ($sorts as $sorts) { ?>
              <?php if ($sorts['value'] == $sort) { ?>
              <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="col-md-5 col-xs-12 fl-r pd-0">
          <a class="btn btn-blue to-write-review" href="javascript:;" onclick="$('html,body').animate({scrollTop: $('#form-review').offset().top}, 500);"><i class="fa fa-pencil"></i> <?php echo $text_write; ?></a>
        </div>
        <?php foreach ($reviews as $review) { ?>
        <div class="review-container" <?php echo $ex_store_reviews['micro'] ? 'itemscope itemtype="http://schema.org/Review"' : '';?> >
        <?php if($ex_store_reviews['micro']){?>
        <meta itemprop="name" content="<?php echo $ex_store_reviews['company_name']; ?>">
        <meta itemprop="datePublished" content="<?php echo $review['date_added']; ?>">
        <meta itemprop="url" content="<?php echo $module_url; ?>">

        <div itemprop="itemReviewed" itemscope itemtype="https://schema.org/Organization">
        <meta itemprop="name" content="<?php echo $ex_store_reviews['company_name']; ?>"/>
        <meta itemprop="address" content="<?php echo $ex_store_reviews['company_address']; ?>"/>
        <meta itemprop="telephone" content="<?php echo $ex_store_reviews['company_phone']; ?>" />
        </div>

        <div itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
        <meta itemprop="worstRating" content = "1">
        <meta itemprop="ratingValue" content = "<?php echo $review['rating']; ?>">
        <meta itemprop="bestRating" content = "5">
        </div>
        <?php }?>
        <div class="review-title-container">
          <div class="review-author"  <?php echo $ex_store_reviews['micro'] ? 'itemprop="author" itemscope itemtype="http://schema.org/Person"' : '';?>>
          <span class="review-author-name" <?php echo $ex_store_reviews['micro'] ? 'itemprop="name"' : '';?>><?php echo $review['author']; ?></span>
        </div>
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
        <div class="review-date"><?php echo $review['date_added']; ?></div>
      </div>
      <div class="review-text-container">
        <div class="co-sm-12 comment-text" <?php echo $ex_store_reviews['micro'] ? 'itemprop="reviewBody"' : '';?>>
        <p><?php echo $review['text']; ?></p><hr>
        <?php if($ex_store_reviews['limitations']){ ?>
        <?php if($review['plus']){ ?>
        <p></span><strong class='plus'><?php echo $text_plus; ?> </strong><span><?php echo $review['plus']; ?></p>
        <?php } ?>
        <?php if($review['minus']){ ?>
        <p></span><strong class='minus'><?php echo $text_minus; ?> </strong><span><?php echo $review['minus']; ?></p>
        <?php } ?>
        <?php } ?>
      </div>
    </div>
    <?php if($ex_store_reviews['photo_status'] || $ex_store_reviews['video_status']){ ?>
    <div class="review-media-container">
      <?php if($ex_store_reviews['photo_status']){ ?>
      <?php if(!empty($review['images'])){ ?>
      <div class="owl-carousel-photo reviews-thumbnails">
        <?php foreach($review['images'] as $image){ ?>
        <div class="item image-thumbnails ex-image-additional"><a class="ex-thumbnail" href="<?php echo $image['popup']; ?>"> <img src="<?php echo $image['thumb']; ?>"  class = "<?php echo $image['type'] == '0' ? 'image-crop' : 'imgbb' ?>" /></a></div>
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
      <?php if($ex_store_reviews['video_status']){ ?>
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
      <?php } ?>
    </div>
    <?php } ?>
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
      <?php if($ex_store_reviews['answer']){ ?>
      <button type="button" class="btn btn-light fl-l review-answer-button" data-value="<?php echo $review['review_id'] ?>"><i class="fa fa-share mr"></i> <?php echo $text_reply; ?></button>
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
  <?php } ?>
  <div class="text-right"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <p><?php echo $text_empty; ?></p>
  <?php } ?>



  <!-- review-written-block -->

  <form class="form-horizontal" id="form-review">
    <div class="user-review-write-block">
      <h2><?php echo $text_write; ?></h2>
      <div class="form-group required">
        <div class="add-review-star-wrap" id='super-stars'>
          <div class='star-block' value='1'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_bad; ?></span></div>
          <div class='star-block' value='2'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_soso; ?></span></div>
          <div class='star-block' value='3'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_normal; ?></span></div>
          <div class='star-block' value='4'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_good; ?></span></div>
          <div class='star-block' value='5'><i class="fa fa-star star-gray star-3x"></i><span class='super-star-text'><?php echo $entry_excellent; ?></span></div>
        </div>
        <input type="hidden" value="0" id="rating" name="rating">
      </div>
      <div style="display:<?php echo !empty($ex_store_reviews['limitations']) && $ex_store_reviews['limitations'] ? 'block' : 'none'; ?>">
        <div class="form-group required">
          <div class="col-sm-12">
            <label for="input-text-plus"><?php echo $text_plus; ?></label>
            <input type="text" name="plus"  id="input-text-plus" class="form-control" />
          </div>
        </div>
        <div class="form-group required">
          <div class="col-sm-12">
            <label for="input-text-plus"><?php echo $text_minus; ?></label>
            <input type="text" name="minus"  id="input-text-minus" class="form-control" />
          </div>
        </div>
      </div>
      <div class="form-group required">
        <div class="col-sm-12">
          <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
          <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
        </div>
      </div>
      <div class ="images-user-content-block">
      </div>
      <?php if($ex_store_reviews['photo_status'] || $ex_store_reviews['video_status']){ ?>
      <div class ="reviews-user-add-content-block">
        <?php if($ex_store_reviews['photo_status']){ ?>
        <div class="review-media-add-block">
    <span class="btn-link-review"><a class="btn-link-i" id="add-photo" href="#media-content-popup">
    <svg class="media-add-button-icon">
      <svg viewBox="0 0 38 34"  xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M27.994 32H4a4 4 0 0 1-4-4V4.008a4 4 0 0 1 4-4h23.992a4 4 0 0 1 4 4V28a4 4 0 0 1-3.998 4zm2.865-27.99a2.869 2.869 0 0 0-2.865-2.865H4A2.869 2.869 0 0 0 1.135 4.01V28A2.869 2.869 0 0 0 4 30.866h23.992A2.869 2.869 0 0 0 30.859 28V4.008v.002z"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M17 20l-5-5-7 7v-2l7-7 5 5 4-4 7 7v2l-7-7-4 4z"></path>
        <path d="M30.5 34a7.5 7.5 0 1 0 0-15 7.5 7.5 0 0 0 0 15z"></path>
        <path d="M30.5 23a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0v-6a.5.5 0 0 1 .5-.5z" fill="#fff"></path>
        <path d="M27.5 26h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1 0-1z" fill="#fff"></path>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M21.5 12a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0-4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3z"></path>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M4 4h24v20H4V4zm1 1h22v18H5V5z"></path></svg>
    </svg>
    <span class="btn-link-text"><?php echo $text_add_photo; ?></span>
  </a></span>
        </div>
        <?php } ?>
        <?php if($ex_store_reviews['video_status']){ ?>
        <div class="review-media-add-block">
    <span class="btn-link-review"><a class="btn-link-i" id="add-video" href="#media-content-popup">
    <svg class="media-add-button-icon">
    <svg viewBox="0 0 38 34" xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M27.994 32H4a4 4 0 0 1-4-4V4.01a4 4 0 0 1 4-4h23.992a4 4 0 0 1 4 4V28a4 4 0 0 1-3.998 4zm2.865-27.99a2.869 2.869 0 0 0-2.865-2.867H4A2.869 2.869 0 0 0 1.135 4.01V28A2.873 2.873 0 0 0 4 30.87h23.992A2.873 2.873 0 0 0 30.857 28V4.01h.002zM24.02 26.7a64.388 64.388 0 0 1-7.958.3c-2.375 0-5.978-.06-7.362-.18-2.7-.24-2.462-3.57-2.581-6.35.001-1.427.122-2.852.36-4.26.541-2.32 2.042-2.02 4.206-2.14.23 0 1.92-.06 5.285-.06 4.983.06 6.546 0 7.926.24 2.1.3 1.925 3.63 2.044 6.19-.063 3.02-.076 4.43-.779 5.37-.276.41-.676.722-1.141.89zM11.945 15.98H7.98v1.25H9.3v7.21h1.266v-7.21h1.379c.03-.416.03-.833 0-1.25zm3.544 2.2h-1.142v4.77c-.144.28-.41.476-.719.53a.255.255 0 0 1-.3-.23v-5.07h-1.141v5.19c0 .77.243 1.19.9 1.19.504-.09.954-.369 1.26-.78v.72h1.142v-6.32zm4.387 1.01a1.052 1.052 0 0 0-1.082-1.13 2.03 2.03 0 0 0-1.142.72v-2.75h-1.141v8.47h1.141v-.66c.319.447.831.715 1.38.72.72 0 .844-1.19.844-1.19v-4.18zm4.382 3.1h-1.141v.48s0 .71-.482.71a.636.636 0 0 1-.66-.71v-1.25h2.283v-1.73a1.573 1.573 0 0 0-1.623-1.67c-1.439 0-1.558.72-1.682 1.07a2.456 2.456 0 0 0-.119.6v2.98a1.73 1.73 0 0 0 1.861 1.79 1.68 1.68 0 0 0 1.5-1.19 3.61 3.61 0 0 0 .063-1.08zm-3.92-10.61c-.318.392-.76.664-1.252.77a.826.826 0 0 1-.894-.94V6.128h1.132v5.023s-.059.3.358.3a1.05 1.05 0 0 0 .656-.54V6.128h1.131v6.263h-1.131v-.71zm-4.521.75a3.267 3.267 0 0 1-.438.01 1.536 1.536 0 0 1-1.179-.7 2.06 2.06 0 0 1-.3-.94V7.842c0-.178.059-.59.059-.59a1.65 1.65 0 0 1 1.34-1.154 1.63 1.63 0 0 1 .526 0c.637.09 1.165.54 1.352 1.156 0 0 .059.413.059.591v2.958a2.063 2.063 0 0 1-.3.94c-.249.388-.66.64-1.119.688zm-.246-5.357s-.6-.06-.6.77V10.8a.56.56 0 0 0 .6.65.526.526 0 0 0 .536-.65V7.842s.06-.769-.536-.769zm-3.277 5.258H11.1V8.96L9.494 4h1.311l.893 3.251L12.591 4h1.252l-1.549 4.961v3.37zm10.823 7.46a.685.685 0 0 0-.541-.66.672.672 0 0 0-.6.66v.77h1.142v-.77h-.001zm-4.864-.66a.863.863 0 0 0-.541.24v3.88a.76.76 0 0 0 .541.23.506.506 0 0 0 .481-.53v-3.16a.54.54 0 0 0-.481-.66z"></path>
      <path d="M30.5 34a7.5 7.5 0 1 0 0-15 7.5 7.5 0 0 0 0 15z"></path>
      <path d="M30.5 23a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0v-6a.5.5 0 0 1 .5-.5z" fill="#fff"></path>
      <path d="M27.5 26h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1 0-1z" fill="#fff"></path></svg>
    </svg>
    <span class="btn-link-text"><?php echo $text_add_video; ?></span>
  </a></span>
        </div>
        <?php } ?>
        <div class="review-media-text-block">
          <svg class="user-content-add-caption-arrow">
            <svg overflow="scroll" viewBox="0 0 47 22" id="arrow-left-soft" xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
              <g fill="none"><path d="M0 0h47v22H0z"></path>
                <path fill="#a6a5a5" d="M46.585 2.753c-3.199 2.8-17.394 7.7-25.49 7.7-8.598 0-8.298-2.3-8.298-2.3.1-1.7 5.198-.3 9.397-.5 8.097-.6 16.094-2.4 23.791-5.4.3-.1 1.7-.5.6.5zm-33.888.4s-9.796 3.5-9.796 5.2S17.595 19.85 17.595 19.85s2.3 1.8 1 2.1-3.299-.8-4.898-2.1S.202 11.052.002 8.353 14.697-.646 17.595.053s-4.898 3.1-4.898 3.1z"></path>
              </g></svg>
          </svg>
          <?php echo $text_add_media_note; ?>
        </div>
      </div>
      <?php } ?>
      <div class="form-group required">
        <div class="col-sm-12">
          <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
          <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
        </div>
      </div>
      <?php echo $captcha; ?>
      <input type="hidden" name="image_id"  id="input-image-id" class="form-control" />
      <input type="hidden" name="video_links"  id="input-video-links" class="form-control" />
      <div class="buttons clearfix review-form-write-footer">
        <?php if ($review_guest) { ?>
        <div class="pull-right">
          <button type="button" id="button-review-extended" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-blue"><?php echo $leave_feedback; ?></button>
        </div>
        <?php } else { ?>
        <div class="alert alert-info"><i class="fa fa-exclamation-circle"></i> <?php echo $text_login; ?></div>
        <?php }?>
      </div>
    </div>
  </form>
  <!-- media-add-popup -->
  <div class="hidden" id="hidden-popups">
    <div id="media-content-popup" class="popup-media-container">
      <div class="popup-header">
        <ul class="nav nav-tabs">
          <?php if($ex_store_reviews['photo_status']){ ?><li class="popup-media-nav-tabs photo-tab"><a class="nav-tabs-link" href="#tab-add-photo" data-toggle="tab" aria-expanded="true"><?php echo $text_add_photo;?></a></li><?php }?>
          <?php if($ex_store_reviews['video_status']){ ?><li class="popup-media-nav-tabs video-tab"><a class="nav-tabs-link" href="#tab-add-video" data-toggle="tab" aria-expanded="true"><?php echo $text_add_video;?></a></li><?php }?>
        </ul>
      </div>
      <div class="tab-content tab-content-media">
        <?php if($ex_store_reviews['photo_status']){ ?>
        <div class="tab-pane" id="tab-add-photo">
          <div id="review-image" class="dropzone"></div>
        </div>
        <?php }?>
        <?php if($ex_store_reviews['video_status']){ ?>
        <div class="tab-pane" id="tab-add-video">
          <div class="form-group required ov-h">
            <div class="col-sm-12">
              <label for="input-text-plus"><?php echo $youtube_link; ?></label>
              <div class="input-group">
                <input type="text" name="video-href"  id="input-video-href" class="form-control" />
                <span class="input-group-btn"> <button class="btn btn-default" id="add-video-button" type="button"><?php echo $button_add_video_text; ?></button></span>
              </div>
            </div>
          </div>
          <div id = 'video-thumb-preview'>
            <div id='video-caption'><?php echo $add_video_note; ?></div>
          </div>
        </div>
        <?php }?>
      </div>
      <div class="popup-footer ov-h">
        <button class="btn btn-green fl-r" id="upload-files-button"><?php echo $text_load; ?></button>
        <button class="btn btn-cancel fl-l" id="upload-files-cancel"><?php echo $text_cancel; ?></button>
      </div>
    </div>

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
      <button type="button" class="btn btn-cancel fl-l" id="review-cancel-button"><?php echo $text_cancel; ?></button>
      <button type="button" class="btn btn-blue fl-r button-answer-review"  data-loading-text="<?php echo $text_loading; ?>"><?php echo $leave_feedback; ?></button>
    </form>
  </div>
</div>


<?php echo $content_bottom; ?></div>
<?php echo $column_right; ?></div>
</div>

<?php echo $footer; ?>

<script>
  var inputImageId = $("#input-image-id");
  var inputVideos = $("#input-video-links");
  var photoTab = $('.photo-tab');
  var tabPhoto = $('#tab-add-photo');
  var videoTab = $('.video-tab');
  var tabVideo = $('#tab-add-video');
  var images_id = [];
  var count = 0;
  <?php if($ex_store_reviews['photo_status']){ ?>
    Dropzone.autoDiscover = false;
    var myDropzone = new Dropzone("div#review-image", {
      url:"index.php?route=product/ex_store_reviews/check",
      maxFiles: <?php echo $ex_store_reviews['image_max_count']; ?>,
    maxFilesize: <?php echo $ex_store_reviews['image_max_size']; ?>,
    dictInvalidFileType: '<?php echo $error_invalid_type; ?>',
            dictFileTooBig: '<?php echo $error_too_big; ?>',
            dictRemoveFile: '<?php echo $text_remove; ?>',
            dictDefaultMessage: '<?php echo $text_loading; ?>',
            dictMaxFilesExceeded: '<?php echo $error_max_files; ?>',
            addRemoveLinks: true,
  <?php if($ex_store_reviews['image_width'] != 0 || $ex_store_reviews['image_height'] != 0){ ?>
      resizeWidth: <?php echo $ex_store_reviews['image_width']; ?>,
      resizeHeight: <?php echo $ex_store_reviews['image_height']; ?>,
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
      $('.popup-footer').append('<div class="alert alert-danger" style="margin: 0 20%"><i class="fa fa-exclamation-circle"></i> '+ errorMessage +'</div>');
      myDropzone.removeFile(file);
    },
    success: function(file, responce){
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
    }
  });

    myDropzone.on("removedfile", function (file) {
      var btndelete = file.previewElement.querySelector(".dz-remove");
      if(btndelete.hasAttribute("id")) {
        var iddelete = btndelete.getAttribute("id").split('-').pop();
        var countdelete = btndelete.getAttribute("num");
        $.ajax({
          url: 'index.php?route=product/ex_store_reviews/deleteImage',
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
  $(document).ready(function() {
    $('.owl-carousel-photo').owlCarousel({
      loop:true,
      margin:10,
      responsiveClass:true,
      items : <?php echo $ex_store_reviews['photo_carousel_1200']; ?>,
    pagination: true,
            navigation: true,
            navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
            itemsCustom : [
      [0, <?php echo $ex_store_reviews['photo_carousel_340']; ?>],
    [340, <?php echo $ex_store_reviews['photo_carousel_480']; ?>],
    [480, <?php echo $ex_store_reviews['photo_carousel_768']; ?>],
    [768, <?php echo $ex_store_reviews['photo_carousel_1199']; ?>],
    [1200, <?php echo $ex_store_reviews['photo_carousel_1200']; ?>],
  ],
  });
    $('.owl-carousel-videos').owlCarousel({
      loop:true,
      margin:10,
      responsiveClass:true,
      pagination: true,
      navigation: true,
      items : <?php echo $ex_store_reviews['video_carousel_1200']; ?>,
    navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
            itemsCustom : [
      [0, <?php echo $ex_store_reviews['video_carousel_340']; ?>],
    [340, <?php echo $ex_store_reviews['video_carousel_480']; ?>],
    [480, <?php echo $ex_store_reviews['video_carousel_768']; ?>],
    [768, <?php echo $ex_store_reviews['video_carousel_1199']; ?>],
    [1200, <?php echo $ex_store_reviews['video_carousel_1200']; ?>],
  ],
  });
    $('.reviews-thumbnails').magnificPopup({
      type:'image',
      delegate: 'a',
      gallery: {
        enabled:true,
      },
      callbacks: {
        beforeOpen: function() {
          var magnificPopup = $.magnificPopup.instance,
                  cur = magnificPopup.st.el.focus();
        },
        open: function() {
          $('.container').addClass('blur');
        },
        close: function() {
          $('.container').removeClass('blur');
        }
      }
    });

    $('.all-reviews-thumbnails').magnificPopup({
      type:'image',
      delegate: 'a',
      gallery: {
        enabled:true,
      },
      callbacks: {
        beforeOpen: function() {
          var magnificPopup = $.magnificPopup.instance,
                  cur = magnificPopup.st.el.focus();
        },
        open: function() {
          $('.container').addClass('blur');
        },
        close: function() {
          $('.container').removeClass('blur');
        }
      }
    });
    $('.popup-youtube, .popup-vimeo, .popup-gmaps').magnificPopup({
      type: 'iframe',
      mainClass: 'mfp-fade',
      preloader: true,
      callbacks: {
        beforeOpen: function() {
          var magnificPopup = $.magnificPopup.instance,
                  cur = magnificPopup.st.el.focus();
        },
        open: function() {
          $('.container').addClass('blur');
        },
        close: function() {
          $('.container').removeClass('blur');
        }
      }
    });
    $('#add-photo').magnificPopup({
      type: 'inline',
      closeOnBgClick: false,
      callbacks: {
        open: function() {
          $(photoTab).addClass('active');
          $(tabPhoto).addClass('active');
        },
        close: function() {
          $(photoTab).removeClass('active');
          $(tabPhoto).removeClass('active');
        }
      }
    });

    $('#add-video').magnificPopup({
      type: 'inline',
      closeOnBgClick: false,
      callbacks: {
        open: function() {
          $(videoTab).addClass('active');
          $(tabVideo).addClass('active');
        },
        close: function() {
          $(videoTab).removeClass('active');
          $(tabVideo).removeClass('active');
        }
      }
    });
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
    var btn = $(this);
    btn.button('loading');
    $.ajax({
      url: 'index.php?route=product/ex_store_reviews/writeAnswer&parent_id=' + review_id,
      type: 'post',
      dataType: 'json',
      data: $(form).serialize(),
      success: function(json) {
        $('.review-container-footer .alert').remove();
        if (json['error']) {
          $(note_block).append('<div class="alert alert-danger m-0"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
          btn.button('reset');
        }

        if (json['success']) {
          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          $('#review-cancel-button').click();
          $(note_block).append('<div class="alert alert-success m-0"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
          btn.button('reset');
        }
      }
    });
//  grecaptcha.reset();
  });

  $('#button-review-extended').on('click', function() {
    var strImages = '';
    var strVideos ='';
    var btn = $(this);
    btn.button('loading');
    if(images_id){
      for(var i=0; i<images_id.length; i++){
        if(images_id[i] != null)
          strImages+=images_id[i] + ' ';
      }
    }
    if(video_links){
      for(var i=0; i<video_links.length; i++){
        if(video_links[i] != null)
          strVideos+=video_links[i] + ' ';
      }
    }
    inputImageId.val(strImages.trim());
    inputVideos.val(strVideos.trim());
    $.ajax({
      url: 'index.php?route=product/ex_store_reviews/write',
      type: 'post',
      dataType: 'json',
      data: $("#form-review").serialize(),
      success: function(json) {
        $('.alert-success, .alert-danger').remove();
        if (json['error']) {
          $('.review-form-write-footer').append('<div class="alert alert-danger m-r-20"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
          btn.button('reset');
        }

        if (json['success']) {
          $('.review-form-write-footer').append('<div class="alert alert-success m-r-20"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
          $('input[name=\'plus\']').val('');
          $('input[name=\'minus\']').val('');
          $('textarea[name=\'text\']').val('');
          $('input[name=\'image_id\']').val('');
          $('input[name=\'rating\']').val('0');
          $('.star-block').removeClass('star-active');
          $('.images-user-content-block > div').remove();
          btn.button('reset');
          images_id = [];
          count = 0;
        }
      }
    });
    //grecaptcha.reset();
  });

  $('.review-vote-negative').on('click', function() {
    $('.review-container-footer .alert').remove();
    var id = $(this).data("value");
    var votename = "store-vote"+id;
    var note_block = $("#review-note-"+id);
  <?php if($likes_guest){ ?>
      if(localStorage.getItem(votename) == null){
        var vote_count_span = $('#vote_count_negative-'+id);
        var vote_count = parseInt(vote_count_span.data("value"));
        $.ajax({
          url: 'index.php?route=product/ex_store_reviews/minusReviewRating',
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
    var votename = "store-vote"+id;
    var note_block = $("#review-note-"+id);
  <?php if($likes_guest){ ?>
      if(localStorage.getItem(votename) == null){
        var vote_count_span = $('#vote_count_positive-'+id);
        var vote_count = parseInt(vote_count_span.data("value"));
        $.ajax({
          url: 'index.php?route=product/ex_store_reviews/plusReviewRating',
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
  $('#super-stars > div').on('click', function(){
    $('#super-stars > div').removeClass('star-active');
    var id_val = $(this).index()+1;
    $('#super-stars > .star-block:nth-child(-n+' + id_val + ')').addClass('star-active');
    $('#rating').val(id_val);
  });

  var api_key = 'AIzaSyBV0eSZxQOn3OEf0oRCIXeAF04y2T8-A60';
  var video_thumb_block = $('#video-thumb-preview');
  var video_links = [];
  var video_num = 0;
  var inputHref = $('#input-video-href');
  function youtube_parser(url){
    var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
    var match = url.match(regExp);
    return (match&&match[7].length==11)? match[7] : false;
  }
  $('#add-video-button').on('click', function(){
    var href = $(inputHref).val();
    var video_id = youtube_parser(href);
    if(video_id && !video_links.includes(video_id)){
      $.ajax({
        url: "https://www.googleapis.com/youtube/v3/videos?id=" + video_id + "&key="+ api_key + "&fields=items(snippet(title, thumbnails(default)))&part=snippet",
        dataType: "jsonp",
        success: function(data){
          var video_title = data.items[0].snippet.title;
          var video_thumbnail = data.items[0].snippet.thumbnails.default.url;
          video_links.push(video_id);
          video_thumb_block.append("<div class = 'vd-prev ov-h' data-id='"+video_num+"'><div class = 'vd-thumb-vrapper ov-h'><img src='"+video_thumbnail+"' title='"+video_title+"'></div><div class = 'vd-thumb-title-vrapper'><span class ='vd-thumb-title'>"+video_title+"</span></div><a class = 'remove_video'><i class='fa fa-times' aria-hidden='true'></i></a></div>");
          video_num++;
          $(inputHref).val('');
          $('#video-caption').css('display', 'none');
        },
        error: function(jqXHR, textStatus, errorThrown) {
          alert (textStatus, + ' | ' + errorThrown);
        }
      });

    }
  });
  $(document).on('click','.remove_video',function(){
    var id = $(this).parent().data('id');
    video_links[id] = null;
    $(this).parent().remove();
    if(! $(video_thumb_block).children('.vd-prev').length > 0) $('#video-caption').css('display', 'block');
  });
  $('.pagination li').on('click', function(){
    $('html,body').delay(100).animate({scrollTop: $('#input-sort').offset().top}, 300);
  });
</script>
<style>
  .ex-image-additional{
    height: <?php echo $ex_store_reviews['thumb_height']; ?>px;
    width: <?php echo $ex_store_reviews['thumb_width']; ?>px;
    border-radius: <?php echo $ex_store_reviews['border_radius_photo']; ?>px;
  }
  .ex-image-additional .image-crop{
    height: <?php echo $ex_store_reviews['thumb_height']*1.8; ?>px;
    width: <?php echo $ex_store_reviews['thumb_width']*1.8; ?>px;
  }
  .imgbb{
    height: <?php echo $ex_store_reviews['thumb_height']; ?>px;
    width: <?php echo $ex_store_reviews['thumb_width']; ?>px;
  }
  .videos-thumbnails img{
    height: <?php echo $ex_store_reviews['video_thumb_height']; ?>px;
    width: <?php echo $ex_store_reviews['video_thumb_width']; ?>px;
  }
  .videos-thumbnails a{
    height: <?php echo $ex_store_reviews['video_thumb_height']; ?>px;
    width: <?php echo $ex_store_reviews['video_thumb_width']; ?>px;
    border-radius: <?php echo $ex_store_reviews['border_radius_video']; ?>px;
  }
</style>

<div class="mod-rs-cont" id = "ex-store-reviews">
	<?php if ($module_header) { ?>
	<h3><?php echo $module_header; ?></h3>
	<?php } ?>
<div class="row rating-info-box">
	<div class="col-xs-12 col-md-12">
			<div class="well well-sm" id="ex-reviews">
			<div class="row">
				<div class="col-xs-12 col-md-3 text-center bottom-10 col-rl">
					<div <?php if($rating_store ==5){?>class="progress-striped-rev-full"<?php } ?>>
						<span class="rating-num
					<?php if(($rating_store >=1) && ($rating_store < 2)){?>
					rat-avg-1
					<?php } elseif(($rating_store >=2) && ($rating_store < 3)){ ?>
					rat-avg-2
					<?php } elseif(($rating_store >=3) && ($rating_store < 4)){ ?>
					rat-avg-3
					<?php } elseif(($rating_store >=4) && ($rating_store < 5)){ ?>
					rat-avg-4
					<?php } elseif($rating_store == 5){ ?>
					rat-avg-5
					<?php } ?>
					"><?php echo $rating_store;?></span>
					</div>
					<div class="store-rating-container">
			    <?php if ($rating_store != 0){ ?>
			    <?php for ($i = 1; $i <= 5; $i++) { ?>
			    <?php if ($rating_store < $i) { ?>
			    <span class="fa fa-stack"><i class="fa fa-star star-gray"></i></span>
			    <?php } else { ?>
			    <span class="fa fa-stack"><i class="fa fa-star"></i></span>
			    <?php } ?>
			    <?php } ?>
			    <?php } ?>
			    </div>
					<div class="rs-sum-total">
						<span class="glyphicon glyphicon-user"></span> Всего отзывов  <?php echo $total_reviews;?>
					</div>
					<div class="col-xs-12 col-md-12">
						<button type="button" onclick="window.location.href='<?php echo $write_review; ?>#form-review'" class="btn btn-blue"><i class="fa fa-pencil"></i> <?php echo $btn_write_review; ?></button>
					</div>
				</div>
				<div class="col-xs-12 col-md-4 bottom-10 col-rl">
					<div class="row rating-desc">

						<div class="col-xs-12 col-md-12">
							<span class = "progress-stars">
							<i class="fa fa-star color-star-percent-5"></i>5
							</span>
							<div class="progress progress-striped">
								<div class="progress-bar progress-bar-success color-5" role="progressbar" aria-valuenow="20"
									aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $percent_rating['star5'];?>%">
									<span class="sr-only"><?php echo $percent_rating['star5'];?>%</span>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-md-12">
							<span class = "progress-stars">
							<i class="fa fa-star color-star-percent-4"></i>4
							</span>
							<div class="progress">
								<div class="progress-bar progress-bar-success color-4" role="progressbar" aria-valuenow="20"
									aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $percent_rating['star4'];?>%">
									<span class="sr-only"><?php echo $percent_rating['star4'];?>%</span>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-md-12">
							<span class = "progress-stars">
							<i class="fa fa-star color-star-percent-3"></i>3
							</span>
							<div class="progress">
								<div class="progress-bar progress-bar-info color-3" role="progressbar" aria-valuenow="20"
									aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $percent_rating['star3'];?>%">
									<span class="sr-only"><?php echo $percent_rating['star3'];?>%</span>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-md-12">
							<span class = "progress-stars">
							<i class="fa fa-star color-star-percent-2"></i>2
							</span>
							<div class="progress">
								<div class="progress-bar progress-bar-warning color-2" role="progressbar" aria-valuenow="20"
									aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $percent_rating['star2'];?>%">
									<span class="sr-only"><?php echo $percent_rating['star2'];?>%</span>
								</div>
							</div>
						</div>
						<div class="col-xs-12 col-md-12">
							<span class = "progress-stars">
							<i class="fa fa-star color-star-percent-1"></i>1
							</span>
							<div class="progress">
								<div class="progress-bar progress-bar-danger color-1" role="progressbar" aria-valuenow="80"
									aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $percent_rating['star1'];?>%">
									<span class="sr-only"><?php echo $percent_rating['star1'];?>%</span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-md-12 text-center top-15">
						<a href="<?php echo $link_all_reviews;?>" class="btn btn-blue"><i class="fa fa-comments-o" aria-hidden="true"></i> <?php echo $btn_all_review; ?></a>
					</div>
				</div>
				<div class="col-xs-12 col-md-5 col-rl">
					<div class="review-box-wrapper">
					<div class="all-review-box-mod carousel-reviews-store-<?php echo $module;?> owl-carousel">
						<?php foreach ($reviews as $review) { ?>
							<div class="item">
								<div id="review_box_<?php echo $review['review_id']?>">
										<div class="info-header-review-mod clearfix">
											<div class="col-xs-12 col-sm-4 rev-author"><span class="glyphicon glyphicon-user"></span> <?php echo $review['author'];?></div>
											<div class="col-xs-12 col-sm-4 rev-rating">

												<div class="rating-container">
										    <?php if ($review['rating'] != 0){ ?>
										    <?php for ($i = 1; $i <= 5; $i++) { ?>
										    <?php if ($review['rating'] < $i) { ?>
										    <span class="fa fa-stack"><i class="fa fa-star star-gray"></i></span>
										    <?php } else { ?>
										    <span class="fa fa-stack"><i class="fa fa-star"></i></span>
										    <?php } ?>
										    <?php } ?>
										    <?php } ?>
										    </div>

											</div>
											<div class="col-xs-12 col-sm-4 rev-date-add"><?php echo $review['date_added'];?></div>
										</div>
										<div class="mod-desc-reviews">
											<p><?php echo $review['text'];?></p>
											<?php if(true){ ?>
												<div class = "plus-minus">
											<?php if($review['plus']){ ?>
											<p></span><strong class='plus'><?php echo $text_plus; ?> </strong><span><?php echo $review['plus']; ?></p>
											<?php } ?>
											<?php if($review['minus']){ ?>
											<p></span><strong class='minus'><?php echo $text_minus; ?> </strong><span><?php echo $review['minus']; ?></p>
												<?php } ?>
											</div>
											<?php } ?>
										</div>
								</div>
								<?php if($review['images'] || $review['videos']){ ?>
									<div class="review-media-container">
									  <?php if(true){ ?>
									  <?php if(!empty($review['images'])){ ?>
									      <div class="owl-carousel thumbnails reviews-thumbnails">
									    <?php foreach($review['images'] as $image){ ?>
									        <div class="item store-image-thumbnails"><a class="ex-thumbnail" href="<?php echo $image['popup']; ?>"> <img class = "<?php echo $image['type'] == '0' ? 'store-image-crop' : 'store-imgbb' ?>" src="<?php echo $image['thumb']; ?>"/></a></div>
									  <?php } ?>
									</div>
									  <?php } ?>
									<?php } ?>
									<?php if(true){ ?>
									  <?php if(!empty($review['videos'])){ ?>
									      <div class="owl-carousel-videos thumbnails">
									    <?php foreach($review['videos'] as $video){ ?>
									        <div class="item videos-thumbnails"><a class="popup-youtube store-review-videos" href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img src="//img.youtube.com/vi/<?php echo $video; ?>/default.jpg" alt="" class="youtube-click">
									          <svg viewBox="0 0 57 40" id="icon-youtube" xmlns="http://www.w3.org/2000/svg" width="30px" height="100%">
									            <path fill= "#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path>
									            <path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path></svg>
									        </a></div>
									  <?php } ?>
									</div>
									  <?php } ?>
									<?php } ?>
									</div>
								<?php }?>


								<div class="review_note" id="review-note-<?php echo $review['review_id'] ?>"></div>
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

							</div>
						<?php } ?>
							</div>
						<button class = "btn btn-light btn-review-more">Показать полностью <i class="fa fa-chevron-down"></i></button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="hidden" id="hidden-popups">
	<div id="detail-review" class="popup-media-container">
	</div>
</div>
<script><!--
$(document).ready(function() {
$('.carousel-reviews-store-<?php echo $module;?>').owlCarousel({
	responsiveBaseWidth: ".carousel-reviews-store-<?php echo $module;?>",
	items : 1,
	<?php if(isset($autoplay)){ ?>
	autoPlay: <?php echo $autoplay_speed;?>,
	<?php }?>
	stopOnHover : true,
	navigation: true,
	singleItem: true,
	pagination: false,
	navigationText: ['<div class="btn btn-carousel-module next-prod"><i class="fa fa-angle-left arrow"></i></div>', '<div class="btn btn-carousel-module prev-prod"><i class="fa fa-angle-right arrow"></i></div>']
});
$('.reviews-thumbnails').owlCarousel({
	loop:true,
			margin:10,
			responsiveClass:true,
			items : 5,
			autoplay: false,
			pagination: false,
			navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
			itemsDesktop: [1199, 5],
			itemsTablet: [768, 6],
			itemsMobile: [479, 3],
});
$('.owl-carousel-videos').owlCarousel({
			loop:true,
			margin:0,
			responsiveClass:true,
			pagination: false,
			items : 3,
			navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
			itemsDesktop: [1280, 3],
			itemsDesktopSmall: [980, 2],
			itemsTablet: [768, 4],
			itemsMobile: [479, 2],
});
$('.reviews-thumbnails').magnificPopup({
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
$('.popup-youtube, .popup-vimeo, .popup-gmaps').magnificPopup({
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
	$(".btn-review-more").on('click', function(){
		$(".review-box-wrapper").toggleClass("a-height");
		$(".plus-minus").toggle(350);
		$(".mod-desc-reviews").toggleClass("a-height");
		$(this).html() == 'Показать полностью <i class="fa fa-chevron-down"></i>' ? $(this).html('Скрыть <i class="fa fa-chevron-up"></i>') : $(this).html('Показать полностью <i class="fa fa-chevron-down"></i>');
	});
	$('.review-vote-negative').on('click', function() {
	  $('.review_note .alert').remove();
	  var id = $(this).data("value");
	  var votename = "vote"+id;
	  var note_block = $("#review-note-"+id);
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
	});
	$('.review-vote-positive').on('click', function() {
	  $('.review_note .alert').remove();
	  var id = $(this).data("value");
	  var votename = "store-vote"+id;
	  var note_block = $("#review-note-"+id);
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
	});
//--></script>
</div>

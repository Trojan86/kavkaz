<?php if ($testimonials) { ?>
<div class="row tm-list tm-list-1">
    <?php foreach ($testimonials as $testimonial) { ?>
    <div class="review-layout review-list col-xs-12">
        <div class="review-thumb <?php if(!$testimonial_image){ echo 'no-image'; } ?>">
            <?php if($testimonial_image){ ?>
            <div class="image">
                <img src="<?php echo $testimonial['thumb']; ?>" alt="" title="" class="img-responsive" />
            </div>
            <?php } ?>
            <div>
                <div class="caption">
                    <p class="h4"><?php echo $testimonial['author']; ?></p>
                    <p><?php echo $testimonial['text']; ?></p>
                    <?php if($testimonial_rating && $testimonial['rating']){ ?>
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                    <?php if ($testimonial['rating'] < $i) { ?>
                        <span class="fa fa-stack">
                            <?php echo $testimonial_icon_third; ?>
                        </span>
                    <?php } else { ?>
                        <span class="fa fa-stack">
                            <?php echo $testimonial_icon_first; ?>
                            <?php echo $testimonial_icon_second; ?>
                        </span>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                    <?php if($testimonial_date){ ?>
                    <p class="date-add">
                        <?php echo $text_posted; ?> <?php echo $testimonial['date_added']; ?>
                    </p>
                    <?php } ?>
                    <?php if($testimonial_registered && $testimonial['customer_id']){ ?>
                        <span class="registered"><span class="fa fa-check-circle-o" style='color: <?php echo $testimonial_registered_color; ?>;'></span>
                            <?php echo $text_registered; ?>
                        </span>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
    <?php } ?>
</div>
<div class="row j-pagination">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php }else{ ?>
<p class="h5"><?php echo $text_no_reviews; ?></p>
<?php } ?>
<style>
    @media (min-width: 767px){
        .review-list .review-thumb .caption {
            margin-left: <?php echo $testimonial_image?$testimonial_image_width+15:0; ?>px;
        }
    }
</style>
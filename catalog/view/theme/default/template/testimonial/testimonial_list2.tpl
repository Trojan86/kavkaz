<?php if ($testimonials) { ?>
<div class="row tm-list tm-list-2">
    <?php foreach ($testimonials as $testimonial) { ?>
    <div class="review-layout review-grid col-lg-3 col-md-3 col-sm-6 col-xs-12">
        <div class="review-thumb <?php if(!$testimonial_image){ echo 'no-image'; } ?>">
            <?php if($testimonial_image){ ?>
            <div class="image">
                <img src="<?php echo $testimonial['thumb']; ?>" alt="<?php echo $testimonial['author']; ?>" class="img-responsive" />
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
        .product-list .product-thumb .caption {
            margin-left: <?php echo $testimonial_image?$testimonial_image_width:0; ?>px;
        }
    }
</style>
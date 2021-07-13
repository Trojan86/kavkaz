<?php if($heading_title){ ?>
<div class="tm-mod-title h3"><?php echo $heading_title; ?></div>
<?php } ?>
<?php if(!isset($error_not_installed)){ ?>
<div class="tm-mod-block row <?php echo $tm_class; ?>">
    <?php if($testimonials){ ?>
        <?php foreach ($testimonials as $testimonial) { ?>
        <div class="tm-mod-item tm-align-<?php echo $text_align?$text_align:'left'; ?> col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="tm-mod-content">
                <?php if($image){ ?>
                <div class="tm-mod-image tm-image-<?php echo $image; ?>">
                    <img src="<?php echo $testimonial['thumb']; ?>" alt="<?php echo $testimonial['author']; ?>" title="<?php echo $testimonial['author']; ?>"/>
                </div>
                <?php } ?>
                <div class="tm-mod-author h4">
                    <?php echo $testimonial['author']; ?>
                </div>
                <div class="tm-mod-comment">
                    <?php echo $testimonial['text']; ?>
                </div>
                <?php if($testimonial_rating && $testimonial['rating']){ ?>
                <div class="tm-mod-rating">
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
                </div>
                <?php } ?>
                <?php if($testimonial_date){ ?>
                <div class="tm-mod-date">
                    <?php echo $text_posted; ?> <?php echo $testimonial['date_added']; ?>
                </div>
                <?php } ?>
                <?php if($testimonial_registered && $testimonial['customer_id']){ ?>
                <div class="tm-mod-registered">
                    <span class="fa fa-check-circle-o" style='color: <?php echo $testimonial_registered_color; ?>;'></span> <?php echo $text_registered; ?>
                </div>
                <?php } ?>
            </div>
        </div>
        <?php } ?>
    <?php } else { ?>
    <div class="tm-mod-item tm-align-<?php echo $text_align?$text_align:'left'; ?> col-xs-12">
        <?php echo $text_no_reviews; ?>
    </div>
    <?php } ?>
    <?php if($button_all){ ?>
    <div class="tm-mod-btn">
        <a href="<?php echo $keyword; ?>"><?php echo $button_all_text; ?></a>
    </div>
    <?php } ?>
</div>
<?php } else { ?>
<?php echo $error_not_installed; ?>
<?php } ?>
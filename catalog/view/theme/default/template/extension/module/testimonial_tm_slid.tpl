<?php if($heading_title){ ?>
<div class="tm-mod-title h3"><?php echo $heading_title; ?></div>
<?php } ?>
<?php if(!isset($error_not_installed)){ ?>
    <?php if($testimonials){ ?>
    <div id="carousel<?php echo $module; ?>" class="tm-mod-block owl-carousel <?php echo $tm_class; ?>">
        <?php foreach ($testimonials as $testimonial) { ?>
        <div class="tm-mod-item tm-align-<?php echo $text_align?$text_align:'left'; ?>">
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
                    <?php echo $testimonial['date_added']; ?>
                </div>
                <?php } ?>
                <?php if($testimonial_registered && $testimonial['customer_id']){ ?>
                <div class="tm-mod-registered">
                    <span class="fa fa-check-circle-o" style='color: <?php echo $testimonial_registered_color; ?>;'></span> <?php echo $text_registered; ?>
                </div>
                <?php } ?>
                <?php if($button_all){ ?>
                <div class="tm-mod-btn">
                    <a href="<?php echo $keyword; ?>"><?php echo $button_all_text; ?></a>
                </div>
                <?php } ?>
            </div>
        </div>
        <?php } ?>
    </div>
    <?php } else { ?>
        <?php echo $text_no_reviews; ?>
    <?php } ?>
<?php } else { ?>
<?php echo $error_not_installed; ?>
<?php } ?>
<script type="text/javascript"><!--
    $('#carousel<?php echo $module; ?>').owlCarousel({
        items: '<?php echo $slide_limit; ?>',
        autoPlay: '<?php echo $slide_speed; ?>',
        singleItem: $.parseJSON('<?php echo $single_item; ?>'),
        navigation: $.parseJSON('<?php echo $navigation; ?>'),
        navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
        pagination: $.parseJSON('<?php echo $pagination; ?>')
    });
    --></script>
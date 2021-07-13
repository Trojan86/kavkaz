<?php if($heading_title){ ?>
<section>
    <div class="lazy testimonial__bg"  data-bg="catalog/view/theme/default/image/testimonial-bg.jpg"></div>
    <div class="testimonial__wrap">
        <div class="container">
            <div class="testimonial__container">
                <div class="wrap__title-box">
                    <h3 class="wrap__title"><?php echo $heading_title; ?></h2>
                </div>
                <?php } ?>
                <div class="testimonial__list-box-main">

                    <?php if(!isset($error_not_installed)){ ?>
                    <?php if($testimonials){ ?>
                    <?php $count = 0 ?>
                    <ul class="testimonial__list testimonial__list-main">
                    <?php foreach ($testimonials as $testimonial) { ?>
                        <?php if($count % 2 === 0){ ?>
                                <li class="testimonial__item">
                                    <div class="testimonial__tittle-box">
                                        <?php if($image){ ?>
                                        <div class="tm-mod-image tm-image-<?php echo $image; ?>">
                                            <img class="lazy testimonial__avatar" data-src="<?php echo $testimonial['thumb']; ?>" alt="<?php echo $testimonial['author']; ?>" title="<?php echo $testimonial['author']; ?>"/>
                                        </div>
                                        <?php } ?>
                                        <div class="testimonial__tittle-left">

                                            <?php if($testimonial_rating && $testimonial['rating']){ ?>
                                            <div class="testimonial__rating">
                                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                <?php if ($testimonial['rating'] < $i) { ?>
                                                <label for="star_<?php echo $i ?>"> ☆ </label>
                                                <?php } else { ?>
                                                <label class="active" for="star_<?php echo $i ?>"> ☆ </label>
                                                <?php } ?>
                                                <?php } ?>
                                            </div>
                                            <?php } ?>
                                            <div class="testimonial__tittle">
                                                <?php echo $testimonial['author']; ?>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tm-mod-comment">
                                        <?php echo $testimonial['text']; ?>
                                    </div>

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
                                </li>
                        <?php } ?>
                        <?php $count++ ?>
                    <?php } ?>
                    </ul>
                    <ul class="testimonial__list testimonial__list-main">
                    <?php foreach ($testimonials as $testimonial) { ?>
                        <?php if($count % 2 === 1){ ?>
                                <li class="testimonial__item">
                                    <div class="testimonial__tittle-box">
                                        <?php if($image){ ?>
                                        <div class="tm-mod-image tm-image-<?php echo $image; ?>">
                                            <img class="lazy testimonial__avatar" data-src="<?php echo $testimonial['thumb']; ?>" alt="<?php echo $testimonial['author']; ?>" title="<?php echo $testimonial['author']; ?>"/>
                                        </div>
                                        <?php } ?>
                                        <div class="testimonial__tittle-left">

                                            <?php if($testimonial_rating && $testimonial['rating']){ ?>
                                            <div class="testimonial__rating">
                                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                <?php if ($testimonial['rating'] < $i) { ?>
                                                <label for="star_<?php echo $i ?>"> ☆ </label>
                                                <?php } else { ?>
                                                <label class="active" for="star_<?php echo $i ?>"> ☆ </label>
                                                <?php } ?>
                                                <?php } ?>
                                            </div>
                                            <?php } ?>
                                            <div class="testimonial__tittle">
                                                <?php echo $testimonial['author']; ?>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tm-mod-comment">
                                        <?php echo $testimonial['text']; ?>
                                    </div>

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
                                </li>
                        <?php } ?>
                        <?php $count++ ?>
                    <?php } ?>
                    </ul>
                    <?php } else { ?>
                    <div class="tm-mod-item tm-align-<?php echo $text_align?$text_align:'left'; ?> col-xs-12">
                        <?php echo $text_no_reviews; ?>
                    </div>
                    <?php } ?>
                </div>
                <!--<?php if($button_all){ ?>
                <a class="testimonial__btn-create" href="<?php echo $keyword; ?>"><?php echo $send_feedback; ?></a>
                <?php } ?>-->   
            </div>
        </div>
</section>
<?php } else { ?>
<?php echo $error_not_installed; ?>
<?php } ?>

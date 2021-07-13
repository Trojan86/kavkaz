<?php if ($testimonials) { ?>
<div class="row tm-list tm-list-6">
    <div class="col-md-12">
        <section class="comment-list">
            <?php $number = 0; ?>
            <?php foreach ($testimonials as $testimonial) { ?>
            <?php if($number%2 == 0){ ?>
            <!-- Comment -->
            <article class="row">
                <?php if($testimonial_image){ ?>
                <div class="col-md-2 col-sm-2 hidden-xs">
                    <figure class="thumbnail">
                        <img class="img-responsive" src="<?php echo $testimonial['thumb']; ?>">
                    </figure>
                </div>
                <?php } ?>
                <div class="<?php echo $testimonial_image?'col-md-10 col-sm-10':'col-md-12 col-sm-12'; ?>">
                    <div class="panel panel-default arrow left">
                        <?php if($testimonial_date){ ?>
                        <div class="review-date panel-heading right" datetime="<?php echo $testimonial['date_added']; ?>">
                            <?php echo $text_posted; ?> <?php echo $testimonial['date_added']; ?>
                        </div>
                        <?php } ?>
                        <div class="panel-body">
                            <div class="text-left">
                                    <span>
                                        <div class="comment-user">
                                            <span><?php echo $testimonial['author']; ?><span>
                                        </div>
                                    </span>
                            </div>
                            <div class="comment-post">
                                <?php echo $testimonial['text']; ?>
                            </div>
                        </div>
                        <div class="panel-footer right">
                            <?php if($testimonial_registered && $testimonial['customer_id']){ ?>
                                <span class="registered">
                                    <span class="fa fa-check-circle-o" style='color: <?php echo $testimonial_registered_color; ?>;'></span> <?php echo $text_registered; ?>
                                </span>
                            <?php } ?>
                            <?php if($testimonial_rating && $testimonial['rating']){ ?>
                            <div class="rating">
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
                        </div>
                    </div>
                </div>
            </article>
            <!-- Comment -->
            <?php }else{ ?>
            <!-- Comment -->
            <article class="row">
                <div class="<?php echo $testimonial_image?'col-md-10 col-sm-10':'col-md-12 col-sm-12'; ?>">
                    <div class="panel panel-default arrow right">
                        <?php if($testimonial_date){ ?>
                        <div class="review-date panel-heading" datetime="<?php echo $testimonial['date_added']; ?>">
                            <?php echo $text_posted; ?> <?php echo $testimonial['date_added']; ?>
                        </div>
                        <?php } ?>
                        <div class="panel-body">
                            <div class="text-right">
                                <div class="comment-user">
                                        <span><?php echo $testimonial['author']; ?><span>
                                </div>
                            </div>
                            <div class="comment-post">
                                <?php echo $testimonial['text']; ?>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <?php if($testimonial_registered && $testimonial['customer_id']){ ?>
                                <span class="registered">
                                    <span class="fa fa-check-circle-o" style='color: <?php echo $testimonial_registered_color; ?>;'></span>
                                    <?php echo $text_registered; ?>
                                </span>
                            <?php } ?>
                            <?php if($testimonial_rating && $testimonial['rating']){ ?>
                            <div class="rating">
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
                        </div>
                    </div>
                </div>
                <?php if($testimonial_image){ ?>
                <div class="col-md-2 col-sm-2 hidden-xs">
                    <figure class="thumbnail">
                        <img class="img-responsive" src="<?php echo $testimonial['thumb']; ?>">
                    </figure>
                </div>
                <?php } ?>
            </article>
            <!-- Comment -->
            <?php } ?>
            <?php $number++; ?>
            <?php } ?>
        </section>
    </div>
</div>
<div class="row j-pagination">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php }else{ ?>
<p class="h5"><?php echo $text_no_reviews; ?></p>
<?php } ?>

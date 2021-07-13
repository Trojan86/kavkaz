<?php if ($testimonials) { ?>
<ol class="tm-list tm-list-7">
    <?php foreach ($testimonials as $testimonial) { ?>
    <li class="comment">
    <article class="comment-body">
        <div class="comment-meta">
            <?php if($testimonial_image){ ?>
            <img alt="<?php echo $testimonial['author']; ?>" src="<?php echo $testimonial['thumb']; ?>" class="avatar" height="<?php echo $testimonial_image_height; ?>" width="<?php echo $testimonial_image_width; ?>">
            <?php } ?>
            <div class="comment-author-info">
                <div class="comment-author">
                    <div class="comment-user">
                        <?php echo $testimonial['author']; ?>
                    </div>
                </div>
                <?php if($testimonial_date){ ?>
                <?php echo $text_posted; ?>
                <time datetime="<?php echo $testimonial['date_added']; ?>">
                     <?php echo $testimonial['date_added']; ?>
                </time>
                <?php } ?>
            </div>
        </div>
        <div class="comment-content">
            <p><?php echo $testimonial['text']; ?></p>
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
    </article>
    </li>
    <?php } ?>
</ol>
<div class="j-pagination">
    <?php echo $pagination; ?>
</div>
<?php }else{ ?>
<p class="h5"><?php echo $text_no_reviews; ?></p>
<?php } ?>
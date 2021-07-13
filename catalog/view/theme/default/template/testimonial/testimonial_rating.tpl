<div class="row">
    <div class="col-sm-12 <?php echo $class; ?>">
        <div class="average-rating">
            <span><?php echo $reviews_rating_average; ?>/5</span> <?php echo $text_from; ?><span> <?php echo $reviews_rating_total; ?> <?php echo $text_reviews; ?></span>
        </div>
        <div class="average-rating-star star-tmp<?php echo $testimonial_stars; ?>">
            <p></p><p></p><p></p><p></p><p></p>
            <span style="width: <?php echo $reviews_rating; ?>%;" class="average-rating-span"></span>
        </div>
    </div>
</div>
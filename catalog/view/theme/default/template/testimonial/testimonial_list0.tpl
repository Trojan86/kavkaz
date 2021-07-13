<?php if ($testimonials) { ?>
<div class="tm-list tm-list-0">
    <?php foreach ($testimonials as $testimonial) { ?>
    <table class="table table-striped table-bordered">
        <tr>
            <td class="td-author">
                <?php if($testimonial_registered && $testimonial['customer_id']){ ?>
        <span style='color: <?php echo $testimonial_registered_color; ?>;' data-toggle="tooltip"
              data-original-title="<?php echo $text_registered; ?>" class="fa fa-check"></span>
                <?php } ?>
        <span>
            <strong><?php echo $testimonial['author']; ?></strong>
        </span>
            </td>
            <?php if($testimonial_date){ ?>
            <td class="text-right">
                <?php echo $text_posted; ?> <?php echo $testimonial['date_added']; ?>
            </td>
            <?php } ?>
        </tr>
        <tr>
            <td colspan="2">
                <?php if($testimonial_image){ ?>
                <div class="tm-avatar">
                    <img src="<?php echo $testimonial['thumb']; ?>" alt="<?php echo $testimonial['author']; ?>" class="img-responsive"/>
                </div>
                <?php } ?>
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
            </td>
        </tr>
    </table>
    <?php } ?>
</div>
<div class="row j-pagination">
    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
<?php } else { ?>
<p class="h5"><?php echo $text_no_reviews; ?></p>
<?php } ?>
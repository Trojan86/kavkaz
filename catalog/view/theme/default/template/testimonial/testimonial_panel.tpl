<?php if($testimonial_sort || $testimonial_count){ ?>
<div class="row">
    <?php if($testimonial_sort){ ?>
    <div class="<?php echo $testimonial_count?'col-md-6':'col-md-9'; ?> text-right">
        <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
    </div>
    <div class="col-md-3 text-right">
        <select id="input-sort" class="form-control" onchange="location = this.value;">
            <?php foreach ($sorts as $item) { ?>
            <?php if ($item['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $item['href']; ?>" selected="selected"><?php echo $item['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $item['href']; ?>"><?php echo $item['text']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>
    <?php } ?>
    <?php if($testimonial_count){ ?>
    <div class="<?php echo $testimonial_sort?'col-md-1':'col-md-10'; ?> text-right">
        <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
    </div>
    <div class="col-md-2 text-right">
        <select id="input-limit" class="form-control" onchange="location = this.value;">
            <?php foreach ($limits as $item) { ?>
            <?php if ($item['value'] == $limit) { ?>
            <option value="<?php echo $item['href']; ?>" selected="selected"><?php echo $item['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $item['href']; ?>"><?php echo $item['text']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>
    <?php } ?>
</div>
<br>
<?php } ?>
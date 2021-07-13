<?php echo $header; ?>
<div id="container" class="container tm-container j-container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <?php if ($success) { ?>
    <div class="alert alert-success" id="alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'tm-col-sm-6 col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'tm-col-sm-9 col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'tm-col-sm-12 col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>">
            <?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>
            <?php if(!isset($error_not_installed)){ ?>
            <?php echo $testimonial_top; ?>
            <!--reviews start-->
            <?php echo $testimonial_list; ?>
            <!--reviews end-->
            <?php echo $testimonial_bottom; ?>
            <?php } else { ?>
            <?php echo $error_not_installed; ?>
            <?php } ?>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<?php echo $footer; ?>

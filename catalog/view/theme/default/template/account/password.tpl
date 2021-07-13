<?php echo $header; ?>
<section>
  <div class="container">
    <!--<ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>-->
    <div class="private__wrap"><?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="private__section private-item-2 show <?php echo $class; ?>"><?php echo $content_top; ?>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal private__password-form form-validation">
          <h1 class="private__password-title"><?php echo $heading_title; ?></h1>
            <!--<legend><?php echo $text_password; ?></legend>-->
            <div class="private__password">
            <div class="form-group required password checkout__input-box">
              <fieldset class="checkout__input-fieldset">
                <legend><?php echo $entry_password; ?></legend>
                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control password-input checkout__input field" />
                <span href="#" class="password-control"></span>
                <?php if ($error_password) { ?>
                <div class="checkout__input-error"><?php echo $error_password; ?></div>
                <?php } ?>
              </fieldset>
              <!--<label class="col-sm-2 control-label" for="input-password"><?php echo $entry_password; ?></label>-->
            </div>
              <div class="form-group required password checkout__input-box">
                <fieldset class="checkout__input-fieldset">
                  <legend><?php echo $entry_password; ?></legend>
                  <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control password-input checkout__input field" />
                  <span href="#" class="password-control"></span>
                  <?php if ($error_confirm) { ?>
                  <div class="checkout__input-error"><?php echo $error_confirm; ?></div>
                  <?php } ?>
                </fieldset>
                <!--<label class="col-sm-2 control-label" for="input-password"><?php echo $entry_password; ?></label>-->
              </div>
            </div>
              <input type="submit" value="<?php echo $button_continue; ?>" class="btn private__btn-checkout checkout__btn-submit btn-primary" />
            <a href="<?php echo $back; ?>" class="btn private__btn-checkout-cancel"><?php echo $button_back; ?></a>
        </form>
        <?php echo $content_bottom; ?></div>
      <?php echo $column_right; ?></div>
  </div>
</section>
<?php echo $footer; ?>
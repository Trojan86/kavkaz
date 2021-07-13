<?php echo $header; ?>
<section>
  <div class="container">
    <!--<ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>-->
    <div class="private__wrap">
      <?php echo $column_left; ?>
      <div id="content" class="private__section private__section-email private-item-6 show <?php echo $class; ?>"><?php echo $content_top; ?>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="private__email-form form-validation form-horizontal">
          <h4 class="private__email-title"><?php echo $heading_title; ?></h4>

          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class=""><?php echo $name_lastname; ?></legend>
              <input class="checkout__input field" name="firstname" type="text"
                    placeholder="" required>
              <p class="checkout__input-error"><?php echo $error_text; ?></p>
            </fieldset>
          </div>
          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class=""><?php echo $phone_number; ?></legend>
              <input class="checkout__input phone field" name="phone" type="phone"
                    placeholder="" required>
              <p class="checkout__input-error"><?php echo $error_text; ?></p>
            </fieldset>
          </div>
          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class=""><?php echo $email_text ?></legend>
              <input class="checkout__input field" name="email" type="email"
                    placeholder="" required>
              <p class="checkout__input-error"><?php echo $error_email; ?></p>
            </fieldset>
          </div>
          <div class="checkout__input-box checkout__textarea-box">
            <fieldset class="checkout__input-fieldset checkout__textarea-fieldset">
              <legend class=""><?php echo $essence; ?></legend>
              <textarea class="checkout__input" name="text"></textarea>
              <p class="checkout__input-error"><?php echo $error_text; ?></p>
            </fieldset>
          </div>
          <input type="submit" value="<?php echo $entry_newsletter; ?>" class="btn private__btn-checkout checkout__btn-submit btn-primary" />
        </form>
        <?php echo $content_bottom; ?></div>
      <?php echo $column_right; ?></div>
  </div>
</section>
<?php echo $footer; ?>
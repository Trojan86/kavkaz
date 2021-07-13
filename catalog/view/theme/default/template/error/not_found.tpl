<div class="footer__404">
  <?php echo $header; ?>
    <!--<ul class="breadcrumbs__list">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>"><span class="breadcrumbs__item-text">
            <?php echo $breadcrumb['text']; ?></span></a></li>
      <?php } ?>
    </ul>-->
    <div class="error__img-bg-bottom">
        <div class="container">
            <img class="contacts__img-bg-bottom" src="catalog/view/theme/default/img/404-bg.png" alt="image">
        </div>
    </div>
    <section class="error__section">
      <div class="container">
        <div class="error__wrap">
          <div class="error__text-wrap">
            <p class="error__title"><?php echo $heading_title; ?></p>
            <p class="error__text"><?php echo $text_error; ?></p>
            <a class="error__link" href="<?php echo $continue; ?>"><!--<?php echo $button_continue; ?>-->На главную</a>
          </div>
          <div class="error__img-box">
            <div class="error__img">
              <img class="error__img-title" src="catalog/view/theme/default/img/404.png" alt="image">
            </div>
          </div>
        </div>
      </div>
    </section>

  <?php echo $footer; ?>
</div>

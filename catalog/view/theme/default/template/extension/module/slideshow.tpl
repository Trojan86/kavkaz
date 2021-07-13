<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
<div class="container container-600">
  <div class="main__banner-wrap">
    <div class="glider-contain banner-big">
      <div id="slideshow<?php echo $module; ?>" class="tiny-slider">
        <?php foreach ($banners as $banner) { ?>
        <div class="main__banner-item-wrap">
          <div class="main__banner-item item">
            <?php if ($banner['link']) { ?>
            <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" data-src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive tns-lazy" style="width:700px"/></a>
            <?php } else { ?>
            <div class="main__banner-content">
              <h2 class="title">Традиционные кавказкие блюда от бренд-шефа</h2>
              <div class="main__banner-btn-box">
                <a class="main__banner-btn-nav" href="https://kavkaz-ochag.artyshok.studio/index.php?route=product/category&path=66">перейти к меню</a>
                <a class="main__banner-btn-video scroll-to" href="#previewWrap">
                  <span class="btn__play"></span>
                  <span class="btn__play-text">Посмотреть наш промо-ролик</span>
                </a>
              </div>
            </div>
            <img src="<?php echo $banner['image']; ?>" data-src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive tns-lazy" style="width:725px"/>
            <?php } ?>
          </div>
        </div>
        <?php } ?>
      </div>
      <div id="dots" class="glider-dots"></div>
      <img class="lazy main__banner-item-after" data-src="catalog/view/theme/default/image/pepper.png" alt="pepper image">
    </div>
    <div class="main__banner-litle">
      <div class="main__banner-item">
        <img class="lazy main__banner-litle1-bg-title" data-src="catalog/view/theme/default/image/banner-bg-1.png" alt="image">
        <img class="lazy main__banner-litle1-bg" data-src="catalog/view/theme/default/image/banner-litle1-bg.png" alt="image">
        <h2 class="title">-10% при самовывозе!</h2>
        <p class="main__banner-text">Скидка для активных людей</p>
        <div>
          <a class="main__banner-btn" href="/promotions">Смотреть все акции</a>
        </div>
      </div>
      <div class="main__banner-item">
        <img class="lazy main__banner-litle2-bg-title" data-src="catalog/view/theme/default/image/banner-bg-2.png" alt="image">
        <img class="lazy main__banner-litle2-bg" data-src="catalog/view/theme/default/image/banner-litle2-bg.png" alt="image">
        <h2 class="title">-10% на первый заказ!</h2>
        <p class="main__banner-text">Через приложение с доставкой</p>
        <div class="banner__app-wrap">
          <p>Скачать приложение</p>
          <div class="banner__app-list">
            <a class="banner__app-link" href="https://apps.apple.com/us/app/%D0%BA%D0%B0%D0%B2%D0%BA%D0%B0%D0%B7%D1%8C%D0%BA%D0%B8%D0%B9-%D0%BE%D1%87%D0%B0%D0%B3/id1484317728?l=ru&amp;ls=1" target="_blank" rel="noopener">
              <img alt="apple store" class="lazy banner__app-img" data-src="catalog/view/theme/default/image/store_apple.jpg">
            </a>
            <a class="banner__app-link" href="https://apps.apple.com/us/app/%D0%BA%D0%B0%D0%B2%D0%BA%D0%B0%D0%B7%D1%8C%D0%BA%D0%B8%D0%B9-%D0%BE%D1%87%D0%B0%D0%B3/id1484317728?l=ru&amp;ls=1" target="_blank" rel="noopener">
              <img alt="apple store" class="lazy banner__app-img" data-src="catalog/view/theme/default/image/google-play.jpg">
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

</script>
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title><?php echo $title; ?></title>
  <base href="<?php echo $base; ?>" />
  <?php if ($description) { ?>
  <meta name="description" content="<?php echo $description; ?>" />
  <?php } ?>
  <?php if ($keywords) { ?>
  <meta name="keywords" content= "<?php echo $keywords; ?>" />
  <?php } ?>
  <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
  <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link rel="preload" href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400;1,500;1,600&family=Tenor+Sans&display=swap" as="style">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400;1,500;1,600&family=Tenor+Sans&display=swap">
  <?php foreach ($styles as $style) { ?>
  <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
  <?php } ?>
  <script src="catalog/view/javascript/common.js" type="text/javascript"></script>
  <?php foreach ($links as $link) { ?>
  <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
  <?php } ?>
  <?php foreach ($scripts as $script) { ?>
  <script src="<?php echo $script; ?>" type="text/javascript"></script>
  <?php } ?>
  <?php foreach ($analytics as $analytic) { ?>
  <?php echo $analytic; ?>
  <?php } ?>
  <script src="catalog/view/javascript/bootstrap.min.js" defer></script>
  <script src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js"></script>
  <script src="catalog/view/javascript/jquery/datetimepicker/moment.js"></script>
  <script type="text/javascript">
    $(document).ready(function($) {
      var url=document.location.href;
      $.each($(".header__nav-wrap a"),function(){
        if(this.href==url){$(this).parent().addClass('active');};
      });
    });
  </script>
  <link href="catalog/view/theme/default/stylesheet/main.min.css" rel="stylesheet">
</head>
<?php 
  $path = "common/home";
  $url = $_SERVER['REQUEST_URI'];
  if ($url == "/" or strripos($url, $path)) {
    $is_home = TRUE;
  }else{
    $is_home = false;
  }            
?>
<body class="<?php echo $class; ?>">
<div class="wrapper">
<div class="bg-fix"></div>
  <header class="header">
    <div class="container">
      <div id="top-links" class="header__top-wrap">
        <div class="header__top-left-wrap">
          <div class="header__top-item header__time-wrap desktop">
            <i class="header__item-img header__time-icon icon-time"></i>
            <span class="header__time-text">10:00 - 21:00</span>
          </div>
          <div class="header__top-item header__phone-wrap">
            <i class="header__item-img header__phone-icon icon-phone"></i>
            <a href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
            <div class="triangle-btn triangle-event">
              <img src="catalog/view/theme/default/img/triangle.svg" alt="triangle icon" class="triangle-icon">
            </div>
            <ul class="header__phone-accordion">
              <li class="header__phone-accordion-item">
                <a href="tel:<?php echo $telephone; ?>"><span class="hidden-xs hidden-sm hidden-md"><?php echo $telephone; ?></span></a>
              </li>
            </ul>
          </div>
        </div>
        <div id="logo" class="header__logo-wrap">
          <?php if (!$is_home) { ?>
            <a aria-label="home link" href="<?php echo $home; ?>"><img class="header__logo-img-desktop" src="<?php echo $logo; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
            <a aria-label="home link" href="<?php echo $home; ?>"><img class="header__logo-img-mobile" src="catalog/view/theme/default/image/logo-mob.png" alt="<?php echo $name; ?>" class="img-responsive" /></a>
          <?php } else { ?>
            <img class="header__logo-img-desktop" src="<?php echo $logo; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
            <img class="header__logo-img-mobile" src="catalog/view/theme/default/image/logo-mob.png" alt="<?php echo $name; ?>" class="img-responsive" />
          <?php } ?>
        </div>
        <div class="header__top-right-wrap">
          <div class="header__top-item header__mail-wrap popup__btn desktop-979" data-popup="mail">
            <i class="header__item-img header__mail-icon icon-pen"></i>
            <span class="header__mail-text"><?php echo $text_boss; ?></span>
          </div>
          <?php echo $language;?>
          <div class="header__top-item header__log-wrap desktop-979" data-popup="logIn">
              <i class="header__item-img header__log-icon icon-user"></i>
            <ul class="dropdown-menu dropdown-menu-right">
              <?php if ($logged) { ?>
            <li><a href="<?php echo $account_simple; ?>"><?php echo $text_account; ?></a></li>
            <?php } else { ?>
            <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
              <?php } ?>
            </ul>
          </div>
        </div>
        <button class="hamburger mobile" aria-label="hamburger nav"><span></span>
        </button>
      </div>
        <div class="header__nav-wrap">
          <ul class="header__nav-list">
            <li class="header__nav-item-menu accordion-wrap">
              <div class="header__menu-product triangle-event">
                <img src="catalog/view/theme/default/image/menu.svg" alt="menu img" class="header__item-img header__menu-img">
                <span class="header__metu-title">Меню</span>
                <div class="triangle-btn">
                  <img class="triangle-icon" src="catalog/view/theme/default/image/triangle.svg" alt="triangle icon">
                </div>
              </div>
              <div class="header__menu-list-overflow accordion" style="display: none;">
                <div class="header__menu-blocker">
                  <div class="header-blocker menu__close-btn"></div>
                  <div class="menu__accordion-close-btn menu__close-btn">
                    <div class="accordion-close-btn"></div>
                  </div>
                  <ul class="header__menu-list">
                    <?php if ($categories) { ?>
                    <?php foreach ($categories as $category) { ?>
                    <li class="header__menu-item">
                      <a href="<?php echo $category['href']; ?>">

                        <!--img class="header__menu-img-desctop lazy" data-src="<?php echo $category['thumb'];?>" alt="<?php echo $category['name']; ?>"-->

                        <img class="header__menu-img-desctop lazy" data-src="<?php echo $category['thumb'];?>" alt="<?php echo $category['name']; ?>">

                        <img data-src="<?php echo $category['icon_mob'];?>" alt="icon" class="header__menu-img-mobile lazy">
                        <span class="header__menu-item-text"><?php echo $category['name']; ?></span>
                      </a>
                    </li>
                    <?php } ?>
                    <?php } ?>
                  </ul>
                </div>
              </div>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $restorans_href; ?>">
                <span class="header__nav-title">Рестораны</span>
              </a>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $delivery_href; ?>">
                <span class="header__nav-title">Доставка и оплата</span>
              </a>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $promotions_href; ?>">
                <span class="header__nav-title">Бонусы и акции</span>
              </a>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $catering_href; ?>">
                <span class="header__nav-title">Кейтеринг</span>
              </a>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $vacancies_href; ?>">
                <span class="header__nav-title">Вакансии</span>
              </a>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $about_href; ?>">
                <span class="header__nav-title">О нас</span>
              </a>
            </li>
            <li class="header__nav-item">
              <a href="<?php echo $contact_href; ?>">
                <span class="header__nav-title">Контакты</span>
              </a>
            </li>
          </ul>
        </div>
      <div class="header__mob-wrap">
        <div class="header__mob-contaiter">
          <div class="header__mob-blocker header__close"></div>
          <div class="header__mob-btn-close header__close"><span class="btn-close"></span></div>
          <div class="header__logo-wrap-mob">
            <a href="#">
              <img class="header__logo-img" src="catalog/view/theme/default/img/logo-mob-title.png" alt="logo">
            </a>
          </div>
          <div class="header__top-item header__log-wrap">
            <ul>
                <?php if ($logged) { ?>
              <li><a href="<?php echo $account_simple; ?>">
                <i class="header__item-img header__log-icon icon-user"></i>
                <?php echo $text_account; ?>
              </a></li>
              <?php } else { ?>
              <li class="popuplogin"><a href="<?php echo $login; ?>">
                <!--<?php echo $text_login; ?>-->
                <i class="header__item-img header__log-icon icon-user"></i>
                <span>Войти/Авторизоваться</span>
              </a></li>
              <?php } ?>
            </ul>

          </div>
          <ul class="header__mob-nav-list">
            <li class="header__mob-nav-item">
              <a href="<?php echo $restorans_href; ?>">Рестораны</a>
            </li>
            <li class="header__mob-nav-item">
              <a href="<?php echo $delivery_href; ?>">Доставка и оплата</a>
            </li>
            <li class="header__mob-nav-item">
              <a href="<?php echo $promotions_href; ?>">Бонусы и Акции</a>
            </li>
            <li class="header__mob-nav-item">
              <a href="<?php echo $catering_href; ?>">Кейтеринг</a>
            </li>
            <li class="header__mob-nav-item">
              <a href="<?php echo $vacancies_href; ?>">Вакансии</a>
            </li>
            <li class="header__mob-nav-item">
              <a href="<?php echo $about_href; ?>">О нас</a>
            </li>
            <li class="header__mob-nav-item">
              <a href="<?php echo $contact_href; ?>">Контакты</a>
            </li>
          </ul>
          <div class="pl-15">
            <!-- <ul class="header__mob-phone-list">
              <li class="header__mob-phone-item">
                <a href="<?php echo $contact; ?>"><?php echo $telephone; ?></a>
              </li>
            </ul>
            <div class="header__top-item header__time-wrap">
              <p class="header__time-title">Заказы принимаются</p>
              <div>
                <i class="header__item-img header__time-icon icon-time"></i>
                <span class="header__time-text">10:00 - 21:00</span>
              </div>
            </div>-->
            <div class="header__top-item header__mail-wrap popup__btn" data-popup="mail">
              <i class="header__item-img header__mail-icon icon-pen"></i>
              <span class="header__mail-text">Написать директору</span>
            </div>
            <div class="header__mob-app">
              <a href="https://apps.apple.com/us/app/%D0%BA%D0%B0%D0%B2%D0%BA%D0%B0%D0%B7%D1%8C%D0%BA%D0%B8%D0%B9-%D0%BE%D1%87%D0%B0%D0%B3/id1484317728?l=ru&amp;ls=1" target="_blank" rel="noopener">
                <img alt="apple store" class="apple-icon" src="catalog/view/theme/default/img/store_apple.jpg">
              </a>
              <a href="https://apps.apple.com/us/app/%D0%BA%D0%B0%D0%B2%D0%BA%D0%B0%D0%B7%D1%8C%D0%BA%D0%B8%D0%B9-%D0%BE%D1%87%D0%B0%D0%B3/id1484317728?l=ru&amp;ls=1" target="_blank" rel="noopener">
                <img alt="apple store" class="apple-icon" src="catalog/view/theme/default/img/google-play.jpg">
              </a>
            </div>
            <div class="header__cocial-box">
              <a href="https://www.facebook.com/kavkazkuyochag" class="header__cocial-link header__cocial-facebook" target="_blank">
                <img src="catalog/view/theme/default/image/facebook-f.svg" alt="facebook icon">
              </a>
              <a href="https://www.youtube.com/channel/UCVxvSWSZwYyRyWlYYdklWRA" class="header__cocial-link header__cocial-youtube" target="_blank">
                <img src="catalog/view/theme/default/image/youtube-f.svg" alt="youtube icon">
              </a>
              <a href="https://instagram.com/kavkazkuy_ochag?utm_medium=copy_link" class="header__cocial-link header__cocial-instagram" target="_blank">
                <img src="catalog/view/theme/default/image/instagram-f.svg" alt="instagram icon">
              </a>
              <a href="https://boto.link/l/VmHe" class="header__cocial-link header__cocial-viber" target="_blank">
                <img src="catalog/view/theme/default/image/Viber.svg" alt="Viber icon">
              </a>
              <a href="https://t.me/kavkazkijochag_bot" class="header__cocial-link header__cocial-telegram" target="_blank">
                <img src="catalog/view/theme/default/image/Telegram.svg" alt="Telegram icon">
              </a>
            </div>
            <!--<?php echo $language;?>-->
            <ul class="header__language-list-mob">
                <li class="header__language-item active">
                    <a href="#">рус</a>
                </li>
                <li class="header__language-item">
                    <a href="#">укр</a>
                </li>
                <li class="header__language-item">
                    <a href="#">eng</a>
                </li>
            </ul>
          </div>
        </div>
      </div>
      </div>
    <?php echo $cart; ?>
  </header>

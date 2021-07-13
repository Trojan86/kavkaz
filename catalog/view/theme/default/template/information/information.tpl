<?php echo $header; ?>
<?php if ($catering_href) { ?>
<section class="catering__section">
  <div class="catering__wrap"style="background-image: url(catalog/view/theme/default/img/catering-bg.jpg);">
    <div class="container">
      <div class="catering__top">
        <div class="catering__top-description">
          <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
              <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
                <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
                <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
              </a>
            </li>
            <?php } ?>
          </ul>
          <?php echo $content_top; ?>
        </div>
        <div class="catering__img-box">
          <img class="catering__img" src="catalog/view/theme/default/img/caterin-top-img.png" alt="image">
          <img class="catering__img-laptop" src="catalog/view/theme/default/img/caterin-top-img-laptop.png" alt="image">
          <img class="catering__img-mob" src="catalog/view/theme/default/img/caterin-top-img-mob.png" alt="image">
        </div>
        <img class="catering__img-left" src="catalog/view/theme/default/img/tomato.png" alt="image">
      </div>
    </div>
  </div>
  <div class="container">
    <div class="catering__bottom">
      <div class="catering__description">
        <?php echo $description; ?>
      </div>
      <form id="catering__form" class="catering__order checkout__form-validation">
        <?php echo $column_right; ?>
      </form>
    </div>
  </div>
</section>
<?php } ?>
<?php if ($vacancies_href) { ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<section>
  <div class="container vacancies__container">
    <div class="vacancies__wrap">
      <div class="vacancies__form-wrap">
        <img class="vacancies__img-bg" src="catalog/view/theme/default/img/preview-bg.png" alt="image">
        <form class="vacancies__form form-validation">
          <?php echo $column_left; ?>
        </form>
      </div>
      <div class="vacancies__img-box">
        <?php echo $content_top; ?>
        <?php echo $description; ?>
        <?php echo $content_bottom; ?>
        <?php echo $column_right; ?>
      </div>
    </div>
  </div>
</section>
<?php } elseif ($promotions_href) { ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<div class="container">
  <section>
    <div class="action__wrap">
      <div id="content" class="action__container <?php echo $class; ?>">
        <div class="wrap__title-box">
          <p class="wrap__title"><?php echo $heading_title; ?></p>
        </div>
        <?php echo $content_top; ?>
        <?php echo $description; ?>
        <?php echo $content_bottom; ?>
        <div>
          <div class="delivery__also">
            <?php echo $column_right; ?>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>
<?php } ?>
<?php if ($delivery_href) { ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<div class="container">
  <section>
    <div class="delivery__wrap">
      <div id="content" class="delivery__container <?php echo $class; ?>">
        <?php echo $content_top; ?>
        <?php echo $description; ?>
        <?php echo $content_bottom; ?>
      </div>
      <div>
        <div class="delivery__also">
          <?php echo $column_right; ?>
        </div>
      </div>
    </div>
  </section>
</div>
<?php } ?>
<?php if ($restorans_href) { ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<?php echo $content_top; ?>
<?php echo $description; ?>
<?php echo $content_bottom; ?>
<?php echo $column_right; ?>
<?php echo $column_left; ?>
<?php }?>
<?php if ($about_href) { ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<?php echo $content_top; ?>
<?php echo $description; ?>
<?php echo $content_bottom; ?>
<?php echo $column_right; ?>
<?php echo $column_left; ?>
<?php }?>
<?php if ($contact_href) { ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<?php echo $content_top; ?>
<?php echo $content_bottom; ?>
<?php echo $column_right; ?>
<?php echo $column_left; ?>
<?php }?>
<?php echo $footer; ?>
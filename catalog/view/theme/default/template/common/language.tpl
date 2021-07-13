<?php if (count($languages) > 1) { ?>
<div class="pull-left">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-language">
    <div class="header__top-item header__language-wrap laptop">

      <?php foreach ($languages as $language) { ?>
      <?php if ($language['code'] == $code) { ?>
      <span class="header__language-text"><?php echo $language['name']; ?></span><div class="triangle-btn">
        <img src="catalog/view/theme/default/image/triangle.svg" alt="triangle icon" class="triangle-icon">
      </div>
      <span class="header__language-list-mob"><?php echo $language['name']; ?></span>
      <?php } ?>
      <?php } ?>

      <ul class="dropdown-menu header__language-list">
        <?php foreach ($languages as $language) { ?>
        <li class="header__language-item "><a class="language-select" name="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
    <input type="hidden" name="code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </form>
</div>
<?php } ?>

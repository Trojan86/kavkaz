<script type="text/javascript">
  jQuery(document).ready(function($) {
    var url=document.location.href;
    $.each($(".private__nav-item a"),function(){
      if(this.href==url){$(this).parent().addClass('active');};
    });
  })(jQuery);
</script>
<div class="private__nav-box">
  <div class="private__nav-title">
    <a>
      <img class="private__avatar-image" src="catalog/view/theme/default/img/avatar-1.png" alt="avatar image">
    </a>
    <div class="private__avatar-box">
      <p class="private__avatar-name"><!--<?php echo $firstname; ?>-->111</p>
      <p class="private__avatar-mail"><!--<?php echo $email; ?>-->email</p>
    </div>
  </div>
<div class="private__select-nav select__nav private__nav-list-mob">
  <div class="private__select select__title-box">
    <p class="private__select-title select__title">
      <img src="catalog/view/theme/default/img/user.png" alt="icon" class="private__nav-icon">
      <span>Личные данные</span>
    </p>
    <img class="select__img" src="catalog/view/theme/default/img/triangle.svg"
         alt="triangle images">
  </div>
  <ul class="private__select-nav-list select__nav-list private-nav">
    <li id="private-item-1" class="private__select-nav-item select__nav-item">
      <a class="private-item-link" href="<?php echo $edit; ?>">
        <img src="catalog/view/theme/default/img/user.png" alt="icon" class="private__nav-icon">
        <span><?php echo $text_edit; ?></span>
      </a>
    </li>
    <li id="private-item-2" class="private__select-nav-item select__nav-item">
      <a class="private-item-link" href="<?php echo $password; ?>">
        <img src="catalog/view/theme/default/img/password.png" alt="icon" class="private__nav-icon">
        <span>Сменить пароль</span>
      </a>
    </li>
    <li id="private-item-3" class="private__select-nav-item select__nav-item">
      <a class="private-item-link" href="<?php echo $order; ?>">
        <img src="catalog/view/theme/default/img/time.png" alt="icon" class="private__nav-icon">
        <span>История заказов</span>
      </a>
    </li>
    <li id="private-item-4" class="private__select-nav-item select__nav-item">
      <a class="private-item-link" href="<?php echo $reward; ?>">
        <img src="catalog/view/theme/default/img/discount.png" alt="icon" class="private__nav-icon">
        <span>Бонусная карта и счет</span>
      </a>
    </li>
    <li id="private-item-5" class="private__select-nav-item select__nav-item">
      <a class="private-item-link" href="<?php echo $download; ?>">
        <img src="catalog/view/theme/default/img/gift.png" alt="icon" class="private__nav-icon">
        <span>Персональные предложения</span>
      </a>
    </li>
    <li id="private-item-6" class="private__select-nav-item select__nav-item">
      <a class="private-item-link" href="<?php echo $newsletter; ?>">
        <img src="catalog/view/theme/default/img/id.png" alt="icon" class="private__nav-icon">
        <span>Обращение к директору</span>
      </a>
    </li>
    <li class="private__select-nav-item select__nav-item">
      <a class="private__btn-exit" href="<?php echo $logout; ?>">
        <img src="catalog/view/theme/default/img/exit.png" alt="icon" class="private__nav-icon">
        <span><?php echo $text_logout; ?></span>
      </a>
    </li>
  </ul>
</div>
  <ul class="private__nav-list private-nav">
  <?php if (!$logged) { ?>
    <li class="private__nav-item">
      <a href="<?php echo $login; ?>" class="private-item-link 1">
        <?php echo $text_login; ?>
      </a>
    </li>
    <li class="private__nav-item">
      <a href="<?php echo $register; ?>" class="private-item-link 2">
        <?php echo $text_register; ?>
      </a>
    </li>
    <li class="private__nav-item">
      <a href="<?php echo $forgotten; ?>" class="private-item-link 3">
        <?php echo $text_forgotten; ?>
      </a>
    </li>
    <?php } ?>
    <!--<li class="private__nav-item">
      <a href="<?php echo $account; ?>" class="private-item-link 4">
        <?php echo $text_account; ?>
      </a>
    </li>-->
    <?php if ($logged) { ?>
    <li class="private__nav-item">
      <a href="<?php echo $edit; ?>" class="private-item-link 5">
        <img src="catalog/view/theme/default/img/user.png" alt="icon" class="private__nav-icon">
        <?php echo $text_edit; ?>
      </a>
    </li>
    <li class="private__nav-item">
      <a href="<?php echo $password; ?>" class="private-item-link 6">
        <img src="catalog/view/theme/default/img/password.png" alt="icon" class="private__nav-icon">
        <?php echo $text_password; ?>
      </a>
    </li>
  <?php } ?>
    <!--<li class="private__nav-item">
      <a href="<?php echo $address; ?>" class="private-item-link 7">
        <?php echo $text_address; ?>
      </a>
     </li>
    <li class="private__nav-item">
      <a href="<?php echo $wishlist; ?>" class="private-item-link 8">
        <?php echo $text_wishlist; ?>
      </a>
     </li>-->
    <li class="private__nav-item">
      <a href="<?php echo $order; ?>" class="private-item-link 9">
        <img src="catalog/view/theme/default/img/time.png" alt="icon" class="private__nav-icon">
        <?php echo $text_order; ?>
      </a>
     </li>
    <li class="private__nav-item">
      <img src="catalog/view/theme/default/img/discount.png" alt="icon" class="private__nav-icon">
      <a href="<?php echo $reward; ?>" class="private-item-link 11">
        <?php echo $text_reward; ?>
      </a>
    </li>
    <li class="private__nav-item">
       <a href="<?php echo $download; ?>" class="private-item-link 0">
         <img src="catalog/view/theme/default/img/gift.png" alt="icon" class="private__nav-icon">
         <?php echo $text_download; ?>
       </a>
     </li>
     <!--<li class="private__nav-item">
      <a href="<?php echo $recurring; ?>" class="private-item-link 10">
        <?php echo $text_recurring; ?>
      </a>
    </li>-->
   <!-- <li class="private__nav-item">
      <a href="<?php echo $return; ?>" class="private-item-link 12">
        <?php echo $text_return; ?>
      </a>
    </li>
    <li class="private__nav-item">
      <a href="<?php echo $transaction; ?>" class="private-item-link 13">
        <?php echo $text_transaction; ?>
      </a>
    </li>-->
    <li class="private__nav-item">
      <a href="<?php echo $newsletter; ?>" class="private-item-link 14">
        <img src="catalog/view/theme/default/img/id.png" alt="icon" class="private__nav-icon">
        <?php echo $text_newsletter; ?>
      </a>
    </li>
  <?php if ($logged) { ?>
    <li class="private__nav-item">
      <a href="<?php echo $logout; ?>" class="private-item-link 15">
        <img src="catalog/view/theme/default/img/exit.png" alt="icon" class="private__nav-icon">
        <?php echo $text_logout; ?>
      </a>
    </li>
  <?php } ?>
  </ul>
</div>

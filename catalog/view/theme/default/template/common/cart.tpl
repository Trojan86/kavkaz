<div id="cart__popup" class="cart__wrap">
  <div class="cart__blocker cart__close"></div>
  <div class="cart__container">
    <div class="btn cart__btn-close cart__close"></div>
    <div class="cart__title-wrap">
      <img class="cart__title-img" src="catalog/view/theme/default/image/cart-bl.svg" alt="cart icon">
      <p class="cart__title-text">Корзина<span class="cart__title-counter cart__counter">(<?php echo $count; ?>)</span></p>
    </div>
    <!-- <div class="cart__promo-error-box error">
      <div class="cart__promo-wrap">
        <img class="cart__promo-img" src="catalog/view/theme/default/image/coupon.svg" alt="сupon icon">
        <input class="cart__promo-input" type="text" placeholder="Ввести промокод">
        <input class="btn cart__promo-btn" type="button" value="Ок">
      </div>
      <p class="cart__promo-wrap-error text-danger">Промокод не верный</p>
    </div> -->

    <div class="cart__list-wrap">
      <p class="cart__list-void"><?php echo $text_empty; ?></p>
      <?php if ($products || $vouchers) { ?>
      <?php foreach ($products as $product) { ?>
      <ul class="cart__list">
        <li class="cart__item">
          <div class="cart__img-box">
            <div class="cart__img" alt="product image"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
              <?php } ?></div>
          </div>
          <p class="cart__title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></p>
          <div class="cart__price-info cart__price-info-ps">
            <span class="product__price-sale"><span>120</span>грн</span>
            <span>64</span> грн /<span>100 г</span>
          </div>
          <div class="cart__price-box price-box">
            <div class="cart__input-box input-box">
              <input type="button" value="&#8722" disabled="disabled" class="cart__input-change input-change">
              <input name="quantity" aria-label="quantity" size="2" value="<?php echo $product['quantity']; ?>" type="number"  id="quantity_<?php echo $product['product_id']; ?>" class="amount">
              <input type="button" value="+" class="cart__input-change input-change">
            </div>
            <div class="cart__price-right">
              <div class="cart__price-info cart__price-info-mob">
                <span class="product__price-sale"><span>120</span>грн</span>
                <span>64</span> грн /<span>100 г</span>
              </div>
              <span class="cart__weight weight"><span class ="cart-weight">100</span><span class ="cart-g">г</span></span>
              <p><span class="cart__price price"><?php echo $product['total']; ?></span></p>
            </div>
          </div>
          <div class="btn cart__btn-remove-box"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><span class="cart__btn-remove"></span></button></div>
        </li>
      </ul>
      <?php } ?>
      <?php } ?>
    </div>
    <div class="cart__accompanying-wrap">
      <img class="cart__accompanying-img" src="catalog/view/theme/default/img/accompanying.png" alt="images">
      <div class="cart__accompanying-right">
        <p class="cart__accompanying-title">Не забудьте к заказу также</p>
        <div class="cart__accompanying-btn-box">
          <a href="#" class="btn cart__accompanying-btn">Соус</a>
          <a href="#" class="btn cart__accompanying-btn">Нaпитки</a>
        </div>
      </div>
    </div>
    <div class="cart__total-wrap">
      <p class="cart__total-text">Итого:</p>
      <?php foreach ($totals as $total) { ?>
      <p class="cart__total-price"><?php echo $total['text']; ?></p>
      <?php } ?>

    </div>
    <div class="cart__info-wrap">
      <div class="cart__info-blocker cart__info-close"></div>
      <div class="cart__info" id="cart__info">
        <img class="cart__info-img" src="catalog/view/theme/default/image/info-bl.svg" alt="info icon">
        <span class="cart__info-title">Фактическая сумма может отличаться</span>
        <div class="cart__info-hint">
          <div class="btn cart__info-hint-btn-close cart__info-close"></div>
          <div class="cart__info-hint-title mobile">Фактическая сумма может отличаться</div>
          Ваш заказ взвешивается в готовом виде, кусочки мяса, и овощи на мангале могут немного отличаться по весу в большую или меньшую сторону, что соответственно влияет на окончательную стоимость заказа.
        </div>
      </div>
    </div>
    <a href="<?php echo $checkout; ?>" class="btn cart__bnt-checkout"><?php echo $text_cart; ?></a>
  </div>
</div>
<button  id="cart" title="Cart" class="">
  <div class="cart-container">
    <i class="icon icon-cart"></i>
    <p id="cart-total" class="cart-container-counter cart__counter"><?php echo $count; ?></p>
    <span class="cart__container-sum"><?php echo $text_items; ?></span>
  </div>
</button>
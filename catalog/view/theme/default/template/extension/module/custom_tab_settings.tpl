<section>
  <div class="container">
    <?php $i = 1; ?>
    <div class="assortment__wrap">
      <div class="wrap__title-box">
        <h2 class="wrap__title assortment__wrap-title"><?php echo $heading_title; ?></h2>
        <div class="assortment__input-wrap">
          <div class="assortment__input-box-after"></div>
          <ul class="assortment__input-box input-box nav nav-tabs dragscroll">
            <?php foreach ($tabs as $tab) { ?>
            <li class="assortment-radio-btn <?php echo ($i == 1 ? 'active' : '') ?>"><a href="#tab-<?php echo $tab['tab_id']; ?>" data-toggle="tab"><?php echo $tab['title']; ?></a></li>
            <?php $i++; ?>
            <?php } ?>
          </ul>
        </div>
      </div>
      <?php $i = 1; ?>
      <div class="assortment__list">
        <?php foreach ($tabs as $tab) { ?>
        <div class="product__list <?php echo ($i == 1 ? 'active' : 'disable') ?>" id="tab-<?php echo $tab['tab_id']; ?>">
          <?php foreach ($tab['products'] as $product) { ?>
          <div class="product__item-wrap">
            <div class="product__item">
              <div class="image">
                <a href="<?php echo $product['href']; ?>">
                  <img data-src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="lazy product__img img-responsive" />
                  <?php if ($product['price']) { ?>
                    <?php if ($product['special']) { ?>
                      <div class="product__item-sale--label">
                        Акция
                        <img class="lazy img-discount" aria-hidden="true" data-src="catalog/view/theme/default/image/discount.svg"/>
                      </div>
                    <?php } ?>
                  <?php } ?>
                </a>
              </div>
              <div class="product__description">
                <a class="product__title" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <div class="product__price-info">
                  <?php if ($product['price']) { ?>
                  <?php if (!$product['special']) { ?>
                  <span><span class="static<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                  <?php } else { ?>
                  <span class="product__price-sale" data-price="<?php echo $product['price']; ?>"><span><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?><br></span>
                  <span><span class="static<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"><?php echo $product['special_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                  <?php } ?>
                  <?php } ?>
                  /<span><span class="static_weight<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"><?php echo round($product['weight']); ?></span> г</span>
                </div>
                <div class="product__price-box price-box">
                  <div class="product__input-box input-box">
                    <input type="button" value="&#8722" disabled="disabled" class="product__input-change input-change down<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>">
                    <input name="quantity" aria-label="quantity" size="2" value="<?php echo $product['minimum']; ?>" type="number"  id="quantity_<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>" class="amount quantity<?php echo $product['product_id']; ?>" data-value-min="<?php echo $product['minimum']; ?>" readonly>
                    <input type="button" value="+" class="product__input-change input-change up<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>">
                  </div>
                  <span class="product__weight weight">
                    <span><span class="weight<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"><?php echo round($product['weight']); ?></span> г</span>
                    <i class="cart__info-weight-img icon-info">
                      <div class="cart__info-weight-text"><?php echo $text_cart_info_weight; ?><?php echo round($product['weight']); ?> г</div>
                    </i>
                  </span>
                  <?php if ($product['price']) { ?>
                  <p class="product__price-container">
                    <?php if (!$product['special']) { ?>
                    <span class="product__price price" data-price="<?php echo $product['price']; ?>"><span class="calc<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                    <?php } else { ?>
                    <span class="product__price price" data-price="<?php echo $product['special']; ?>"><span class="calc<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"><?php echo $product['special_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                    <?php } ?>
                  </p>
                  <?php } ?>
                </div>
                <lable class="btn product__add-btn">
                  <i class="cart-icon icon-cart"></i>
                  <input type="button" value="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>',document.getElementById('quantity_<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>').value);" class="button " />
                </lable>
              </div>
            </div>

            <script>
              document.addEventListener('DOMContentLoaded', function () {
                let col = document.querySelector(".static<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>").innerHTML,
                        staticWeight = document.querySelector(".static_weight<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>").innerHTML,
                        tes = "<?php echo $product['minimum']; ?>",
                        btnUp = document.querySelector(".up<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"),
                        calc = document.querySelector(".calc<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"),
                        weight = document.querySelector(".weight<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"),
                        btnDown = document.querySelector(".down<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"),
                        quantity = document.querySelector("#quantity_<?php echo $product['product_id']; ?><?php echo $tab['tab_id']; ?>"),
                        span = document.createElement('span');

                if((+staticWeight) >= 1000) {
                  weight.innerHTML = ((+staticWeight)/1000).toFixed(2);
                  weight.nextSibling.remove();

                  span.innerHTML = 'кг';
                  weight.parentElement.appendChild(span)
                }
                if (tes != 1) {
                  calc.innerHTML = ((+calc.innerHTML) * (+tes)).toFixed(2);
                  weight.innerHTML = ((+weight.innerHTML) * (+tes));
                }

                btnUp.addEventListener("click", (e) => {

                  calc.innerHTML = ((+calc.innerHTML) + (+col)).toFixed(2);
                  if((+staticWeight) * ((+quantity.value)+1) >= 1000) {
                    weight.innerHTML = +((+staticWeight) * ((+quantity.value)+1)/1000).toFixed(2);
                    weight.nextSibling.remove();
                    span.innerHTML = 'кг';
                    weight.parentElement.appendChild(span)
                  } else {
                    weight.innerHTML = +((+weight.innerHTML) + (+staticWeight)).toFixed(2);
                  }
                });

                btnDown.addEventListener("click", (e) =>{
                  if ((+quantity.value) > (+tes)) {
                    btnDown.disabled = true;
                  }
                  calc.innerHTML = ((+calc.innerHTML) - (+col)).toFixed(2);
                  if((+staticWeight) * ((+quantity.value)-1) >= 1000) {
                    weight.innerHTML = +((+staticWeight) * ((+quantity.value)-1)/1000).toFixed(2);
                  } else {
                    span.innerHTML = 'г';
                    weight.parentElement.appendChild(span);
                    weight.innerHTML = +((+staticWeight) * ((+quantity.value)-1)).toFixed(2);
                  }
                });
              });
            </script>

          </div>
          <?php } ?>
          <div class="btn__more">
          <?php foreach ($cats as $cat) { ?>
          <?php if ($tab['tab_id']==$cat['tab_id']) { ?>
          <a href="<?php echo $cat['cat_href']; ?>" class="product__btn-more" id="tab-<?php echo $tab['tab_id']; ?>">Смотреть больше</a>
          <?php } ?>
          <?php } ?>
          </div>
        </div>
        <?php $i++; ?>
        <?php } ?>
      </div>
    </div>
  </div>
</section>
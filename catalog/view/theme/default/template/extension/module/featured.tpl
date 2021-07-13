<section class="featured">
  <div class="container">
    <div class="offer__wrap">
      <div class="offer__title-list">
        <div id="tab-offer-0" class="offer__title-item offer__title-item-first active" data-tab="offer-0"><?php echo $heading_title; ?>
        </div>
        <div id="tab-offer-1" class="offer__title-item" data-tab="offer-1">Новинки</div>
      </div>
      <div id="offer-0" class="offer__list active">
        <div class="product__list dragscroll">
          <?php foreach ($products as $product) { ?>
          <div class="product__item-wrap">
            <div class="product__item">
              <div class="image"><a href="<?php echo $product['href']; ?>">
                <img data-src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="lazy product__img img-responsive" />
                <?php if ($product['price']) { ?>
                  <?php if ($product['special']) { ?>
                    <div class="product__item-sale--label">
                      Акция
                      <img class="lazy img-discount" aria-hidden="true" data-src="catalog/view/theme/default/image/discount.svg"/>
                    </div>
                  <?php } ?>
                <?php } ?>
              </a></div>
              <div class="product__description">
                <a class="product__title" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <div class="product__price-info">
                  <?php if ($product['price']) { ?>
                  <?php if (!$product['special']) { ?>
                  <span><span class="static<?php echo $product['product_id']; ?>"><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                  <?php } else { ?>
                  <span class="product__price-sale" data-price="<?php echo $product['price']; ?>"><span><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?><br></span>
                  <span><span class="static<?php echo $product['product_id']; ?>"><?php echo $product['special_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                  <?php } ?>
                  <?php } ?>
                  /<span><span class="static_weight<?php echo $product['product_id']; ?>"><?php echo round($product['weight']); ?></span> г</span>
                </div>
                <div class="product__price-box price-box">
                  <div class="product__input-box input-box">
                    <input type="button" value="&#8722" disabled="disabled" class="product__input-change input-change down<?php echo $product['product_id']; ?>">
                    <input name="quantity" aria-label="quantity" size="2" value="<?php echo $product['minimum']; ?>" type="number"  id="quantity_<?php echo $product['product_id']; ?>" class="amount quantity<?php echo $product['product_id']; ?>" data-value-min="<?php echo $product['minimum']; ?>" readonly>
                    <input type="button" value="+" class="product__input-change input-change up<?php echo $product['product_id']; ?>">
                  </div>
                  <span class="product__weight weight">
                    <span><span class="weight<?php echo $product['product_id']; ?>"><?php echo round($product['weight']); ?></span> г</span>
                    <i class="cart__info-weight-img icon-info">
                      <div class="cart__info-weight-text"><?php echo $text_cart_info_weight; ?><?php echo round($product['weight']); ?> г</div>
                    </i>
                    </span>
                  <?php if ($product['price']) { ?>
                  <p class="product__price-container">
                    <?php if (!$product['special']) { ?>
                    <span class="product__price price" data-price="<?php echo $product['price']; ?>"><span class="calc<?php echo $product['product_id']; ?>"><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                    <?php } else { ?>
                    <span class="product__price price" data-price="<?php echo $product['special']; ?>"><span class="calc<?php echo $product['product_id']; ?>"><?php echo $product['special_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
                    <?php } ?>
                  </p>
                  <?php } ?>
                </div>
                <lable class="btn product__add-btn">
                  <i class="cart-icon icon-cart"></i>
                  <input type="button" value="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>',document.getElementById('quantity_<?php echo $product['product_id']; ?>').value);" class="button " />
                </lable>
                </div>
            </div>
            <script>
              document.addEventListener('DOMContentLoaded', function () {
                let col = document.querySelector(".static<?php echo $product['product_id']; ?>").innerHTML,
                        staticWeight = document.querySelector(".static_weight<?php echo $product['product_id']; ?>").innerHTML,
                        tes = "<?php echo $product['minimum']; ?>",
                        btnUp = document.querySelector(".up<?php echo $product['product_id']; ?>"),
                        calc = document.querySelector(".calc<?php echo $product['product_id']; ?>"),
                        weight = document.querySelector(".weight<?php echo $product['product_id']; ?>"),
                        btnDown = document.querySelector(".down<?php echo $product['product_id']; ?>"),
                        quantity = document.querySelector("#quantity_<?php echo $product['product_id']; ?>"),
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

            <script>
              $('#tab-offer-0').on("click", function () {
                $('#offer-0').addClass('active');
                $('#tab-offer-0').addClass('active');
                $('#offer-1').removeClass('active');
                $('#tab-offer-1').removeClass('active');
              })

              $('#tab-offer-1').on("click", function () {
                $('#offer-1').addClass('active');
                $('#tab-offer-1').addClass('active');
                $('#offer-0').removeClass('active');
                $('#tab-offer-0').removeClass('active');
              })
            </script>

          </div>

          <?php } ?>
        </div>
      </div>
    </div>
  </div>
</section>
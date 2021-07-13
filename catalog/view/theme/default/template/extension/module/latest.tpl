<section class="latest">
  <div class="container">
    <div class="offer__wrap">
<div id="offer-1" class="offer__list">
  <div class="product__list dragscroll">
    <?php foreach ($products as $product) { ?>
    <div class="product__item-wrap">
      <div class="product__item">
        <div class="image"><a href="<?php echo $product['href']; ?>">
            <img data-src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="lazy product__img img-responsive" />
            <div class="product__item-sale--label"><?php echo $text_new; ?></div>
          </a></div>
        <div class="product__description">
          <a class="product__title" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <div class="product__price-info">
            <?php if ($product['price']) { ?>
            <?php if (!$product['special']) { ?>
            <span><span class="static<?php echo $product['product_id']; ?>"><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
            <?php } else { ?>
            <span class="product__price-sale" data-price="<?php echo $product['price']; ?>"><span><?php echo $product['price_for_calc']; ?></span> <?php echo $product['currency']; ?></span>
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
                <div class="cart__info-weight-text"><?php echo $text_cart_info_weight; ?><?php echo round($product['weight']); ?></div>
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
        $(document).ready(function () {
          let col = $(".static<?php echo $product['product_id']; ?>").text();
          let weight = $(".static_weight<?php echo $product['product_id']; ?>").text();
          let tes = "<?php echo $product['minimum']; ?>";
          if (tes != 1) {
            $(".calc<?php echo $product['product_id']; ?>").text((i, val) => +val * (+tes));
            $(".weight<?php echo $product['product_id']; ?>").text((i,val) => +val * (+tes));
          }
          $(".up<?php echo $product['product_id']; ?>").click(function () {

            $(".calc<?php echo $product['product_id']; ?>").text((i, val) => +val + (+col));
            $(".weight<?php echo $product['product_id']; ?>").text((i,val) => +val + (+weight));
          });
          $(".down<?php echo $product['product_id']; ?>").click(function () {
            $(".calc<?php echo $product['product_id']; ?>").text((i, val) => +val - (+col));
            $(".weight<?php echo $product['product_id']; ?>").text((i,val) => +val - (+weight));
          });
        });
      </script>
    </div>

    <?php } ?>
  </div>
</div>
    </div>
  </div>
</section>
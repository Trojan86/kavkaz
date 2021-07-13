<?php echo $header; ?>
<div class="container">
  <ul  class="breadcrumbs__list" itemscope itemtype="https://schema.org/BreadcrumbList">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
      <a href="<?php echo $breadcrumb['href']; ?>"  title="<?php echo $breadcrumb['text']; ?>" itemprop="item">
        <span class="breadcrumbs__item-text" itemprop="name"><?php echo $breadcrumb['text']; ?></span>
        <meta itemprop="position" content="<?php $num=-1; echo $num+=1; ?>">
      </a>
    </li>
    <?php } ?>
  </ul>
</div>
<section>
  <div class="container">
    <div class="catalog__wrap">
      <div class="wrap__title-box">
        <h2 class="wrap__title"><?php echo $heading_title; ?></h2>
      </div>
      <div class="catalog__filter-box">
        <div class="catalog__input-box input-box">
          <?php if ($categories) { ?>
              <ul>
                <li class="catalog-radio-btn active"><a href="#">Все</a></li>
                  <?php foreach ($categories as $category) { ?>
                    <li class="catalog-radio-btn"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                  <?php } ?>
                </ul>
          <?php } ?>
        </div>
        <?php if ($products) { ?>
        <div class="catalog__selected select__nav">
          <div class="checkout__select select__title-box">
            <img class="select__img-mob" src="catalog/view/theme/default/img/select-filter.png" alt="filter icon">

            <img class="select__img" src="catalog/view/theme/default/img/triangle.svg" alt="triangle images">

          <select id="input-sort" class="form-control" onchange="location = this.value;">
          <ul class="select__nav-list">
            <?php foreach ($sorts as $sorts) { ?>
              <li class="checkout__select-nav-item">
                <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                <option class="checkout__select-nav-item select__nav-item" href="<?php echo $sorts['href']; ?>" value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                <?php } else { ?>
                <option class="checkout__select-nav-item select__nav-item" href="<?php echo $sorts['href']; ?>" value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                <?php } ?>
              </li>
            <?php } ?>
          </ul>
          </select>
        </div>
        </div>
      </div>
      <div class="catalog__main">
        <div class="catalog__nav desktop">
          <?php echo $column_left; ?>
        </div>
        <div class="catalog__list">
          <div class="product__list">
            <?php foreach ($products as $product) { ?>
            <div class="product__item-wrap">
              <div class="product__item">
                <div class="image"><a href="<?php echo $product['href']; ?>">
                  <img class="lazy product__img" data-src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
                  <?php if ($product['price']) { ?>
                    <?php if ($product['special']) { ?>
                      <div class="product__item-sale--label">Акция                        <img class="lazy img-discount" aria-hidden="true" data-src="catalog/view/theme/default/image/discount.svg"/>
                      </div>
                    <?php } ?>
                  <?php } ?>
                </a></div>
                <div class="product__description">
                  <p class="product__title"><?php echo $product['name']; ?></p>
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
                    <span class="product__weight weight" >
                      <span><span class="weight<?php echo $product['product_id']; ?>"><?php echo round($product['weight']); ?></span> г</span>
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
            </div>
            <?php } ?>
            <div class="row">
              <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
              <!--<div class="col-sm-6 text-right"><?php echo $results; ?></div>-->
            </div>
            <?php } ?>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<?php echo $footer; ?>

  <!-- <select onchange="location = this.value;">
    <ul class="select__nav-list">
      <?php foreach ($sorts as $sorts) { ?>
      <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
      <option class="checkout__select-nav-item select__nav-item" value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
      <?php } else { ?>
      <option class="checkout__select-nav-item select__nav-item" value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
      <?php } ?>
      <?php } ?>
    </ul>
  </select> -->
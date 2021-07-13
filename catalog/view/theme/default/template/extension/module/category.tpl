  

  <ul class="catalog__nav-list">
    <?php foreach ($categories as $category) { ?>
    <?php if ($category['category_id'] == $category_id) { ?>
    <li class="catalog__nav-item active">
      <a href="<?php echo $category['href']; ?>">
        <div class="catalog__nav-item-border">
          <img class="catalog__nav-icon" src="<?php echo $category['icon']; ?>" alt="product icon">
          <span class="catalog__nav-title"><?php echo $category['name']; ?> </span>
        </div>
      </a>
    </li>
    <!--<?php if ($category['children']) { ?>
    <?php foreach ($category['children'] as $child) { ?>
    <?php if ($child['category_id'] == $child_id) { ?>
    <li class="catalog__nav-item">
      <a href="<?php echo $child['href']; ?>">
        <div class="catalog__nav-item-border">
          <img class="catalog__nav-icon" src="catalog/view/theme/default/img/nav-icon-w-1.png" alt="product icon">
          <span class="catalog__nav-title"><?php echo $child['name']; ?></span>
        </div>
      </a>
    </li>
    <?php } else { ?>
    <li class="catalog__nav-item">
      <a href="<?php echo $child['href']; ?>">
        <div class="catalog__nav-item-border">
          <img class="catalog__nav-icon" src="catalog/view/theme/default/img/nav-icon-w-1.png" alt="product icon">
          <span class="catalog__nav-title"><?php echo $child['name']; ?></span>
        </div>
      </a>
    </li>
    <?php } ?>
    <?php } ?>
    <?php } ?>-->
    <?php } else { ?>
    <li class="catalog__nav-item">
      <a href="<?php echo $category['href']; ?>">
        <div class="catalog__nav-item-border">
          <img class="catalog__nav-icon" src="<?php echo $category['icon']; ?>" alt="product icon">
          <span class="catalog__nav-title"><?php echo $category['name']; ?> </span>
        </div>
      </a>
    </li>
    <?php } ?>
    <?php } ?>
  </ul>
    <!--<?php foreach ($products as $product) { ?>
    <div class="product__item-wrap">
        <div class="product__item">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="product__img img-responsive" /></a></div>
            <div class="product__description">
                <a class="product__title" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <div class="product__price-box price-box">
                    <div class="product__input-box input-box">
                        <input type="button" value="−" disabled="disabled" class="product__input-change input-change">
                        <input value="1" type="number" class="amount">
                        <input type="button" value="+" class="product__input-change input-change">
                    </div>
                    <!-- НУЖНО ДОБАВИТЬ ПЕРЕМЕННЫЕ
                    <span class="product__weight weight">
                    <?php echo round($product['weight']); ?>г
                    <img class="cart__info-weight-img" src="catalog/view/theme/default/image/info.svg" alt="info icon">
                    <div class="cart__info-weight-text">Минимальный заказ <?php echo round($product['weight']); ?>г</div>
                </span>
                    <p><span class="product__price price" data-price="<?php echo $product['price']; ?>"><?php echo $product['price']; ?></span></p>
                    <!--<p><?php echo $product['description']; ?></p>
                    <?php if ($product['rating']) { ?>
                    <div class="rating">
                      <?php for ($i = 1; $i <= 5; $i++) { ?>
                      <?php if ($product['rating'] < $i) { ?>
                      <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                      <?php } else { ?>
                      <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                      <?php } ?>
                      <?php } ?>
                    </div>
                    <?php } ?>
                    <?php if ($product['price']) { ?>
                    <p class="price">
                      <?php if (!$product['special']) { ?>
                      <?php echo $product['price']; ?>
                      <?php } else { ?>
                      <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                      <?php } ?>
                      <?php if ($product['tax']) { ?>
                      <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                      <?php } ?>
                    </p>
                    <?php } ?>
                </div>
                <button class="btn product__add-btn" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                <!--<button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
            </div>
        </div>
    </div>
    <?php } ?>-->
  <script>
      $('.catalog__nav-item').each( function () {
        if ($(this).find('.catalog__nav-title').text().includes("(0)")){
          $(this).hide();
        }
      });
  </script>
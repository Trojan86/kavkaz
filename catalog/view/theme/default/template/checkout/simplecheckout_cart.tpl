<div class="simplecheckout-block" id="simplecheckout_cart" <?php echo $hide ? 'data-hide="true"' : '' ?> <?php echo $has_error ? 'data-error="true"' : '' ?>>
<?php if ($display_header) { ?>
<div class="checkout-heading panel-heading"><?php echo $text_cart ?> <span class="checkout-heading-button"><a href="javascript:void(0)" data-onclick="clearCart" class="text-danger" data-confirm-text="<?php echo $text_clear_cart_question ?>"><?php echo $text_clear_cart ?></a></span></div>
<?php } ?>
<?php if ($attention) { ?>
<div class="alert alert-danger simplecheckout-warning-block"><?php echo $attention; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="alert alert-danger simplecheckout-warning-block"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="table-responsive">
    <div class="checkout__cart-mob active" >
        <div class="checkout__cart-counter">
            <img class="checkout__cart-counter-img" src="catalog/view/theme/default/img/cart-w.svg" alt="">
            <?php foreach ($products as $product) { ?>
            <div class="checkout__cart-counter-title cart__counter"><?php echo $product['counts'] ?></div>
            <?php } ?>
        </div>
        <p class="checkout__btn-title" data-open="Развернуть заказ" data-close="Свернуть заказ">Свернуть заказ</p>
        <img class="checkout__cart-counter-triangle" src="catalog/view/theme/default/img/triangle.svg" alt="icon triangle">
    </div>

    <table class="simplecheckout-cart active">
        <colgroup>
            <col class="image">
            <col class="name">
            <col class="model">
            <col class="quantity">
            <col class="cart__weight weight">
            <col class="price">
            <col class="total">
            <col class="remove">
        </colgroup>
        <thead>
        <tr>
            <th class="image"><?php echo $column_image; ?></th>
            <th class="name"><?php echo $column_name; ?></th>
            <th class="model"><?php echo $column_model; ?></th>
            <th class="quantity"><?php echo $column_quantity; ?></th>
            <th class="cart__weight weight">104</th>
            <th class="price"><?php echo $column_price; ?></th>
            <th class="total"><?php echo $column_total; ?></th>
            <th class="remove"></th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($products as $product) { ?>
        <tr>
            <td class="image">
                <?php if ($product['thumb']) { ?>
                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                <?php } ?>
            </td>
            <td class="cart__price-info cart__price-info-ps">
                <?php if ($product['old_price']) { ?>
                <span class="product__price-sale"><span><?php echo $product['old_price'] ?></span><br></span>
                <?php } ?>
                <span><?php echo $product['price'] ?></span> /<span><?php echo $product['weight_product'] ?></span>
            </td>
            <td class="name">
                <?php if ($product['thumb']) { ?>
                <div class="image">
                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                </div>
                <?php } ?>
                <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                <?php if (!$product['stock'] && ($config_stock_warning || !$config_stock_checkout)) { ?>
                <span class="product-warning">***</span>
                <?php } ?>
                <div class="options">
                    <?php foreach ($product['option'] as $option) { ?>
                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                    <?php } ?>
                    <?php if (!empty($product['recurring'])) { ?>
                    - <small><?php echo $text_recurring_item ?>: <?php echo $product['recurring'] ?></small>
                    <?php } ?>
                </div>
                <?php if ($product['reward']) { ?>
                <small><?php echo $product['reward']; ?></small>
                <?php } ?>
            </td>
            <td class="model"><?php echo $product['model']; ?></td>
            <td class="quantity">
                <div class="input-group btn-block" style="max-width: 200px;">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="decreaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </span>
                    <input disabled class="form-control" type="text" data-onchange="changeProductQuantity" <?php echo $quantity_step_as_minimum ? 'data-minimum="' . $product['minimum'] . '"' : '' ?> name="quantity[<?php echo !empty($product['cart_id']) ? $product['cart_id'] : $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" />
                    <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="increaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </span>
                </div>
            </td>
            <td class="cart__weight weight"><span>
                                                      <span class="opacity06"><?php echo $product['weight_total'] ?> <?php echo $product['cart_weight']; ?></span>
                                                    <img class="cart__info-weight-img" src="catalog/view/theme/default/img/info.svg" alt="info icon">
                                                    <div class="cart__info-weight-text">Минимальный заказ <?php echo $product['weight_product'] ?></div>
                                                </span></td>
            <td class="cart__price price">
                <?php if (!empty($product['old_price'])) { ?><div style="text-decoration: line-through;"><?php echo $product['old_price']; ?></div><?php } ?>
                <div><?php echo $product['price']; ?></div>
            </td>
            <td class="total"><?php echo $product['total']; ?></td>
            <td class="remove"><span class="cart__btn-remove" data-onclick="removeProduct" data-product-key="<?php echo !empty($product['cart_id']) ? $product['cart_id'] : $product['key'] ?>" data-toggle="tooltip"></span></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher_info) { ?>
        <tr>
            <td class="image"></td>
            <td class="name"><?php echo $voucher_info['description']; ?></td>
            <td class="model"></td>
            <td class="quantity">
                <div class="input-group btn-block" style="max-width: 200px;">
                    <input class="form-control" type="text" value="1" disabled size="1" />
                    <span class="input-group-btn">
                                    <button class="btn btn-danger" data-onclick="removeGift" data-gift-key="<?php echo $voucher_info['key']; ?>" type="button">
                                        <i class="fa fa-times-circle"></i>
                                    </button>
                                </span>
                </div>
            </td>
            <td class="price"><?php echo $voucher_info['amount']; ?></td>
            <td class="total"><?php echo $voucher_info['amount']; ?></td>
            <td class="remove"></td>
        </tr>
        <?php } ?>
        </tbody>
    </table>
    <ul class="accompanying__list active">
        <table class="simplecheckout-cart ">
            <tbody>
            <tr class="lavash">
                <td class="image">
                    <a href="#"><img src="catalog/view/theme/default/img/product-0.jpg" alt="Лаваш" title="Лаваш" /></a>
                </td>
                <!--<td class="cart__price-info cart__price-info-ps">

                    <span class="product__price-sale"><span>1</span></span>

                    <span>1</span> /1 г</span>
                </td>-->
                <td class="name">
                    <div class="image">
                        <a href="#"><img src="catalog/view/theme/default/img/product-0.jpg" alt="Лаваш" title="Лаваш" /></a>
                    </div>
                    <a href="#">Лаваш</a>
                </td>
                <td class="model">Лаваш</td>
                <td class="quantity">
                    <div class="input-group btn-block" style="max-width: 200px;">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="decreaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </span>
                        <input class="form-control" type="text" data-onchange="changeProductQuantity" <?php echo $quantity_step_as_minimum ? 'data-minimum="' . $product['minimum'] . '"' : '' ?> name="quantity[<?php echo !empty($product['cart_id']) ? $product['cart_id'] : $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" />
                        <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="increaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </span>
                    </div>
                </td>
                <td class="cart__weight weight"><span>
                                                    200г
                                                    <img class="cart__info-weight-img" src="catalog/view/theme/default/img/info.svg" alt="info icon">
                                                    <div class="cart__info-weight-text">Минимальный заказ 200 г</div>
                                                </span></td>
                <td class="cart__price price">
                    <div style="text-decoration: line-through;">Бесплатно</div>
                    <div>Бесплатно</div>
                </td>
                <td class="total">Бесплатно</td>
                <td class="remove"><span class="cart__btn-remove" data-onclick="" data-product-key="#" data-toggle="tooltip"></span></td>
            </tr>
            <tr class="pribori">
                <td class="image">
                    <a href="#"><img src="catalog/view/theme/default/img/product-0.jpg" alt="Лаваш" title="Лаваш" /></a>
                </td>
                <!--<td class="cart__price-info cart__price-info-ps">

                    <span class="product__price-sale"><span>1</span></span>

                    <span>1</span> /1 г</span>
                </td>-->
                <td class="name">
                    <div class="image">
                        <a href="#"><img src="catalog/view/theme/default/img/product-0.jpg" alt="Приборы" title="Приборы" /></a>
                    </div>
                    <a href="#">Приборы</a>
                </td>
                <td class="model">Приборы</td>
                <td class="quantity">
                    <div class="input-group btn-block" style="max-width: 200px;">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="decreaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </span>
                        <input class="form-control" type="text" data-onchange="changeProductQuantity" <?php echo $quantity_step_as_minimum ? 'data-minimum="' . $product['minimum'] . '"' : '' ?> name="quantity[<?php echo !empty($product['cart_id']) ? $product['cart_id'] : $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" />
                        <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="increaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </span>
                    </div>
                </td>
                <td class="cart__weight weight"><span>
                                                    200г
                                                    <img class="cart__info-weight-img" src="catalog/view/theme/default/img/info.svg" alt="info icon">
                                                    <div class="cart__info-weight-text">Минимальный заказ 200 г</div>
                                                </span></td>
                <td class="cart__price price">
                    <div style="text-decoration: line-through;">Бесплатно</div>
                    <div>Бесплатно</div>
                </td>
                <td class="total">Бесплатно</td>
                <td class="remove"><span class="cart__btn-remove" data-onclick="" data-product-key="#" data-toggle="tooltip"></span></td>
            </tr>
            </tbody>
        </table>
    </ul>
</div>

<?php foreach ($totals as $total) { ?>
<div class="simplecheckout-cart-total" id="total_<?php echo $total['code']; ?>">
    <span><?php echo $total['title']; ?>:</span>
    <span class="simplecheckout-cart-total-value"><?php echo $total['text']; ?></span>
    <span class="simplecheckout-cart-total-remove">
            <?php if ($total['code'] == 'coupon') { ?>
        <i data-onclick="removeCoupon" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
        <?php } ?>
        <?php if ($total['code'] == 'voucher') { ?>
        <i data-onclick="removeVoucher" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
        <?php } ?>
        <?php if ($total['code'] == 'reward') { ?>
        <i data-onclick="removeReward" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
        <?php } ?>
        </span>
</div>
<?php } ?>
<div class="cart__info-wrap">
    <div class="cart__info-blocker cart__info-close"></div>
    <div class="cart__info checkout__info"  onclick="if ($(window).width() <= '600') { if ($('.cart__info-wrap').hasClass('active')){ $('.cart__info-wrap').removeClass('active')} else { $('.cart__info-wrap').addClass('active') }}">
        <img class="cart__info-img" src="catalog/view/theme/default/img/info.svg" alt="info icon">
        <span class="cart__info-title checkout__info-title"><?php echo $title__info; ?></span>
        <div class="cart__info-hint">
            <div class="btn cart__info-hint-btn-close cart__info-close"></div>
            <div class="cart__info-hint-title mobile"><?php echo $title__info; ?></div>
            <?php echo $description__info; ?>
        </div>
    </div>
</div>
<?php if (isset($modules['coupon'])) { ?>
<div class="simplecheckout-cart-total">
    <div class="cart__promo-box">
        <div class="checkout__promo-wrap">
            <svg class="checkout__promo-img" alt="сupon icon" width="24" height="15" viewBox="0 0 24 15" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M21.8848 0.488525H8.62313C8.43747 0.488525 8.26018 0.558088 8.12896 0.68015L7.22716 1.52934L6.32537 0.68015C6.19415 0.558088 6.01686 0.488525 5.8312 0.488525H2.34128C1.5721 0.488525 0.945312 1.07784 0.945312 1.80103V13.6135C0.945312 14.338 1.5721 14.926 2.34128 14.926H5.8312C6.01686 14.926 6.19415 14.8565 6.32537 14.7344L7.22716 13.8852L8.12896 14.7331C8.26018 14.8565 8.43747 14.926 8.62313 14.926H21.8848C22.6554 14.926 23.2808 14.338 23.2808 13.6135V1.80103C23.2808 1.07784 22.6554 0.488525 21.8848 0.488525ZM7.92515 12.301H6.52918V10.9885H7.92515V12.301ZM7.92515 9.67603H6.52918V8.36353H7.92515V9.67603ZM7.92515 7.05103H6.52918V5.73853H7.92515V7.05103ZM7.92515 4.42603H6.52918V3.11353H7.92515V4.42603ZM12.811 3.11353C13.9655 3.11353 14.905 3.99684 14.905 5.08228C14.905 6.16771 13.9655 7.05103 12.811 7.05103C11.6566 7.05103 10.7171 6.16771 10.7171 5.08228C10.7171 3.99684 11.6566 3.11353 12.811 3.11353ZM11.4151 12.301C11.2573 12.301 11.0996 12.2512 10.9684 12.1488C10.6724 11.9165 10.6319 11.503 10.879 11.2248L17.8588 3.34978C18.1073 3.07021 18.5471 3.03609 18.8416 3.26578C19.1376 3.49809 19.1766 3.91153 18.9296 4.19109L11.9497 12.0661C11.8129 12.2197 11.6147 12.301 11.4151 12.301ZM16.9989 12.301C15.8445 12.301 14.905 11.4177 14.905 10.3323C14.905 9.24684 15.8445 8.36353 16.9989 8.36353C18.1534 8.36353 19.0929 9.24684 19.0929 10.3323C19.0929 11.4177 18.1534 12.301 16.9989 12.301Z" fill="white"></path>
            </svg>
            <input class="form-control checkout__promo-input" type="text" placeholder="Ввести промокод" data-onchange="" name="coupon" value="<?php echo $coupon; ?>" id="input-coupon" />
            <?php if (isset($modules['coupon']) || (isset($modules['reward']) && $points > 0) || isset($modules['voucher'])) { ?>
            <div class="simplecheckout-cart-total simplecheckout-cart-buttons">
                <span class="inputs buttons">
                    <a id="simplecheckout_button_cart" data-onclick="reloadAll" class="button btn-primary button_oc btn"><span><?php echo $button_update; ?></span>
                    </a>
                </span>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>

<input type="hidden" name="remove" value="" id="simplecheckout_remove">
<div style="display:none;" id="simplecheckout_cart_total"><?php echo $cart_total ?></div>
<?php if ($display_weight) { ?>
<div style="display:none;" id="simplecheckout_cart_weight"><?php echo $weight ?></div>
<?php } ?>
<?php if (!$display_model) { ?>
<style>
    .simplecheckout-cart col.model,
    .simplecheckout-cart th.model,
    .simplecheckout-cart td.model {
        display: none;
    }
</style>

<script>
    $(document).ready(function () {
        var checkoutCartMob = $('.checkout__cart-mob'),
            listProduct = $('.simplecheckout-cart'),
            accomanying = $('.accompanying__list'),
            checkoutBtnTitle = $('.checkout__btn-title'),
            dataOpen = checkoutBtnTitle.attr('data-open'),
            dataClose = checkoutBtnTitle.attr('data-close');

        checkoutCartMob.on("click", function () {
            if (checkoutCartMob.hasClass("active") || listProduct.hasClass("active") || accomanying.hasClass("active")){
                checkoutCartMob.removeClass("active");
                listProduct.removeClass("active");
                accomanying.removeClass("active");
                checkoutBtnTitle.text(dataOpen);
            } else {
                checkoutCartMob.addClass("active");
                listProduct.addClass("active");
                accomanying.addClass("active");
                checkoutBtnTitle.text(dataClose);
            }
        });
    });
</script>
<script type="text/javascript"><!--
    $('#simplecheckout_button_cart').on('click', function() {
        $.ajax({
            url: 'index.php?route=extension/total/coupon/coupon',
            type: 'post',
            data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
            dataType: 'json',
            beforeSend: function() {
                $('#simplecheckout_button_cart').button('loading');
            },
            complete: function() {
                $('#simplecheckout_button_cart').button('reset');
            },
            success: function(json) {

                if (json['error']) {
                    $('.promo-error').fadeIn(1000);
                    setTimeout(function() {
                        $('.promo-error').fadeOut(500);
                    }, 2500);
                }

                if (json['redirect']) {
                    $('.promo-finish').fadeIn(1000);
                    setTimeout(function() {
                        $('.promo-finish').fadeOut(500);
                    }, 2500);
                }
            }
        });
    });
    //--></script>

<script>
    $('.lavash').find('.remove').on('click', function () {
        $('.lavash').hide();
    })

    $('.pribori').find('.remove').on('click', function () {
        $('.pribori').hide();
    })

    if (($('.lavash').css('display') == 'none') && ($('.pribori').css('display') == 'none')){
        $('.accompanying__list').removeClass('active');
    }
</script>
<?php } ?>
</div>

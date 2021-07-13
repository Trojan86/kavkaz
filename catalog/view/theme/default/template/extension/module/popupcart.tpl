<div id="popupcart_extended" class="cart__wrap">
	<div class="cart__blocker cart__close" onclick="$('#popupcart_extended').popup('hide')"></div>
	<div class="cart__container">
		<div class="btn cart__btn-close cart__close" onclick="$('#popupcart_extended').popup('hide')"></div>
		<div class="cart__title-wrap">
			<img class="cart__title-img" src="catalog/view/theme/default/image/cart-bl.svg" alt="cart icon">
			<p class="cart__title-text"><?php echo $head; ?><span class="cart__title-counter cart__counter">(<?php echo $count; ?>)</span></p>

		</div>
		<div class="cart__list-wrap">
			<?php if ($products || $vouchers) { ?>
			<?php foreach ($products as $key => $product) { ?>
			<ul class="cart__list">
				<li class="cart__item">
					<div class="cart__img-box">
						<div class="cart__img" alt="product image">
							<?php if ($product['thumb']) { ?>
							<span>
								<img src="<?php echo $product['thumb']; ?>" onclick="location='<?php echo $product['href']; ?>'" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
							</span>
							<?php } ?>
						</div>
					</div>
					<p class="cart__title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></p>
					<div class="cart__price-info cart__price-info-ps">
						<?php if ($product['price']) { ?>
						<?php if (!$product['special']) { ?>
						<span class="static<?php echo $product_id; ?>"><?php echo $product['price']; ?></span>&nbsp;/ <span class="static_weight<?php echo $product_id; ?>"><?php echo round($product['weight']); ?> г</span>
						<?php } else { ?>
						<span class="product__price-sale" data-price="<?php echo $price; ?>"><span><?php echo $product['price_old']; ?></span></span>
						<span class="static<?php echo $product_id; ?>"><?php echo $product['special']; ?></span> /<span class="static_weight<?php echo $product_id; ?>"><?php echo round($product['weight']); ?> г</span>
						<?php } ?>
						<?php } ?>
					</div>
					<div class="cart__price-info cart__price-info-mob">
						<?php if ($product['price']) { ?>
						<?php if (!$product['special']) { ?>
						<span class="static<?php echo $product_id; ?>"><?php echo $product['price']; ?></span>&nbsp;/ <span class="static_weight<?php echo $product_id; ?>"><?php echo round($product['weight']); ?> г</span>
						<?php } else { ?>
						<span class="product__price-sale" data-price="<?php echo $price; ?>"><span><?php echo $product['price_old']; ?></span></span>
						<span class="static<?php echo $product_id; ?>"><?php echo $product['special']; ?></span> /<span class="static_weight<?php echo $product_id; ?>"><?php echo round($product['weight']); ?> г</span>
						<?php } ?>
						<?php } ?>
					</div>
					<div class="cart__price-box price-box">
						<div class="cart__input-box input-box">
							<?php if (!$product['stock']) { ?>
							<?php if ($product['quantity'] > 1) { ?>
							<input type="button" value="&#8722" class="cart__input-change input-change" onclick="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '-')">
							<?php } else { ?>
							<input type="button" value="-" class="cart__input-change input-change" style="opacity:0.5; cursor:default">
							<?php } ?>
							<?php } ?>
							<input type="text" name="<?php echo $product['key']; ?>" size="2" value="<?php echo $product['quantity']; ?>" onchange="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>')" class="amount pr<?php echo $product['id']; ?>" disabled />
							<input type="button" value="+" class="cart__input-change input-change" onclick="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '+')">
						</div>
						<div class="cart__price-right">
							<span class="cart__weight weight"><span class ="cart-weight weight<?php echo $product['product_id']; ?>"><?php echo round($product['total_weight']); ?></span><span class ="cart-g">г</span></span>
							<p><span class="cart__price price calc<?php echo $product_id; ?>"><?php echo $product['total']; ?></span></p>
						</div>
					</div>
					<div class="btn cart__btn-remove-box"><button type="button" onclick="$('.pr<?php echo $product['id']; ?>').val(''); updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>')" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><span class="cart__btn-remove"></span></button></div>
				</li>
			</ul>
			<?php } ?>
			<?php } ?>

		<?php if ($products || $vouchers) { ?>
		<!--<div class="popupcart_info">
			<table>
				<tr>
					<td class="image"><?php echo $text_foto; ?></td>
					<td class="name"><?php echo $text_name ?></td>
					<?php if ($manufacturer_show) { ?>
						<td class="brand"><?php echo $text_manufacturer; ?></td>
					<?php } ?>
					<td class="quantity"><?php echo $text_quantity; ?></td>
					<td class="price"><?php echo $text_price; ?></td>
					<td></td>
				</tr>
				<tr class="hr"><td colspan="6"></td></tr>
				<?php foreach ($products as $key => $product) { ?>
				<tr class="row_<?php echo $key; ?>_<?php echo $product['id']; ?>">
					<td class="image">
						<?php if ($product['thumb']) { ?>
						<img src="<?php echo $product['thumb']; ?>" onclick="location='<?php echo $product['href']; ?>'" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
						<?php } ?>
					</td>
					<td class="name">
						<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
						<div>
							<?php foreach ($product['option'] as $option) { ?>
							- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
							<?php } ?>
						</div>
						<?php if (!$product['stock']) { ?>
						<?php if ($product['quantity'] >= $product['maximum']) { ?>
						<span style="font-size:10px; color:#f00;"><?php echo $in_stock; ?> <?php echo ($product['maximum'] > 1) ? $left : $left1; ?> <?php echo $just; ?> <?php echo $product['maximum']; ?> <?php echo $pcs; ?></span>
						<?php } ?>
						<?php } ?>
					</td>
					<?php if ($manufacturer_show) { ?>
					<td class="brand"><?php echo $product['manufacturer']; ?></td>
					<?php } ?>
					<td class="quantity">
						<div>
							<input type="text" name="<?php echo $product['key']; ?>" size="2" value="<?php echo $product['quantity']; ?>" onchange="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>')" />
							<span>
									<?php if (!$product['stock']) { ?>
								<?php if ($product['quantity'] < $product['maximum']) { ?>
								<i class="fa fa-plus" onclick="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '+')"></i>
								<?php } else { ?>
								<i class="fa fa-plus" style="opacity:0.5; cursor:default"></i>
								<?php } ?>
								<?php } else { ?>
								<i class="fa fa-plus" onclick="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '+')"></i>
								<?php } ?>
								<i class="fa fa-minus" onclick="updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>', '-')"></i>
								</span>
						</div>
					</td>
					<td class="price"><?php echo $product['total']; ?></td>
					<td class="remove"><i class="fa fa-trash-o" title="<?php echo $button_remove; ?>" onclick="$(this).parent().prev().prev().find('input').val(''); updateCart(this,'<?php echo $product['id']; ?>', '<?php echo $product['key']; ?>')" ></i></td>
				</tr>
				<tr class="hr"><td colspan="6"></td></tr>
				<?php } ?>
			</table
		</div>-->
		</div>
		<div class="cart__accompanying-wrap">
			<img class="cart__accompanying-img" src="catalog/view/theme/default/img/accompanying.png" alt="images">
			<div class="cart__accompanying-right">
				<p class="cart__accompanying-title"><?php echo $text_info_btn; ?></p>
				<div class="cart__accompanying-btn-box">
					<a href="/index.php?route=product/category&path=72" class="btn cart__accompanying-btn"><?php echo $text_btn_l ?></a>
					<a href="/index.php?route=product/category&path=81" class="btn cart__accompanying-btn"><?php echo $text_btn_r ?></a>
				</div>
			</div>
		</div>
		<div class="popupcart_total">
			<table>
				<?php foreach($totals as $total) { ?>
				<tr>
					<td class="right"><?php echo $total['title']; ?>:</td><td class="right"><?php echo $total['text']; ?></td>
				</tr>
				<?php } ?>
			</table>
		</div>
		<div class="cart__info-wrap">
			<div class="cart__info-blocker cart__info-close"></div>
			<div class="cart__info" id="cart__info" onclick="if ($(window).width() <= '600') { if ($('.cart__info-wrap').hasClass('active')){ $('.cart__info-wrap').removeClass('active')} else { $('.cart__info-wrap').addClass('active') }}">
				<img class="cart__info-img" src="catalog/view/theme/default/img/info-bl.svg" alt="info icon">
				<span class="cart__info-title"><?php echo $text_information_title; ?></span>
				<div class="cart__info-hint">
					<div class="btn cart__info-hint-btn-close cart__info-close"></div>
					<div class="cart__info-hint-title mobile"><?php echo $text_information_title; ?></div>
					<?php echo $text_information_text; ?>
				</div>
			</div>
		</div>
		<div class="popupcart_buttons">
			<?php if($button_shopping_show) { ?>
			<button type="button" class="button btn btn-primary btn-lg" onclick="$('#popupcart_extended').popup('hide')" ><?php echo $button_shopping; ?></button>
			<?php } else { ?>
			<!--<a class="continue" onclick="$('#popupcart_extended').popup('hide')"><?php echo $button_shopping; ?></a>-->
			<?php } ?>
			<?php if ($button_cart_show) { ?>
			<button type="button" class="cont button btn btn-primary btn-lg" onclick="location='<?php echo $cart; ?>'" ><?php echo $button_cart; ?></button>
			<?php } ?>
			<button type="button" class="button btn btn-primary btn-lg cart__bnt-checkout" onclick="location='<?php echo $checkout; ?>'"><?php echo $button_checkout; ?></button>
		</div>
		<?php if($products_related) { ?>
		<div id="related">
			<div class="heading"><?php echo $text_related; ?></div>
			<div class="related_product">
				<?php foreach ($products_related as $product) { ?>
				<div>
					<?php if ($product['thumb']) { ?>
					<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
					<?php } ?>
					<div>
						<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
						<?php if ($product['price']) { ?>
						<div class="price">
							<?php if (!$product['special']) { ?>
							<?php echo $product['price']; ?>
							<?php } else { ?>
							<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
							<?php } ?>
						</div>
						<?php } ?>
						<div class="cart static<?php echo $product['product_id']; ?>"><a onclick="cart.add('<?php echo $product['product_id']; ?>', 1, 1);" class="button btn btn-primary"><i class="fa fa-shopping-cart"></i></a></div>
					</div>
				</div>
				<?php } ?>
			</div>
		</div>
		<?php } ?>
		<?php } else { ?>
		<div class="empty"><?php echo $text_empty; ?></div>		</div>

	<?php } ?>
		<input type="hidden" name="addtocart_logic" value="<?php echo $addtocart_logic; ?>" />
		<input type="hidden" name="click_on_cart" value="<?php echo $click_on_cart; ?>" />
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('#popupcart_extended').popup({transition: 'all 0.3s',	scrolllock: true});
	});

	function popup_active() {
		var oldWidth = window.innerWidth;
		window.onresize = function () {
			var newWidth = window.innerWidth;
			if (newWidth != oldWidth) {
				reloadFile()
				oldWidth = newWidth;
			}
		};

		const   cartInfo = document.querySelectorAll('.cart__info'),
				cartInfoCloseBtn = document.querySelectorAll('.cart__info-close');

		if (windowWidth <= 600) {

			if (!!cartInfo) {
				cartInfo.forEach(el => el.addEventListener("click", function () {
					let parent = this.closest('.cart__info-wrap');
					parent.classList.add('active');
				}));

				cartInfoCloseBtn.forEach(el => el.addEventListener("click", function (event) {
					event.stopPropagation()
					let parent = this.closest('.cart__info-wrap');
					parent.classList.remove('active');
				}));
			}

		}
	}

	function carousel () {
		$('.related_product').owlCarousel({
			responsiveBaseWidth: '.related_product',
			navigation: true,
			slideSpeed: 200,
			paginationSpeed: 300,
			touchDrag: true,
			mouseDrag: false,
			navigationText: ['&lt;', '&gt;'],
			pagination: false,
		});
	}

	function p_array() {
	<?php foreach ($products as $product) { ?>
		<?php if($product['option']) { ?>
				replace_button('<?php echo $product['id']; ?>', 1);
			<?php } else { ?>
				replace_button('<?php echo $product['id']; ?>', 0);
			<?php } ?>
		<?php } ?>
	}

	function replace_button(product_id, options){
		if(options && $('.'+product_id).attr('id') == 'button-cart') {
			var text = '<?php echo $button_incart_with_options; ?>';
		} else {
			var text = '<?php echo $button_incart; ?>';
		}
	<?php if($button_incart_logic) { ?>
			$('html, body').find('.'+product_id).val(text).text(text).addClass('in_cart');
		<?php } else { ?>
			if(options) {
				$('html, body').find('.'+product_id).val(text).text(text).addClass('in_cart');
			} else {
				$('html, body').find('.'+product_id).attr('onclick', '$(\'#popupcart_extended\').popup(\'show\');').val(text).text(text).addClass('in_cart');
			}
		<?php } ?>
	}
</script>

<script>
	document.addEventListener('DOMContentLoaded', function () {
		let col = document.querySelector(".static<?php echo $product['product_id']; ?>").innerHTML,
				staticWeight = document.querySelector(".static_weight<?php echo $product['product_id']; ?>").innerHTML,
				tes = "<?php echo $product['quantity']; ?>",
				calc = document.querySelector(".calc<?php echo $product['product_id']; ?>"),
				weight = document.querySelector(".weight<?php echo $product['product_id']; ?>"),
				quantity = document.querySelector("#pr<?php echo $product['id']; ?>"),
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
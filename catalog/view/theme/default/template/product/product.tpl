<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumbs__list">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>"><span class="breadcrumbs__item-text">
          <?php echo $breadcrumb['text']; ?></span></a></li>
    <?php } ?>
  </ul>
  <div class="dish__item">
    <div class="dish__img-box">
      <div class="dish__header-mob">
        <div id="dish__rating" class="dish__rating">
          <?php for ($i = 1; $i <= 5; $i++) { ?>
          <?php if ($rating < $i) { ?>
          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
          <?php } else { ?>
          <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
          <?php } ?>
          <?php } ?>
        </div>
        <span class="dish__counter-testimonial"><span class="counter-dynamic"><a href="javascript:;" onclick="$('html,body').animate({scrollTop: $('#form-review').offset().top}, 500);"><?php echo $reviews; ?></a></span>
      </div>

      <ul class="thumbnails">
        <?php if ($thumb) { ?>
        <li class="dish__img">
          <a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>">
            <img class="lazy" data-src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
          </a>
          <div class="product__item-sale--label">
            Акция
            <img class="lazy img-discount" aria-hidden="true" data-src="catalog/view/theme/default/image/discount.svg"/>
          </div>
        </li>
        <?php } ?>
        <?php if ($images) { ?>
        <?php foreach ($images as $image) { ?>
        <li class="image-additional dish__img"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"> <img class="lazy" data-src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
    <div class="dish__description">
      <div class="dish__header">
        <?php if ($review_status) { ?>
        <div id="dish__rating" class="dish__rating">
          <p>

              <span class="dish__counter-testimonial"><span class="counter-dynamic"><a href="javascript:;" onclick="$('html,body').animate({scrollTop: $('#form-review').offset().top}, 500);"><?php echo $reviews; ?></a></span>
        <a class="dish__btn-new-testimonial to-write-review" href="javascript:;" onclick="$('html,body').animate({scrollTop: $('#form-review').offset().top}, 500);">
          <img class="dish__img-pencil" src="catalog/view/theme/default/image/pencil-w.png" alt="pencil icon">
          <?php echo $text_write; ?>
        </a><?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($rating < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
        </div>
        <?php } ?>
      </div>
      <h2 class="dish__title"><?php echo $heading_title; ?></h2>
      <div class="dish__price-info">
        <?php if ($price) { ?>
        <?php if (!$special) { ?>
        <span><span class="static<?php echo $product_id; ?>"><?php echo $price_for_calc; ?></span> <?php echo $currency; ?></span>
        <?php } else { ?>
        <span class="product__price-sale" data-price="<?php echo $price; ?>"><span><?php echo $price_for_calc; ?></span> <?php echo $currency; ?></span>
        <span><span class="static<?php echo $product_id; ?>"><?php echo $special_for_calc; ?></span> <?php echo $currency; ?></span>
        <?php } ?>
        <?php } ?>
        /<span><span class="static_weight<?php echo $product_id; ?>"><?php echo round($weight); ?></span> г</span>
      </div>
      <div class="dish__price-box price-box">
        <div class="dish__input-box input-box">
          <input type="button" value="&#8722" disabled="disabled" class="dish__input-change input-change down<?php echo $product_id; ?>">
          <input name="quantity" aria-label="quantity" size="2" value="<?php echo $minimum; ?>" type="number"  id="quantity_<?php echo $product_id; ?>" class="amount quantity<?php echo $product['product_id']; ?>" data-value-min="<?php echo $minimum; ?>" readonly>
          <input type="button" value="+" class="dish__input-change input-change up<?php echo $product_id; ?>">
        </div>
        <div class="dish__price-right">
          <span class="dish__weight weight"><?php if ($weight>0) { ?> <span class="weight<?php echo $product_id; ?>"><?php echo round($weight); ?><?php } ?></span> г</span>
          <p>
            <?php if ($price) { ?>

            <?php if (!$special) { ?>
            <span class="dish__price price" data-price="<?php echo $price; ?>"><span class="calc<?php echo $product_id; ?>"><?php echo $price_for_calc; ?></span> <?php echo $currency; ?></span>
            <?php } else { ?>
            <span class="dish__price price" data-price="<?php echo $special; ?>"><span class="dish__price price calc<?php echo $product_id; ?>"><?php echo $special_for_calc; ?></span> <?php echo $currency; ?></span>
            <?php } ?>

            <?php } ?>

          </p>
        </div>
      </div>
      <div class="dish__info">
        <img class="dish__img-info" src="catalog/view/theme/default/image/info.svg" alt="info icon">
        минимальный заказ <?php if ($weight>0) { ?> <?php echo round($weight); ?><?php } ?> граммов
        <div class="dish__info-hint">
          Минимальный заказ данного блюда <?php if ($weight>0) { ?> <?php echo round($weight); ?><?php } ?> граммов, так как это целая часть мяса и она не разрезается
        </div>
      </div>
      <button type="button" id="button-cart1" data-loading-text="<?php echo $text_loading; ?>" class="btn product__add-btn dish__add-btn" onclick="cart.add('<?php echo $product_id; ?>',document.getElementById('quantity_<?php echo $product_id; ?>').value); console.log('<?php echo $product_id; ?>')">
        <i class="cart-icon icon-cart"></i>
        <?php echo $button_cart; ?></button>
      <div class="dish__description-text">
        <div class="dish__description-scroll">
          <?php echo $description; ?></div>
        <div class="dish__description-btn" data-open="Развернуть" data-close="Свернуть">Развернуть</div>
      </div>
    </div>
  </div>
  <div class="dish__action-list">
    <div class="dish__action-item">
      <img class="lazy dish__img-distance" data-src="catalog/view/theme/default/img/distance.png" alt="distance icon">
      <div class="dish__action-box">
        <h3 class="dish__action-title">
          -10% при самовывозе
        </h3>
        <p class="dish__action-description">Скидка для активных людей</p>
      </div>
    </div>
    <div class="dish__action-item">
      <img class="lazy dish__img-order" data-src="catalog/view/theme/default/img/order-food.png" alt="">
      <div class="dish__action-box">
        <h3 class="dish__action-title">
          -10% на первый заказ
        </h3>
        <p class="dish__action-description">Через приложение с доставкой</p>
      </div>
    </div>
    <div class="dish__action-item">
      <img class="lazy dish__img-hb" data-src="catalog/view/theme/default/img/hb.png" alt="happy birthday icon">
      <div class="dish__action-box">
        <h3 class="dish__action-title">
          -30% В день рождение
        </h3>
        <p class="dish__action-description">Праздники могут быть выгодными</p>
      </div>
    </div>
  </div>
  <?php echo $content_bottom; ?>
  <form class="form-horizontal" id="form-review">
    <div id="review">

    </div>
  </form>
</div>


<script>
  document.addEventListener('DOMContentLoaded', function () {
    let col = document.querySelector(".static<?php echo $product_id; ?>").innerHTML,
            staticWeight = document.querySelector(".static_weight<?php echo $product_id; ?>").innerHTML,
            tes = "<?php echo $minimum; ?>",
            btnUp = document.querySelector(".up<?php echo $product_id; ?>"),
            calc = document.querySelector(".calc<?php echo $product_id; ?>"),
            weight = document.querySelector(".weight<?php echo $product_id; ?>"),
            btnDown = document.querySelector(".down<?php echo $product_id; ?>"),
            quantity = document.querySelector("#quantity_<?php echo $product_id; ?>"),
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


<script type="text/javascript"><!--
  $('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
    $.ajax({
      url: 'index.php?route=product/product/getRecurringDescription',
      type: 'post',
      data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
      dataType: 'json',
      beforeSend: function() {
        $('#recurring-description').html('');
      },
      success: function(json) {
        $('.alert, .text-danger').remove();

        if (json['success']) {
          $('#recurring-description').html(json['success']);
        }
      }
    });
  });
  //--></script>

<script type="text/javascript"><!--
  $('.date').datetimepicker({
    pickTime: false
  });

  $('.datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });

  $('.time').datetimepicker({
    pickDate: false
  });

  $('button[id^=\'button-upload\']').on('click', function() {
    var node = this;

    $('#form-upload').remove();

    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

    $('#form-upload input[name=\'file\']').trigger('click');

    if (typeof timer != 'undefined') {
      clearInterval(timer);
    }

    timer = setInterval(function() {
      if ($('#form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);

        $.ajax({
          url: 'index.php?route=tool/upload',
          type: 'post',
          dataType: 'json',
          data: new FormData($('#form-upload')[0]),
          cache: false,
          contentType: false,
          processData: false,
          beforeSend: function() {
            $(node).button('loading');
          },
          complete: function() {
            $(node).button('reset');
          },
          success: function(json) {
            $('.text-danger').remove();

            if (json['error']) {
              $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            }

            if (json['success']) {
              alert(json['success']);

              $(node).parent().find('input').val(json['code']);
            }
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
      }
    }, 500);
  });
  //--></script>
<script type="text/javascript"><!--
  $('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
  });

  $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

  $('#button-review').on('click', function() {
    $.ajax({
      url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
      type: 'post',
      dataType: 'json',
      data: $("#form-review").serialize(),
      beforeSend: function() {
        $('#button-review').button('loading');
      },
      complete: function() {
        $('#button-review').button('reset');
      },
      success: function(json) {
        $('.alert-success, .alert-danger').remove();

        if (json['error']) {
          $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
        }

        if (json['success']) {
          $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

          $('input[name=\'name\']').val('');
          $('textarea[name=\'text\']').val('');
          $('input[name=\'rating\']:checked').prop('checked', false);
        }
      }
    });
  });

  $(document).ready(function() {
    $('.thumbnails').magnificPopup({
      type:'image',
      delegate: 'a',
      gallery: {
        enabled:true
      }
    });
  });
  //--></script>
<script>
  $(document).ready(function () {
    let col = $(".static<?php echo $product_id; ?>").text();
    let tes = "<?php echo $minimum; ?>";
    if (tes != 1) {
      $(".calc<?php echo $product_id; ?>").text((i, val) => +val * (+tes));
      $(".weight<?php echo $product_id; ?>").text((i,val) => +val * (+tes));
    }
    $(".up<?php echo $product_id; ?>").click(function () {

      $(".calc<?php echo $product_id; ?>").text((i, val) => +val + (+col));
    });
    $(".down<?php echo $product_id; ?>").click(function () {
      if ($("#quantity_<?php echo $product_id; ?>").val() > tes) {
        $(".down<?php echo $product_id; ?>").prop("disabled",true);
      }
      $(".calc<?php echo $product_id; ?>").text((i, val) => +val - (+col));
    });
  });
</script>
<?php echo $footer; ?>
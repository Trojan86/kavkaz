<?php echo $header; ?>
<section>
  <div class="container">
  <!--<ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>-->
  <div class="private__wrap">
    <?php echo $column_left; ?>

    <div id="content" class="private__section private-item-4 show <?php echo $class; ?>">
      <form class="private__bonus-form">
        <?php echo $content_top; ?>

      <!--<h1><?php echo $heading_title; ?></h1>
      <p><?php echo $text_total; ?> <b><?php echo $total; ?></b>.</p>
      <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-left"><?php echo $column_date_added; ?></td>
              <td class="text-left"><?php echo $column_description; ?></td>
              <td class="text-right"><?php echo $column_points; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($rewards) { ?>
            <?php foreach ($rewards  as $reward) { ?>
            <tr>
              <td class="text-left"><?php echo $reward['date_added']; ?></td>
              <td class="text-left"><?php if ($reward['order_id']) { ?>
                <a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
                <?php } else { ?>
                <?php echo $reward['description']; ?>
                <?php } ?></td>
              <td class="text-right"><?php echo $reward['points']; ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="text-center" colspan="3"><?php echo $text_empty; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <div class="row">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
      </div>-->
        <input type="button" value="Принять" class="btn private__btn-checkout checkout__btn-submit btn-primary" id="bonus_cart_form" />
        <a href="<?php echo $back; ?>" class="btn private__btn-checkout-cancel"><?php echo $button_back; ?></a>
      </form>
    </div>
    <div class="private__section private-item-4-1">
      <form class="private__data-form form-validation">
        <h4 class="private__offer-title">Оформление карты</h4>
        <div class="private__data">
          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class="">Фамилия Имя</legend>
              <input class="checkout__input field" type="text" value="">
            </fieldset>
          </div>
          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class="">Номер телефона</legend>
              <input class="checkout__input field phone" type="phone" value="">
            </fieldset>
          </div>
          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class="">Дата рождения</legend>
              <img class="input-data-img" src="catalog/view/theme/default/img/data.png" alt="data icon">
              <input class="checkout__input field input-birthday" type="text">
            </fieldset>
          </div>
          <div class="private__select-nav select__nav">
            <fieldset class="private__select checkout__input-fieldset">
              <legend class="">Пол</legend>
              <p class="private__select-title">Женский</p>
            </fieldset>
          </div>
          <div class="checkout__input-box">
            <fieldset class="checkout__input-fieldset">
              <legend class="">Email</legend>
              <input class="checkout__input field" type="email" value="" >
            </fieldset>
          </div>
        </div>
        <input type="button" class="btn private__btn-checkout checkout__btn-submit" value="Оформить" id="step3">
        <input style="display: inline-block; float: none" type="submit" class="btn private__btn-checkout-cancel" value="Отмена">
      </form>
    </div>
    <div class="private__section private-item-4-2">
      <div class="bonuses__wrap">
        <div class="bonuses__tabs">
          <div class="assortment__input-box-after"></div>
          <ul class="bonuses__tabs-list">
            <li id="tabs-1" class="bonuses__tabs-item active">Карта</li>
            <li id="tabs-2" class="bonuses__tabs-item">QR-код</li>
            <li id="tabs-3" class="bonuses__tabs-item"> История</li>
            <li id="tabs-4" class="bonuses__tabs-item">Условия</li>
          </ul>
        </div>
        <div class="bonuses__sections">
          <div id="section-1" class="bonuses__section active">
            <div class="bonuses__cart-img-box">
              <img class="bonuses__cart-img" src="catalog/view/theme/default/img/cart.png" alt="cart">
              <p class="bonuses__cart-number">00001</p>
              <p class="rq__bonuses-title">Доступные бонусы:<span class="rq__bonuses">0,00</span></p>
            </div>
          </div>
          <div id="section-2" class="bonuses__section">
            <div class="rq__box">
              <img class="rq__img" src="catalog/view/theme/default/img/qr.png" alt="QR code">
              <p class="rq__cart-number">00001</p>
              <p class="rq__bonuses-title">Доступные бонусы:<span class="rq__bonuses">0,00</span></p>
            </div>
          </div>
          <div id="section-3" class="bonuses__section">
            <div class="history__box">
              <div class="private__history-table desktop">
                <div class="table-title">
                  <div class="table-col-1">№</div>
                  <div class="table-col-2">Дата</div>
                  <div class="table-col-3">Операция</div>
                  <div class="table-col-4">Колличество</div>
                  <div class="table-col-5">Примечание</div>
                </div>
                <a href="#" class="table-row">
                  <div class="table-col-1">1</div>
                  <div class="table-col-2">02.12.2020</div>
                  <div class="table-col-3">тип операции</div>
                  <div class="table-col-4">3</div>
                  <div class="table-col-5">примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно</div>
                </a>
                <a href="#" class="table-row">
                  <div class="table-col-1">1</div>
                  <div class="table-col-2">02.12.2020</div>
                  <div class="table-col-3">тип операции</div>
                  <div class="table-col-4">3</div>
                  <div class="table-col-5">примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно</div>
                </a>
                <a href="#" class="table-row">
                  <div class="table-col-1">1</div>
                  <div class="table-col-2">02.12.2020</div>
                  <div class="table-col-3">тип операции</div>
                  <div class="table-col-4">3</div>
                  <div class="table-col-5">примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно</div>
                </a>
              </div>

              <div class="private__history-table mob">
                <ul class="history__list">
                  <li class="history__item">
                    <a class="history__link" href="./private_page-3-1.html">
                      <div class="history__box">
                        <p class="history__index">1.</p>
                        <div class="bonuses__history">
                          <div class="history__description">
                            <p class="history__description-title">Дата</p>
                            <p class="history__description-info">06.06.2021</p>
                          </div>
                          <div class="history__description">
                            <p class="history__description-title">Операция</p>
                            <p class="history__description-info">тип операции</p>
                          </div>
                          <div class="history__description">
                            <p class="history__description-title">Количество</p>
                            <p class="history__description-info">3</p>
                          </div>
                          <div class="history__description">
                            <p class="history__description-title">Примечание</p>
                            <p class="history__description-info">примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно</p>
                          </div>
                        </div>
                      </div>
                    </a>
                  </li>
                  <li class="history__item">
                    <a class="history__link" href="./private_page-3-1.html">
                      <div class="history__box">
                        <p class="history__index">1.</p>
                        <div class="bonuses__history">
                          <div class="history__description">
                            <p class="history__description-title">Дата</p>
                            <p class="history__description-info">06.06.2021</p>
                          </div>
                          <div class="history__description">
                            <p class="history__description-title">Операция</p>
                            <p class="history__description-info">тип операции</p>
                          </div>
                          <div class="history__description">
                            <p class="history__description-title">Количество</p>
                            <p class="history__description-info">3</p>
                          </div>
                          <div class="history__description">
                            <p class="history__description-title">Примечание</p>
                            <p class="history__description-info">примечание текст длинный возможно примечание текст длинный возможно примечание текст длинный возможно</p>
                          </div>
                        </div>
                      </div>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <div id="section-4" class="bonuses__section">
            <div class="circumstances__box">
              <ul class="circumstances__list">
                <li class="circumstances__item">Каждый раз, делая заказ через мобильное приложение Кавказского Очага вы получаете бонусы </li>
                <li class="circumstances__item">Сумма бонусов составляет 5% от суммы заказа </li>
                <li class="circumstances__item">С помощью этих бонусов можно оплатить следующий заказ</li>
                <li class="circumstances__item">Накопление бонусов начинается со второго заказа включительно. На первый заказ – скидка 10%</li>
                <li class="circumstances__item">С помощью бонусов можно осуществить покупку любой позиции из меню Кавказского Очага</li>
                <li class="circumstances__item">Возможна как полная оплата заказа бонусами, так и частичная </li>
                <li class="circumstances__item">В случае, если сумма заказа больше, чем сумма накопленных бонусов, разница в стоимости заказа оплачивается деньгами</li>
                <li class="circumstances__item">Срок действия бонусной программы не ограничен </li>
                <li class="circumstances__item">Для участия в бонусной программе необходимо пройти регистрацию в разделе бонусная карта</li>
                <li class="circumstances__item">Управление бонусами осуществляется при оформлении следующего заказа </li>
                <li class="circumstances__item">Сумму накопленных бонусов вы можете узнать в своем бонусном счете.</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>

  <script>
    $("#bonus_cart_form").on("click", function () {
        $(".private-item-4").removeClass("show");
        $(".private-item-4-1").addClass("show");
    })
    $("#step3").on("click", function () {
      $(".private-item-4-1").removeClass("show");
      $(".private-item-4-2").addClass("show");
    })
  </script>

</section>
<?php echo $footer; ?>
<?php echo $header; ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?><section>
        <div class="container">
          <div id="previewWrap" class="preview__wrap">
            <div class="preview__title-box">
              <h2 class="preview__title">Кавказкий очаг сеть ресторанов</h2>
              <p class="preview__text">
                «Кавказький Очаг» - це мережа ресторанів кавказької кухні в форматі fast casual. Без пафосу, химерного інтер'єру і високих цін. Але з неймовірно смачною їжею, душевністю і щедрістю, яка властива справжньому кавказькому застіллю.
              </p>
            </div>
            <div class="preview__main">
              <div class="preview__video-wrap">
                <img class="lazy preview__img-bg" data-src="catalog/view/theme/default/img/preview-bg.png" alt="image">
                <!--<iframe class="lazy" aria-label="preview video" allowfullscreen="" data-src="https://www.youtube.com/embed/MGlyiQT4s6Q?rel=0&amp;" sandbox="allow-forms allow-scripts allow-pointer-lock allow-same-origin allow-top-navigation" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" class="video__media"></iframe>-->
                  <div class="video">
                    <a class="video__link" href="https://youtu.be/MGlyiQT4s6Q">
                      <picture>
                        <img class="video__media"
                          src="//img.youtube.com/vi/MGlyiQT4s6Q/mqdefault.jpg"
                          alt="preview video" />
                      </picture
                    ></a>
                  <span class="video__button preview__btn-play">
                      <img src="catalog/view/theme/default/img/triangle-bl.svg" alt="triangle icon" class="preview__btn-triangle">
                  </span>

                <!--<video class="preview__video" preload="metadata" playsinline poster="catalog/view/theme/default/img/poster-preview.png">
                  <source src=".catalog/view/theme/default/img/fairytale.mp4" type="video/mp4">
                  <source src="catalog/view/theme/default/img/fairytale.mp4" type="video/ogg">
                  <source src="catalog/view/theme/default/img/fairytale.mp4" type="video/webm">
                </video> 
                  <span class="video__button preview__btn-play">
                      <img src="catalog/view/theme/default/img/triangle-bl.svg" alt="triangle icon" class="preview__btn-triangle">
                  </span>-->
                </div>
              </div>
              <img class="lazy preview__img" data-src="catalog/view/theme/default/img/preview.jpg" alt="images">
            </div>
          </div>
        </div>
      </section><?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
<?php echo $footer; ?>
</div>
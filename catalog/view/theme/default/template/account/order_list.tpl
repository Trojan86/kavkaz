<?php echo $header; ?>
<section>
  <div class="container">
    <!--<ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>-->
    <div class="private__wrap"><?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="private__history-level1 <?php echo $class; ?>"><?php echo $content_top; ?>
        <h1 class="private__history-title"><?php echo $heading_title; ?></h1>
        <?php if ($orders) { ?>
        <div class="private__history-table desktop table-responsive">
          <div class="table table-bordered table-hover">
            <div class="table-title">
              <div class="table-col-1"><?php echo $column_order_id; ?></div>
              <div class="table-col-2"><?php echo $column_customer; ?></div>
              <div class="table-col-3"><?php echo $column_product; ?></div>
              <div class="table-col-4"><?php echo $column_status; ?></div>
              <div class="table-col-5"><?php echo $column_total; ?></div>
              <div class="table-col-6"><?php echo $column_date_added; ?></div>
              <div></div>
            </div>
            <div>
              <?php foreach ($orders as $order) { ?>
              <div class="table-row">
                <div class="table-col-1">#<?php echo $order['order_id']; ?></div>
                <div class="table-col-2"><?php echo $order['name']; ?></div>
                <div class="table-col-3"><?php echo $order['products']; ?></div>
                <div class="table-col-4"><?php echo $order['status']; ?></div>
                <div class="table-col-5"><?php echo $order['total']; ?></div>
                <div class="table-col-6"><?php echo $order['date_added']; ?></div>
                <div class="text-right"><a href="<?php echo $order['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></div>
              </div>
              <?php } ?>
            </div>
          </div>
        </div>

        <div class="private__history-table mob table-responsive">
          <ul class="history__list">
            <?php foreach ($orders as $order) { ?>
            <li class="history__item">
              <a class="history__link" href="#">
                <div class="history__box">
                  <p class="history__index"><?php echo $order['order_id']; ?>.</p>
                  <div class="history__description">
                    <div class="history__description-title">
                      <p><?php echo $column_order_id; ?></p>
                      <p><?php echo $column_status; ?></p>
                      <p><?php echo $column_total; ?></p>
                      <p><?php echo $column_date_added; ?></p>
                    </div>
                    <div class="history__description-info">
                      <p><?php echo $order['name']; ?></p>
                      <p><?php echo $order['status']; ?></p>
                      <p><?php echo $order['date_added']; ?></p>
                      <p><?php echo $order['total']; ?></p>
                    </div>
                  </div>
                </div>
              </a>
              <object>
                <a class="history__description-download" href="catalog/view/theme/default/img/download.png" download="">
                  <span class="text">Скачать</span>
                  <span class="format">PDF</span>
                  <div class="img-box">
                    <img src="catalog/view/theme/default/img/download.png" alt="download icon">
                  </div>
                </a>
              </object>
            </li>
            <?php } ?>
          </ul>
        </div>
        <!--<div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>-->
        <?php } else { ?>
        <div class="private__history-empty">
          <p><?php echo $text_empty; ?></p>
        </div>
        <?php } ?>
        <!--<div class="buttons clearfix">
          <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
        </div>-->
        <?php echo $content_bottom; ?></div>
      <?php echo $column_right; ?></div>
  </div>
</section>
<?php echo $footer; ?>

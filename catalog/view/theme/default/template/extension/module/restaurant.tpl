<h2 style="display: none"> <?php echo $heading_title; ?> </h2> <br />




<section>
    <div class="container">
        <div class="shops__wrap">
            <div class="wrap__title-box">
                <h2 class="wrap__title">Наши магазины</h2>
                <h2 class="wrap__title contacti">Контакты</h2>
            </div>
            <ul class="shops__list">
                <?php   if (!empty($contacts)){
                foreach ($contacts as $contact) { ?>
                <li class="shops__item">
                    <div class="shops__description">
                        <div class="shops__description-title">
                            <?php echo $contact['title']; ?>
                        </div>
                        <?php if (isset($contact['phone']) && !empty($contact['phone'])) { ?>
                        <ul class="shops__phone-list">
                            <li class="shops__phone-item">
                                <a class="shops__phone-link" href="tel:+380567895541"><?php echo $text_phone." ".$contact['phone'];  ?></a>
                            </li>
                        </ul>
                        <?php } ?>
                        <?php if (isset($contact['work_start']) && !empty($contact['work_start'])) { ?>
                        <p class="shops__time"><?php echo $text_we_work_from." ".$contact['work_start']." ".$text_to." ".$contact['work_finish']; ?></p>
                        <?php } ?>
                        <?php if (isset($contact['address']) && !empty($contact['address'])) { ?>
                        <p class="shops__address"><?php echo $contact['address']; ?></p>
                        <?php } ?>
                        <?php if (isset($contact['route']) && !empty($contact['route'])) { ?>
                        <a href="<?php echo $contact['route']; ?>" class="shops__route-link" target="_blank">
                            <i class="shops__route-img icon-location"></i>
                            <span class="shops__route-title"><?php echo $text_route; ?></span>
                        </a>
                        <?php }?>
                    </div>
                    <div class="shops__map">
                        <?if (isset($contact['iframe']) && !empty($contact['iframe'])) {
                        echo $contact['iframe']; } ?>
                    </div>
                </li>
                <?php }} ?>
            </ul>
        </div>
    </div>
</section>

<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-cod" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i><?php echo $heading_title; ?></h3>
            </div>
            <div class="panel-body">
                <p> <?php if (isset($message)) echo $message; ?></p>
                <ul class="shops__list">
                    <?php if (!empty($contacts)){
   foreach ($contacts as $contact) { ?>
                    <li class="shops__item">
                        <div class="shops__description">
                            <div class="shops__description-title"><?php echo $contact['title']; ?></div>
                            <ul class="shops__phone-list">
                                <li class="shops__phone-item">
                                    <?php if (isset($contact['phone']) && !empty($contact['phone'])) { ?>
                                    <a class="shops__phone-link" href="tel:+380567895541">
                                        <?php echo $text_phone." ".$contact['phone'];  ?>
                                    </a>
                                    <?php } ?>
                                </li>
                            </ul>
                            <p class="shops__time">
                                <?php if (isset($contact['work_start']) && !empty($contact['work_start'])) { ?>
                                <?php echo $text_we_work_from." ".$contact['work_start']." ".$text_to." ".$contact['work_finish']; ?>
                                <?php } ?>
                            </p>
                            <p class="shops__address">
                                <?php echo $contact['address']; ?>
                            </p>
                            <?php if (isset($contact['route']) && !empty($contact['route'])) { ?>
                            <a href="<?php echo $contact['route']; ?>" target="_blank">
                                <img class="shops__route-img" src="../catalog/view/theme/default/img/location.svg" alt="location icon">
                                <span class="shops__route-title"><?php echo $text_route; ?></span>
                            </a>
                            <?php } ?>
                        </div>
                        <div class="shops__map">
                            <img class="shops__map-img" src="./img/shop-1.jpg" alt="shop images">
                            <span class="shops__route-title"><?php echo $contact['iframe']; ?></span>
                        </div>
                    </li>
                </ul>
                <form action="<?php echo $action; ?>" method="post" name="toEdit"
                      id="<?php echo $contact['contact_id']; ?>">
                    <input type="Submit" id="<?php echo $contact['contact_id']; ?>"
                           name="toEdit" value="<?php echo $text_edit; ?>">
                    <input type="Submit" hidden="true"
                           name="edit_id" value="<?php echo $contact['contact_id']; ?>">
                    <label hidden="true" for="edit_id"></label>
                    <input hidden="true" type="Text" id="edit_id" name="edit_id" value="<?php echo $contact['contact_id']?>"> <br>
                </form>
                <form action="<?php echo $action; ?>" method="post" name="delete">
                    <button type="submit" name="delete" onclick="return confirm('Are you sure?')">
                        <?php echo $text_delete;?>
                    </button>
                    <label for="delete_id" hidden="true"></label>
                    <input hidden="true" type="Text" id="delete_id" name="delete_id" value="<?php echo $contact['contact_id']?>"> <br>
                </form> <br/>
                <?php }} ?>
                </ul>
                <form action="<?php echo $action; ?>" method="post" name="toAdd">
                    <input type="Submit" id="add" name="toAdd" value="<?php echo $text_add_new; ?>">
                </form>
                <form action="<?php echo $action; ?>" method="post" name="return">
                    <input type="Submit" id="return" name="return" value="<?php echo $text_return; ?>">
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
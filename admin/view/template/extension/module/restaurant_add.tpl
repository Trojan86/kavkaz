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
                <h3 class="panel-title"><i class="fa fa-pencil"></i><?php echo $text_enter_contacts; ?></h3>
            </div>
            <div class="panel-body">
                <p style="color: red"><?php echo $text_mustfill; ?></p>
                <form action="<?php echo $action; ?>" method="post" name="add" id="restaurant_add" class="form-horizontal">

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="phone"><?php echo $text_phone_nmb?><span class="required">*</span></label>
                        <div class="col-sm-10">
                            <input id="phone" type="text" name="phone" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="work_start"><?php echo $text_work_start?><span class="required">*</span></label>
                        <div class="col-sm-10">
                            <input id="work_start" type="text" name="work_start" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="work_finish"><?php echo $text_work_finish?><span class="required">*</span></label>
                        <div class="col-sm-10">
                            <input id="work_finish" type="text" name="work_finish" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="street"><?php echo $text_street?><span class="required">*</span></label>
                        <div class="col-sm-10">
                            <input required id="street" type="text" name="street" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="building"><?php echo $text_building_nmb?><span class="required">*</span></label>
                        <div class="col-sm-10">
                            <input id="building" type="text" name="building" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="place"><?php echo $text_enter_place; ?><span class="required">*</span></label>
                        <div class="col-sm-10">
                            <input id="place" type="text" name="place" class="form-control" />
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="iframe"><?php echo $text_enter_map; ?><span class="required">*</span></label>
                            <div class="col-sm-10">
                                <input id="iframe" type="text" name="iframe" class="form-control" />
                            </div>
                            <p><?php echo $text_map_description; ?></p>
                        </div>
                        <div class="footer_admin">

                            <input type="Submit"  name="add" value="<?php echo $text_submit_add; ?>" class="admin_button_add">
                            <input type="reset" value="<?php echo $text_reset; ?>" class="admin_button_res">
                        </div>
                </form>
                <form action="<?php echo $action; ?>" method="post" name="cancel" class="cancel_block_footer_none">
                    <button type="submit" name="cancel"> <?php echo $text_cancel;?></button>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
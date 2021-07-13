<?php echo $header; ?>
<div class="hide-screen">
    <div class="spinner-wrapper"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> <span id="wait-message"><?php echo $text_wait; ?></span></div>
</div>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
        <h1><i class="fa fa-comments"></i> <?php echo $heading_title; ?><div style="position: absolute;margin-top:3px;margin-left:140px;font-size:12px;"><a href="http://vanstudio.co.ua" target="_blank">by vanstudio</a></h1>
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
      <?php if ($success) { ?>
      <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
          <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="" method="post" enctype="multipart/form-data" id="form-language" class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label" for="input-language"><?php echo $entry_language; ?></label>
                <div class="col-sm-10">
                    <select name="language" id="input-language" class="form-control">
                        <option value="*"><?php echo $text_select; ?></option>
                        <?php foreach($languages as $language){ ?>
                        <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                        <?php } ?>
                    </select>
                    <div data-loading-text="<i class='fa fa-spinner fa-pulse'> <?php echo $text_loading; ?>"></div>
                </div>
            </div>
        </form>
      </div>
    </div>
  </div>
    <script type="text/javascript"><!--
        $('select[name=\'language\']').change(function(){
            $(".var-field").remove();
            $(".alert").remove();
            $(".btn-save").remove();
            $(".alert").remove();

            var element = $(this);
            $.ajax({
                url: '<?php echo html_entity_decode($variables); ?>',
                type: 'post',
                data: 'language=' + $('select[name=\'language\']').val(),
                dataType: 'json',
                beforeSend: function() {
                    element.next().button('loading');
                    $('.hide-screen').show();
                },
                complete: function() {
                    element.next().button('reset');
                    $('.hide-screen').hide();
                },
                success: function (json) {
                    html = '<div class="form-group btn-save">';
                    html += '<label class="col-sm-2 control-label"></label>';
                    html += '<div class="col-sm-10"><div class="pull-right">';
                    html += '<a class="btn btn-warning" onclick="resetTranslate($(this));" data-loading-text="<i class=\'fa fa-spinner fa-spin \'></i> <?php echo $text_wait; ?>"><i class="fa fa-refresh" aria-hidden="true"></i> <?php echo $button_reset; ?></a> ';
                    html += '<a class="btn btn-success" onclick="saveTranslate($(this));" data-loading-text="<i class=\'fa fa-spinner fa-spin \'></i> <?php echo $text_wait; ?>"><i class="fa fa-floppy-o" aria-hidden="true"></i> <?php echo $button_save; ?></a>';
                    html += '</div></div>';
                    html += '</div>';

                    if(json.vars) {
                        $.each(json.vars, function (index, value) {
                            html += '<fieldset class="var-field">';
                            html += '<legend>' + json['entry']['entry_'+index] + '</legend>';
                            html += '<table id="translation" class="table table-bordered table-hover">';
                            html += '<thead><tr>';
                            html += '<td><?php echo $entry_default; ?></td><td><?php echo $entry_value; ?></td>';
                            html += '</tr><thead>';
                            html += '</thead>';
                            html += '<tbody><tr>';
                            html += '<td><textarea class="form-control" disabled="disabled">' + json['default'][index] + '</textarea></td>';
                            html += '<td><textarea name="variable[' + index + ']" class="form-control">' + value + '</textarea></td>';
                            html += '</tr></tbody>';
                            html += '</table>';
                            html += '</fieldset>';
                        });

                        html += '<div class="form-group btn-save">';
                        html += '<label class="col-sm-2 control-label"></label>';
                        html += '<div class="col-sm-10"><div class="pull-right">';
                        html += '<a class="btn btn-warning" onclick="resetTranslate($(this));" data-loading-text="<i class=\'fa fa-spinner fa-spin \'></i> <?php echo $text_wait; ?>"><i class="fa fa-refresh" aria-hidden="true"></i> <?php echo $button_reset; ?></a> ';
                        html += '<a class="btn btn-success" onclick="saveTranslate($(this));" data-loading-text="<i class=\'fa fa-spinner fa-spin \'></i> <?php echo $text_wait; ?>"><i class="fa fa-floppy-o" aria-hidden="true"></i> <?php echo $button_save; ?></a>';
                        html += '</div></div>';
                        html += '</div>';

                        $('#form-language').append(html);
                    }
                    if(json.error){
                        $('#form-language').append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json.error + '<button type="button" class="close" data-dismiss="alert">&times;</button> </div>');
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    $('.hide-screen').hide();
                    alert(xhr.responseText);
                }
            });
        });

        function resetTranslate(e) {
            $(".alert").remove();
            $.ajax({
                url: '<?php echo html_entity_decode($reset); ?>',
                type: 'post',
                data: $('select').serialize(),
                dataType: 'json',
                beforeSend: function() {
                    e.button('loading');
                    $('.hide-screen').show();
                },
                complete: function() {
                    e.button('reset');
                    $('.hide-screen').hide();
                },
                success: function (json) {
                    if(json.permission){
                        html = '<div class="alert alert-danger">';
                        html += '<i class="fa fa-exclamation-circle"></i> ' + json.permission;
                        html += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
                        html += '</div>';
                        $('#form-language').prepend(html);
                    } else {
                        $('select[name=\'language\']').trigger('change');
                        html = '<div class="alert alert-success">';
                        html += '<i class="fa fa-check-circle"></i> <?php echo $text_success; ?>';
                        html += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
                        html += '</div>';
                        $('#form-language').prepend(html);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    $('.hide-screen').hide();
                    alert(xhr.responseText);
                }
            });
        }

        function saveTranslate(e) {
            $(".alert").remove();
            $.ajax({
                url: '<?php echo html_entity_decode($save); ?>',
                type: 'post',
                data: $('textarea, select').serialize(),
                dataType: 'json',
                beforeSend: function() {
                    e.button('loading');
                    $('.hide-screen').show();
                },
                complete: function() {
                    e.button('reset');
                    $('.hide-screen').hide();
                },
                success: function (json) {
                    if(json.permission){
                        html = '<div class="alert alert-danger">';
                        html += '<i class="fa fa-exclamation-circle"></i> ' + json.permission;
                        html += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
                        html += '</div>';
                        $('#form-language').prepend(html);
                    } else {
                        html = '<div class="alert alert-success">';
                        html += '<i class="fa fa-check-circle"></i> <?php echo $text_success; ?>';
                        html += '<button type="button" class="close" data-dismiss="alert">&times;</button>';
                        html += '</div>';
                        $('#form-language').prepend(html);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    $('.hide-screen').hide();
                    alert(xhr.responseText);
                }
            });
        }
        //--></script>
</div>
<?php echo $footer; ?>
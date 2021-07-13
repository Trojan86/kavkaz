<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
    <div class="install-block">
        <a href="<?php echo $install; ?>" class="btn btn-success" data-loading-text="<i class='fa fa-spinner fa-spin '></i> <?php echo $text_install_wait; ?>">
            <i class="fa fa-plus-circle"></i> <?php echo $button_install; ?>
        </a>
    </div>
</div>
<script type="text/javascript"><!--
    $('#content').on('click', '.btn-success', function(e) {
        e.preventDefault();

        var node = this;

        $.ajax({
            url: $(node).attr('href'),
            dataType: 'html',
            beforeSend: function() {
                $(node).button('loading');
            },
            complete: function() {
                $(node).button('reset');
            },
            success: function(html) {
                location.reload();
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    //--></script>
<style>
    .install-block{
        text-align: center;
        height: 100%;
        background-color: #E8E8E8;
    }
    .btn-success {
        margin-top: 20%;
        margin-bottom: 20%;
    }
</style>
<?php echo $footer; ?>
/**
 * Created by vanstudio.co.ua on 08.07.15.
 */
$(document).ready(function() {

    // Highlight any found errors
    $('.tm-container .text-danger').each(function() {
        var element = $(this).parent().parent();

        if (element.hasClass('form-group')) {
            element.addClass('has-error');
        }
    });

    // tooltips on hover
    $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});

    // Makes tooltips work on ajax generated content
    $(document).ajaxStop(function() {
        $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
    });

    // Product List
    $('#tm-list-view').click(function() {
        $('#content .review-layout > .clearfix').remove();

        //$('#content .product-layout').attr('class', 'product-layout product-list col-xs-12');
        $('#content .row > .review-layout').attr('class', 'review-layout review-list col-xs-12');

        localStorage.setItem('tm-display', 'list');
    });

    // Product Grid
    $('#tm-grid-view').click(function() {
        $('#content .review-layout > .clearfix').remove();

        // What a shame bootstrap does not take into account dynamically loaded columns
        cols = $('#column-right, #column-left').length;

        if (cols == 2) {
            $('#content .review-layout').attr('class', 'review-layout review-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
        } else if (cols == 1) {
            $('#content .review-layout').attr('class', 'review-layout review-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
        } else {
            $('#content .review-layout').attr('class', 'review-layout review-grid col-lg-3 col-md-3 col-sm-6 col-xs-12');
        }

        localStorage.setItem('tm-display', 'grid');
    });

    if (localStorage.getItem('tm-display') == 'list') {
        $('#tm-list-view').trigger('click');
    } else {
        $('#tm-grid-view').trigger('click');
    }

});

$(function(){
    var wrapper = $( ".upload-label" ),
        inp = wrapper.find( "input" ),
        btn = wrapper.find( ".button" ),
        lbl = wrapper.find( "mark" );

    // Crutches for the :focus style:
    inp.focus(function(){
        wrapper.addClass( "focus" );
    }).blur(function(){
        wrapper.removeClass( "focus" );
    });

    var file_api = ( window.File && window.FileReader && window.FileList && window.Blob ) ? true : false;

    inp.change(function(){
        var file_name;
        if( file_api && inp[ 0 ].files[ 0 ] )
            file_name = inp[ 0 ].files[ 0 ].name;
        else
            file_name = inp.val().replace( "C:\\fakepath\\", '' );

        if( ! file_name.length )
            return;

        if( lbl.is( ":visible" ) ){
            lbl.text( file_name );
            //btn.text( "Выбрать" );
        }else
            btn.text( file_name );
    }).change();

});

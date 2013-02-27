$(document).ready(function(){
    var num_items = $('#slider ul li').length,
        goback = function(){
            var active_item = $('.active'), active_num = parseInt( active_item.attr( 'id' ) ),
                active_nav = $('#nav-' + active_num );
            active_item.fadeOut(function(){
                $(this).removeClass('active');
                active_nav.removeClass('act');
                if( active_num == 0 ) {
                    $('#' + ( num_items - 1 ) ).addClass('active').fadeIn();
                    $('#nav-' + ( num_items - 1 ) ).addClass('act');
                } else {
                    $('#' + ( active_num - 1 ) ).addClass('active').fadeIn();
                    $('#nav-' + ( active_num - 1 ) ).addClass('act');
                }
            });
        },
        gonext = function(){
            var active_item = $('.active'), active_num = parseInt( active_item.attr( 'id' ) ),
                active_nav = $('#nav-' + active_num );
            active_item.fadeOut(function(){
                $(this).removeClass('active');
                active_nav.removeClass('act');
                if( active_num == ( num_items - 1 ) ) {
                    $('#0').addClass('active').fadeIn();
                    $('#nav-0' ).addClass('act');
                } else {
                    $('#' + ( active_num + 1 ) ).addClass('active').fadeIn();
                    $('#nav-' + ( active_num + 1 ) ).addClass('act');
                }
            });
        },
        doresize = function(){
            var sw = $(window).width(), sh = $(window).height(),
                StandardRatio = 1.3333, ScreenRatio = sw / sh;
            if( sw >= sh ) {
                if( ScreenRatio > StandardRatio ) {
                    $('.pictures .bg img').attr('width', sw );
                    $('.pictures .bg img').attr('height', '' );
                } else {
                    $('.pictures .bg img').attr('width', '' );
                    $('.pictures .bg img').attr('height', sh );
                }
            } else {
                $('.pictures .bg img').attr('width', '' );
                $('.pictures .bg img').attr('height', sh );
            }
        };
    $('.nav').click(function(){
        var active_item = $('.active'), active_num = parseInt( active_item.attr( 'id' ) ),
            active_nav = $('#nav-' + active_num ),
            new_item = $(this), new_num = parseInt( new_item.attr('id').substr(-1) ), new_nav = $('#nav-' + new_num);
        active_item.fadeOut(function(){
            $(this).removeClass('active');
            active_nav.removeClass('act');
            $('#' + ( new_num ) ).addClass('active').fadeIn();
            $('#nav-' + ( new_num ) ).addClass('act');
        });
    });
    $(window).resize(function() {
        doresize();
    });
    /*$('#join-button').click(function(){*/
    /*$('#dim').show();*/
    /*$('#modal').show();*/
    /*});*/
    /*$('#cancel-button').click(function(){*/
    /*$('#dim').hide();*/
    /*$('#modal').hide();*/
    /*});*/
    setInterval( function(){
        gonext();
    }, 6000 );

    doresize();

});


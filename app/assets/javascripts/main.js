$(function () {
    $(document).on('focusin', '.field, textarea',function () {
        if (this.title == this.value) {
            this.value = '';
        }
    }).on('focusout', '.field, textarea', function () {
            if (this.value == '') {
                this.value = this.title;
            }
        });

    $(".red-line").slider({
        range:"max",
        value:50
    });

    if ($('.scrollpane').length > 0) {
        $('.scrollpane').jScrollPane({
            showArrows:true
        });
    }

    $('#header .profile .drop-holder').click(function () {
        $(this).find('.drop-down').stop(true, true).fadeToggle()
    })

    var mouse_is_inside = false;
    $('.drop-holder').hover(function () {
        mouse_is_inside = true;
    }, function () {
        mouse_is_inside = false;
    });

    $(document).mouseup(function () {
        if (!mouse_is_inside) $('.drop-down').fadeOut();
    });

    $('span.close').click(function () {
        $('.cont-log').hide();
    });

    if ($('.select').length) {
        $('.select').c2Selectbox();
    }

    if ($('.ez-mark').length) {
        $('.ez-mark').ezMark();
    }

    if ($(".ellipsis").length) {
        $('.ellipsis').dotdotdot();

        $('.ellipsis').click(function () {
            $(this).addClass('ellipsis-auto').trigger("destroy");
        })
    }
});
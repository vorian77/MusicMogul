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

    $(".datepicker").datepicker({
        showOn:"button",
        buttonImage:"css/images/datepicker-icon.png",
        buttonImageOnly:true
    });

    if ($('.scrollpane').length > 0) {
        $('.scrollpane').jScrollPane({
            showArrows:true,
            animateScroll:true,
            autoReinitialise:true
        });
    }

    $('#header .profile .drop-holder').click(function () {
        $(this).find('.drop-down').stop(true, true).fadeToggle()
    });

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

    if ($('.ellipsis').length > 0) {
        $('.ellipsis').dotdotdot();

        $('.ellipsis').click(function () {
            $(this).addClass('ellipsis-auto').trigger("destroy");
        })
    }

    $('#content .tabs ul li').each(function (e) {
        if ($(this).hasClass('active')) {
            $(this).css({
                'z-index':5
            })
        } else {
            $(this).css({
                'z-index':4 - e
            })
        }
    }).find('a').click(function () {
            var href = $(this).attr('href');
            if (href == "#") {
                return false;
            }
            $('.tab-box').slideUp();
            $(href).stop(true, true).slideDown();
            $('#content .tabs ul li.active').removeClass('active');
            $(this).parent().addClass('active');
            return false;
        });

    if ($(".tabs").length) {
        $("a[href=" + window.location.hash + "]").click()
    }

    $("div#footer div.top-part ul li a").click(function () {
        $("a[href=" + $(this)[0].hash + "]").click()
    });

    $(".textarea-holder").click(function () {
        $(this).find('textarea').focus();
    });

    if ($(".textarea-holder textarea").length > 0) {
        $(".textarea-holder textarea").autoGrow();
    }

    $(".photo-upload span.file-btn").mousemove(function (e) {
        $(".photo-upload input.file").show();
        var pageX = e.pageX;
        var pageY = e.pageY;
        var thisOffsetY = $(this).offset().top;
        var thisOffsetX = $(this).offset().left;
        $(this).parent().find('input').css({
            'left':pageX - thisOffsetX - 200,
            'top':pageY - thisOffsetY - 10
        });

        // Get File Name
        $(".photo-upload input.file").change(function () {
            var inputVal = $(this).val();
            var inputValArr = inputVal.split("\\");
            var fileName = inputValArr[inputValArr.length - 1];
            $(this).parents('.text-holder').find('span.no-file').text(fileName);
            $('.photo-upload .img-holder img').attr('src', 'css/images/' + fileName)
            $('.photo-upload .img-holder a.crop-text, .photo-upload .img-holder a.delete-photo, .photo-upload .photo-progress').show();
        });
    });

    $('.photo-upload .img-holder a.delete-photo').click(function () {
        $('.photo-upload .img-holder img').attr('src', 'css/images/empty-img.png')
        $('.photo-upload .img-holder a.crop-text, .photo-upload .img-holder a.delete-photo, .photo-upload .photo-progress').hide();
        return false;
    });

    $(".photo-upload input.file, .photo-upload span.file-btn").mousemove(function () {
        $(".photo-upload span.file-btn").addClass('btn-hover');
    })

    $('.photo-upload .img-holder a.crop-text').click(function () {
        $('.photo-upload .img-holder a.crop-text, .photo-upload .img-holder a.delete-photo, .photo-upload .photo-progress').hide();
        $('.photo-upload .text-holder').empty().append('<a href="#" class="save-btn">Save</a>');
        $('.img-holder img').Jcrop({
            setSelect:[ 120, 120, 10, 10 ]
        })
        return false;
    });

    $(document).on('click', 'a.save-btn', function () {
        $('.photo-upload .text-holder').prepend('<span class="saving">Saving...</span>');
        return false;
    });

    $(".photo-upload input.file").mouseleave(function () {
        $(this).hide();
        $(".photo-upload span.btn-hover").removeClass('btn-hover');
    }).click(function () {
            $(".photo-upload span.file-btn").addClass('btn-clicked');
            setTimeout(function () {
                $(".photo-upload span.file-btn").removeClass('btn-clicked').removeClass('btn-hover');
            }, 100)
        });
});
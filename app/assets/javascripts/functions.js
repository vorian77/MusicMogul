$(function() {
    // blink fields
    $(document).on('focusin', '.field, textarea', function() {
        if(this.title==this.value) {
            this.value = '';
        }
    }).on('focusout', '.field, textarea', function(){
            if(this.value=='') {
                this.value = this.title;
            }
        });

    // add some last classes
    $('#navigation ul li:last-child').addClass('last');

    // custom checkboxes
    $('label.check input:checked').closest('label').addClass('checked');
    $(document).on('click', 'label.check', function(){
        if( $(this).find('input').is(':checked') ){
            $(this).find('input').attr('checked', false);
            $(this).removeClass('checked');
        } else {
            $(this).find('input').attr('checked', true);
            $(this).addClass('checked');
        }

        $(this).find('input').trigger('change');

        return false;
    });

    // form validate
    $(".form-section:not(.signin-form) form").submit(function() {
        $('.error').hide();

        var field = $(".field").val(),
            password = $("input#password").val(),
            passConfirm = $("input#password-confirm").val(),
            error = false;

        $('.field').each(function() {
            var field = $(this).val();

            if ( field.length < 3 ) {
                $(this).parent().find('.error').show();
                $(this).focus();

                error = true;

                return false;
            }
        });

        if ( passConfirm != password ) {
            $("#password-confirm").parent().find('.error').show();
            $("input#password-confirm").focus();

            error = true;

            return false;
        }

        if ( error ) {
            return false;
        }
    });

    $('.signin-form form').submit(function() {
        if ( $('.error-msg').length ) {
            $('.error-msg').hide();

            var field = $('.field').val(),
                error = false;

            $('.field').each(function() {
                if ( field.length < 3 ) {
                    $('.error-msg').fadeIn('fast');

                    error = true;

                    return false;
                }
            });

            if ( error ) {
                return false;
            }
        }
    });

    // fake upload field
    $(document).on('change', '.upload-button .upload-field', function() {
        var val = $(this).val(),
            newVal = val.split('\\').pop();
        $(this).parent().find('.upload-value').val(newVal);
        return false;
    });

    $(document).on('focusin', '.upload-value', function() {
        $(this).parent().find('.upload-field').click();
        return false;
    });

    // scrollable textarea
    var txt = $('#bio'),
        hiddenDiv = $(document.createElement('div')),
        content = null;

    txt.addClass('txtstuff');
    hiddenDiv.addClass('hiddendiv common');

    $('body').append(hiddenDiv);

    txt.on('keyup', function (){
        content = $(this).val();

        content = content.replace(/\n/g, '<br>');
        hiddenDiv.html(content + '<br />');

        $(this).css('height', hiddenDiv.height());
    });

    var reinit = true;
    $(window).on('blur', function() {
        reinit = false;
    }).on('focus', function() {
            reinit = true;
        });

    var pane = txt.parent();
    pane.jScrollPane({
        showArrows: true,
        animateScroll: true,
        autoReinitialise: reinit,
        verticalDragMaxHeight: 80
    });

    $(document).on('click', '.textarea-holder', function() {
        $(this).find('textarea').focus();
        return false;
    });

    // fix text fields for IE
    if ( $.browser.msie ) {
        $('.field').css('line-height', '29px');
    }

    // copy to clipboard
    if( $('.referal-link-holder a.copy').length ) {
        $('.referal-link-holder a.copy').zclip( {
            path: 'swfs/ZeroClipboard.swf',
            copy: $('.referal-link-holder input.field').val()
        });
    }
});
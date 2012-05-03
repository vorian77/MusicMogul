$(document).ready ->
  $('a.fancybox').fancybox()	

  $flash = $('.flash')

  setFlashTimeout = ->
    hideFlash = -> $flash.children('div').fadeOut()
    $flash.click hideFlash
    flashTimeout = setTimeout hideFlash, 3000
    $flash.hover -> clearTimeout(flashTimeout)

  $('input[data-shows]').each (index,toggle) ->
    $toggle = $(toggle)
    $toggled = $($toggle.data('shows'))
    $toggled.toggle($toggle.is(':checked'))
    $toggle.click ->
      $toggled.toggle($toggle.is(':checked'))
	

  $('.tabs-holder').easytabs
    tabs: '.tabset li'
    animate: false

  $('.tabs-holder .tab-content').map (i, content) ->
    $(".bar a[href$='\##{content.id}']").click ->
      $(".tabs-holder a[href='\##{content.id}']").trigger('click')
      false

  $active_form = $('.tab-content.active form')
  $active_form.find('input, select, textarea').change ->
    $active_form.attr('data-dirty','true')

  $('.tabs-holder').on 'easytabs:before', (e,clicked) ->
    if $active_form.attr('data-dirty')
      $active_form.submit()
      false

  $close_button = $('<a></a>').addClass('close').html(' [X]')

  $active_form.on 'ajax:success', ->
    $active_form.removeAttr('data-dirty')
    $notice = $('<div></div>').addClass('notice').html('Your account was successfully saved').append($close_button)
    $flash.append($notice)
    setFlashTimeout()

  $active_form.on 'ajax:error', (xhr, status, error) ->
    console.log xhr
    if errors = $.parseJSON(xhr.responseText)
      for error in errors
        $error = $('<p></p>').addClass('inline_error').text(errors[error])
        $("user_#{error}").after($error)
    
    $alert = $('<div></div>').addClass('alert').html('Your account could not be saved').append($close_button)
    $flash.append($alert)
    setFlashTimeout()


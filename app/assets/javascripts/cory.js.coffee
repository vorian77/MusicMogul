$(document).ready ->
  $('a.fancybox').fancybox()	

  $flash = $('.flash')
  hideFlash = ->
    $flash.removeData('timeout')
    $flash.children('div').slideUp()
    $flash.off 'message.fanhelp'
  $flash.on 'message.fanhelp', ->
    $flash.data 'timeout', setTimeout(hideFlash, 3000)
    $flash.click hideFlash
  $flash.trigger 'message.fanhelp' if $flash.children('div')

  is_checked = (el) ->
    if el.attr('type') == 'radio'
      el.attr('checked') == 'checked'
    else if el.attr('type') == 'checkbox'
      el.is(':checked')
    else
      el

  $('input[data-shows]').each (index,toggle) ->
    $toggle = $(toggle)
    $toggled = $($toggle.data('shows'))
    console.log $toggled
    $toggled.toggle(is_checked($toggle))
    $toggle.click ->
      $toggled.toggle(is_checked($toggle))

  $('.tabs-holder').easytabs
    tabs: '.tabset li'
    animate: false

  $('.tabs-holder .tab-content').map (i, content) ->
    $(".bar a[href$='\##{content.id}']").click ->
      $(".tabs-holder a[href='\##{content.id}']").trigger('click')
      false


  (->
    if $form = $('form.profile-video')
      if $file = $form.find('#video_uploader_profile_video')
        $file.fileupload
          forceIframeTransport: true
          autoUpload: true,
          add: (event, data) ->
            data.submit()
          send: (event, data) ->
            $('#loading').show()
          fail: ->
            alert('Fail!')
          done: (event, data) ->
            console.log event
            console.log data
            alert('Done!')
            $('#loading').hide()
        $file.on 'fileuploadprogress', (event, data) ->
          console.log event
          console.log data
  )()

(->
  return unless $('.profile-box')
  
  $document = $(document)

  $document.on 'change', 'input, selext, textarea', ->
    $(this).closest('form').attr('data-dirty','true')

  $document.on 'easytabs:before', '.tabs-holder', (e,clicked) ->
    $active_form = $('.tab-content.active form').filter(':first')
    if $active_form.attr('data-dirty')
      if $active_form.data('non-ajax')
        old_action = $active_form.attr('action')
        $active_form.attr('action',clicked.attr('href'))
        $active_form.submit()
        $active_form.attr('action',old_action)
      else
        $active_form.submit()
      $active_form.data('clicked',clicked)
      false

  setMessageTimeout = ->
    hideMessages = -> $('.messages .notice, .messages .alert').fadeOut -> $(this).remove()
    messageTimeout = setTimeout hideMessages, 3000

  $document.on 'ajax:success', '.tab-content.active form', (e, data, status, xhr) ->
    $active_form = $(this).filter(':first')
    $active_form.find('p.inline-errors').hide()
    $notice = $('<div></div>').addClass('notice').html(data.notice) if data.notice
    $active_form.removeAttr('data-dirty')
    if $clicked = $active_form.data('clicked')
      $clicked.trigger 'click'
      $active_form.removeData('clicked')
    $('.flash').html($notice).trigger('message.fanhelp')

  $document.on 'ajax:error', '.tab-content.active form', (e, xhr, status, error) ->
    $active_form = $(this).filter(':first')
    $active_form.find('p.inline-errors').hide()
    $active_form.removeData('clicked')
    if errors = $.parseJSON(xhr.responseText).errors
      for error of errors
        $error = $('<p></p>').addClass('inline-errors').text(errors[error])
        $("#user_#{error}_input").addClass('error').append($error)
    $alert = $('<div></div>').addClass('alert').html('Your account could not be saved.')
    $('.tab-content.active .messages').html $alert
    setMessageTimeout()
)()

(->
  $(document).ready ->
    $('a#home-video-link').fancybox
      onStart: ->
        _V_('home-video').ready ->
          this.play()
)()

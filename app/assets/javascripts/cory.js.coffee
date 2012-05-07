$(document).ready ->
  $('a.fancybox').fancybox()	

  $flash = $('.flash')
  setFlashTimeout = (->
    hideFlash = -> $flash.children('div').fadeOut()
    $flash.click hideFlash
    flashTimeout = setTimeout hideFlash, 3000
    $flash.hover -> clearTimeout(flashTimeout)
  )()

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


  (->
  )()

(->
  return unless $('.profile-box')
  
  $document = $(document)

  $document.on 'change', 'input, selext, textarea', ->
    $(this).closest('form').attr('data-dirty','true')

  $document.on 'easytabs:before', '.tabs-holder', (e,clicked) ->
    $active_form = $('.tab-content.active form').filter(':first')
    if $active_form.attr('data-dirty')
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
      $clicked.trigger 'click', ->
        console.log 'Clicked tab!'
      $active_form.removeData('clicked')
      $('.tab-content.active .messages').html $notice
      setMessageTimeout()

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

  (->
    if $form = $('form.profile-video')
      if $file = $form.find('#video_uploader_profile_video')
        $file.uploadifive
          swf: 'uploadify.swf'
          uploadScript: $form.attr('action')
          method: $form.attr('method')
          multi: false
          buttonText: 'Upload'
          formData:
            key: $form.find('#video_uploader_key').val()
            aws_access_key_id: $form.find('#video_uploader_aws_access_key_id').val()
            acl: $form.find('#video_uploader_acl').val()
            success_action_redirect: $form.find('#video_uploader_success_action_redirect').val()
            policy: $form.find('#video_uploader_policy').val()
  )()

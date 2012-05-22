window.Application ||= {}

showPreview = (coords) ->
  rx = 77 / coords.w
  ry = 77 / coords.h
  $holder = $('.jcrop-holder')
  $thumb = $('.thumbnail img')
  $thumb.css
    width: Math.round(rx * $holder.width()) + 'px'
    height: Math.round(ry * $holder.height()) + 'px'
    marginLeft: '-' + Math.round(rx * coords.x) + 'px'
    marginTop: '-' + Math.round(ry * coords.y) + 'px'
  $('#user_thumb_x').val(coords.x)
  $('#user_thumb_y').val(coords.y)
  $('#user_thumb_w').val(coords.w)

Application.bindJcrop = ($context) ->
  if $thumb = $context.find('.thumbnail img')
    $orig = $context.find('.original img')
    x = $orig.data('thumb-x') || 0
    y = $orig.data('thumb-y') || 0
    x2 = x + $orig.data('thumb-w') || 400
    y2 = y + $orig.data('thumb-w') || 400
    jcrop = null
    $context.find('.original img').Jcrop
      onChange: showPreview
      onSelect: showPreview
      aspectRatio: 1
      minSize: [ 77, 77 ]
      setSelect: [x, y, x2, y2]
      keySupport: false
      , ->
        jcrop = this

    $context.find('#fancybox-close').click ->
      jcrop.setSelect [x, y, x2, y2] if jcrop

    # find form in $context, including root node of $context (when $context is the form)
    formSelector = 'form.edit-thumbnail'
    $form = $context.filter(formSelector).add($context.find(formSelector))

    $form.bind 'ajax:success', ->
      d = new Date()
      parent.$.fancybox.close()
      img = $('img.profile-photo-square')
      img.attr('src',"#{img.attr('src')}?#{d.getTime()}") # Force browser to ignore cached image

    $form.bind 'ajax:error', ->
      $alert = $('<div></div>').addClass('alert').html('There was an error contacting the server. Please check your internet connection')
      $context.find('form.edit-thumbnail').before $alert

$(document).ready ->
  Application.bindJcrop($(document))

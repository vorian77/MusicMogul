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

$(document).ready ->
  $thumb = $('.thumbnail img')

  $('.original img').Jcrop
    onChange: showPreview
    onSelect: showPreview
    aspectRatio: 1
    minSize: [ 77, 77 ]
    setSelect: [0, 0, 400, 400]

  $('form.edit-thumbnail').bind 'ajax:success', ->
    parent.$.fancybox.close()
    img = $('img.profile-photo-square')
    img.attr('src',img.attr('src'))

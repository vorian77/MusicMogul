showPreview = (coords) ->
  rx = 77 / coords.w
  ry = 77 / coords.h
  $thumb = $('.thumbnail img')
  $thumb.css
    width: Math.round(rx * 400) + 'px'
    height: Math.round(ry * 400) + 'px'
    marginLeft: '-' + Math.round(rx * coords.x) + 'px'
    marginTop: '-' + Math.round(ry * coords.y) + 'px'
    $('#user_thumb_x').val(coords.x)
    $('#user_thumb_y').val(coords.y)
    $('#user_thumb_w').val(coords.w)

$(document).ready ->
  $('a.fancybox').fancybox()	

  $flash = $('.flash')
  hide_flash = -> $flash.children('div').fadeOut()
  $flash.click hide_flash
  flash_timeout = setTimeout hide_flash, 3000
  $flash.hover -> clearTimeout(flash_timeout)

  $('input[data-shows]').each (index,toggle) ->
    $toggle = $(toggle)
    $toggled = $($toggle.data('shows'))
    $toggled.toggle($toggle.is(':checked'))
    $toggle.click ->
      $toggled.toggle($toggle.is(':checked'))
	
  $thumb = $('.thumbnail img')

  $('.original img').Jcrop
    onChange: showPreview
    onSelect: showPreview
    aspectRatio: 1
    minSize: [ 77, 77 ]

  $('form.edit-thumbnail').bind 'ajax:success', ->
    console.log('Success!')

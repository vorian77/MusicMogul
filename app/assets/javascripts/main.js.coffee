showPreview = (coords) ->
  console.log('showPreview')
	rx = 77 / coords.w
	ry = 77 / coords.h
	$thumb = $('.thumbnail')
	$thumb.css
		width: Math.round(rx * $(thumb).data('original-width')) + 'px'
		height: Math.round(ry * $(thumb).data('original-height')) + 'px'
		marginLeft: '-' + Math.round(rx * coords.x) + 'px'
		marginTop: '-' + Math.round(ry * coords.y) + 'px'
	$('.thumb_x').val(coords.x)
	$('.thumb_y').val(coords.y)
	$('.thumb_w').val(coords.w)

$(document).ready ->

  $('a.fancybox').fancybox()	
  $('.flash a.close').click ->
    $('.flash').slideUp()
	
  $('input[data-shows]').each (index,toggle) ->
    $toggle = $(toggle)
    $toggled = $($toggle.data('shows'))
    $toggled.toggle($toggle.is(':checked'))
    $toggle.click ->
      $toggled.toggle($toggle.is(':checked'))

	$thumb = $('.thumbnail')
	
	$thumb.data('original-width',$thumb.width())
	$thumb.data('original-height',$thumb.height())
	
	$('.original').Jcrop
		onChange: showPreview
		onSelect: showPreview
		aspectRatio: 1
		minSize: [ 77, 77 ]

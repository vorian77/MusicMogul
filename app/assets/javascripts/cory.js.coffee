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
	

  $('.tabs-holder').easytabs
    tabs: '.tabset li'
    animate: false

  $('.tabs-holder .tab-content').map (i, content) ->
    $(".bar a[href$='\##{content.id}']").click ->
      $(".tabs-holder a[href='\##{content.id}']").trigger('click')
      false

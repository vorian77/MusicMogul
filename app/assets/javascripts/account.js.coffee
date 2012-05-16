$(document).ready ->
  $genres = $('.genres-row .choice label')
  $genres.on 'click.fanhelp', ->
    checked = $genres.children('.chk-checked').size()
    if $(this).hasClass('chk-label-active') then checked--  else checked++
    if checked > 1
      $('#genres-confirm-text').show()
    else
      $('#genres-confirm-text').hide()
  $('.btn-delete').click (e) ->
    $(this).prev().attr('value','1')
    $(this).parent('.picture-holder').fadeOut()
    false

  (->
    $box = $('.profile-box')
    return unless $box
    $box.find('form').bind 'ajax:success', ->
      $('html, body, .content').animate({scrollTop: 0 }, 300)
  )()

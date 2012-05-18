$(document).ready ->
  $genres = $('.genres-row .choice label')
  $genres.on 'click.fanhelp', ->
    checked = $genres.children('.chk-checked').size()
    if $(this).hasClass('chk-label-active') then checked--  else checked++
    if checked > 1
      $('#genres-confirm-text').show()
    else
      $('#genres-confirm-text').hide()


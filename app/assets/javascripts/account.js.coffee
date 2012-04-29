$(document).ready ->
  $genres = $('.genres-row .choice label')
  $genres.on 'click.fanhelp', ->
    if $genres.children('.chk-checked').size() > 1
      alert $('#genres-confirm-text').text()
      $genres.off 'click.fanhelp'

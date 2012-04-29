$(document).ready ->
  $genres = $('.genres-row .choice label')
  $genres.on 'click.fanhelp', ->
    if $genres.children('.chk-checked').size() > 1
      $.fancybox  $('#genres-confirm-text').html(),
        width: 400
        height: 'auto'
        padding: 40
        autoDimensions: false
        scrolling: 'no'
        overlayShow : true
        showCloseButton: true
      $('#genres-confirm-text .close').click (e) ->
        $.fancybox.close()
        e.preventDefault()

      $genres.off 'click.fanhelp'



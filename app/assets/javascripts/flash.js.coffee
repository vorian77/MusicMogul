$ ->
  hideFlash = () ->
    $(".flash").slideUp "fast", ->
      $(this).remove()

  if $(".flash").length
    $('html, body').animate({ scrollTop: 0 }, 300)
    setTimeout(hideFlash, 5000)

  $("div.flash a.close").click ->
    hideFlash()
    return false
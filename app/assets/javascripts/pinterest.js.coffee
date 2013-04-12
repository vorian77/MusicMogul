$ ->
  $('#tiles').pinterestGallery
    largeContainerID: 'largeImage'
    animateStyle: 'fade'
    gridOptions:
      autoResize: true
      container: $('#foo')
      offset: 8
      itemWidth: 220

  $("ul#tiles li").bind "cardClicked", ->
    if $("div#header-nav").length
      window.location = "/entries/" + $(this).data("entry-id")
    return false
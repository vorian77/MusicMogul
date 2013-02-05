$ ->
  loading = false

  nearBottomOfPage = () ->
    $(window).scrollTop() > $(document).height() - $(window).height() - 200

  $("nav.pagination.show_more a.next").live "click", (event) ->
    event.preventDefault()

    if loading
      return

    loading = true
    $(".loading-more").show()

    $.ajax
      url: $(this).attr("data-loading"),
      type: 'get',
      dataType: 'json',
      success: (data) ->
        $(".loading-more").hide()
        if $(".tab").length
          $(".tab:visible nav.pagination.show_more").remove()
        else
          $("nav.pagination.show_more").remove()

        if data.musicians
          $("div.main-c.tabs > div.tab.musicians").append($(data.musicians))
        else if data.fans
          $("div.main-c.tabs > div.tab.fans").append($(data.fans))
        else
          $("div.main-c").append($(data.index))
        $(document).trigger("live:follows")
        $(document).trigger("live:contracts")
        loading = false

  if $("nav.pagination.show_more").length
    $(window).scroll ->
      if nearBottomOfPage()
        if $(".tab").length
          $(".tab:visible nav.pagination.show_more a.next").click()
        else
          $("nav.pagination.show_more a.next").click()

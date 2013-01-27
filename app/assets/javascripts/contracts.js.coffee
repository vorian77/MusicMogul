$ ->
  contract_links = $("a.sign-btn").filter -> $(this).attr("href") != "#"
  contract_links.on "click", () ->
    link = $(this)
    return false if link.attr("disabled") == "disabled"
    link.attr("disabled", "disabled").attr("data-changed", "true")

  toggleLink = (link) ->
    link.toggleClass("signed")

  contract_links.on "mouseenter", () ->
    $(this).removeAttr("data-changed")
    toggleLink($(this))

  contract_links.on "mouseleave", () ->
    unless $(this).attr("data-changed")
      toggleLink($(this))

  contract_links.on "ajax:success", () ->
    link = $(this)
    if link.data("method") == "post"
      link.data("method", "delete")
      link.addClass("signed")
    else
      link.data("method", "post")
      link.removeClass("signed")
    link.removeAttr("disabled")

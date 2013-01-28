$ ->
  contract_links = $("a.sign-btn:not(.signed)").filter -> $(this).attr("href") != "#"
  contract_links.on "click", () ->
    link = $(this)
    return false if link.attr("disabled") == "disabled"
    link.attr("disabled", "disabled").attr("data-changed", "true")

  toggleLink = (link) ->
    link.toggleClass("signed")

  contract_links.on "mouseenter", () ->
    $(this).addClass("signed")

  contract_links.on "mouseleave", () ->
    unless $(this).attr("data-changed")
      $(this).removeClass("signed")

  contract_links.on "ajax:success", () ->
    link = $(this)
    link.attr("href", "#")
    link.addClass("signed")

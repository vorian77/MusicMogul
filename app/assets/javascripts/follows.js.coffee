$ ->
  $("a[href='#']").on "click", (e) ->
    e.preventDefault()

  follow_links = $("a.follow-btn").filter -> $(this).attr("href") != "#"
  follow_links.on "click", () ->
    link = $(this)
    return false if link.attr("disabled") == "disabled"
    link.attr("disabled", "disabled").attr("data-changed", "true")

  toggleLink = (link) ->
    link.toggleClass("following")
    if link.html() == "Follow"
      link.html("Following")
    else
      link.html("Follow")

  follow_links.on "mouseenter", () ->
    $(this).removeAttr("data-changed")
    toggleLink($(this))

  follow_links.on "mouseleave", () ->
    unless $(this).attr("data-changed")
      toggleLink($(this))

  follow_links.on "ajax:success", () ->
    link = $(this)
    if link.data("method") == "post"
      link.data("method", "delete")
      link.html("Following").addClass("following")
    else
      link.data("method", "post")
      link.html("Follow").removeClass("following")
    link.removeAttr("disabled")

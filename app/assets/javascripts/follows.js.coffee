$ ->
  follow_links = $("a.follow-btn").filter -> $(this).attr("href") != "#"
  follow_links.on "click", () ->
    link = $(this)
    return false if link.attr("disabled") || signed(link)
    link.attr("disabled", "disabled").attr("data-changed", "changed")

  toggleLink = (link) ->
    unless signed(link)
      link.toggleClass("following")
      if link.html() == "Follow"
        link.html("Following")
      else
        link.html("Follow")

  signed = (link) ->
    link.next("a.sign-btn").hasClass("signed")

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

$ ->
  follow_links = $("a.red-follow, a.gray-follow")
  follow_links.live "click", () ->
    $(this).attr("disabled", "disabled")

  follow_links.live "ajax:success", () ->
    link = $(this)
    if link.html() == "Follow"
      link.removeClass("gray-follow").addClass("red-follow")
      link.data("method", "delete")
      link.html("Following")
    else
      link.removeClass("red-follow").addClass("gray-follow")
      link.data("method", "post")
      link.html("Follow")
    link.removeAttr("disabled")

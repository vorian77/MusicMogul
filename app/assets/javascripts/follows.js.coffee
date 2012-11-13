$ ->
  $("form.follow").live "submit", () ->
    $(this).find(":submit").attr("disabled", "disabled")

  $("form.follow").live "ajax:success", () ->
    submit = $(this).find(":submit")
    submit.removeAttr("disabled")
    if submit.val() == "Follow"
      $(this).find("> div:first").prepend("<input name='_method' type='hidden' value='delete'>")
      submit.val("Following")
    else
      $(this).find("input[name=_method]").remove()
      submit.val("Follow")

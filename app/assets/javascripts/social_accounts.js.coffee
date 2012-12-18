$ ->
  $("input[data-default-prefix]").keyup ->
    if !$(this).val().match new RegExp("^" + $(this).data("default-prefix"))
      $(this).val($(this).data("default-prefix"))

$ ->
  $("input[data-default-prefix]").keyup ->
    if ($(this).val().length < $(this).data("default-prefix").length)
      $(this).val($(this).data("default-prefix"))

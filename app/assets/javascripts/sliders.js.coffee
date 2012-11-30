$ ->
  $(".red-line").slider
    range: "max"
    min: 1
    max: 10
    step: 1
    create: (event, ui) ->
      $(this).closest("div.progress-box").find("input.hidden:first").val(1)
    slide: (event, ui) ->
      $(this).closest("div.progress-box").find("input.hidden:first").val(ui.value)

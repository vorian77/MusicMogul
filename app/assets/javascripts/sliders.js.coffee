$ ->
  $(".slider-input").slider
    min: 1
    max: 10
    step: 1
    create: (event, ui) ->
      $(this).next('input').val(1)
      $(this).parent().find('span.slider-value').html("1")
    slide: (event, ui) ->
      $(this).next('input').val(ui.value)
      $(this).parent().find('span.slider-value').html(ui.value)

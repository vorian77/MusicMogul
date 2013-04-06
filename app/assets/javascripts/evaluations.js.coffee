$ ->
  $("form#new_evaluation").submit ->
    if allZeroes()
      if confirm "Are you sure you want to leave an all '0' evaluation?"
        return true
      else
        return false

  allZeroes = () ->
    _.all($("div.evaluation-slider input.hidden"), (input) -> $(input).val() == "0")
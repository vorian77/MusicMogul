$ ->
  $("form.contact").submit ->
    $("span.error").hide()
    $.each ["contact-name", "contact-email", "contact-subject", "contact-message"], (index, value) ->
      unless $("#" + value).val().length
        $("#" + value).next("span.error").show()
    return $("span.error:visible").length == 0
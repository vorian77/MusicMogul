$ ->
  if $("div.clock").length
    JBCountDown
      secondsColor: "#d20300"
      minutesColor: "#d20300"
      hoursColor: "#d20300"
      daysColor: "#d20300"

      endDate: $("[data-end-date]").data("end-date")
      now: $("[data-now]").data("now")
      seconds:$("[data-seconds]").data("seconds")

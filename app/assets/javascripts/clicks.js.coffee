$ ->
  $("[data-click-object]").live "click", () ->
    $.ajax
      type: "POST",
      url: "/clicks.json"
      data:
        entry_id: $("[data-entry-id]").data("entry-id")
        object: $(this).data("click-object")
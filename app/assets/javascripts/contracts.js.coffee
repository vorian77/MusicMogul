$ ->
  contract_links = $("a.sign-btn:not(.signed)").filter -> !$(this).attr("disabled")
  contract_links.on "click", () ->
    showConfirm($(this).data("contract-confirm-attributes"))
    return false

  showConfirm = (attributes) ->
    $.colorbox
      html: ich.sign_confirm(attributes)
      scrolling: false
      maxWidth: '75%'
      maxHeight: '75%'
      opacity: 0.3
      onComplete: ->
        $.colorbox.resize()

  contract_links.on "mouseenter", () ->
    $(this).addClass("signed")

  contract_links.on "mouseleave", () ->
    $(this).removeClass("signed")

  $(".sign-buttons a.confirm").live "click", () ->
    id = $(this).closest("[data-entry-id]").data("entry-id")
    link = $("a#sign_entry_" + id)
    link.prev("a.follow-btn:not(.following)").click()
    link.addClass("signed")
    $.colorbox.close()

  $(".sign-buttons a.btn-grey").live "click", () ->
    $.colorbox.close()
    return false
$ ->
  contract_links = $("a.sign-btn:not(.signed)").filter -> !$(this).attr("disabled")
  contract_links.on "click", () ->
    showConfirm($(this).data("contract-confirm-attributes"))
    return false

  showConfirm = (attributes) ->
    attributes.contracts_remaining = contractsRemaining() if $("[data-contract-limit]").length
    $.colorbox
      html: ich.sign_confirm(attributes)
      scrolling: false
      maxWidth: '75%'
      maxHeight: '75%'
      opacity: 0.3
      onComplete: ->
        $.colorbox.resize()

  contractsRemaining = () ->
    $("[data-contract-limit]").data("contract-limit") - $("[data-used-contract-count]").data("used-contract-count") - 1

  contract_links.on "mouseenter", () ->
    $(this).addClass("signed")

  contract_links.on "mouseleave", () ->
    $(this).removeClass("signed")

  removeSignButtons = () ->
    $("a.sign-btn:not(.signed)").remove()

  updateScorecard = () ->
    scorecard = $("[data-scorecard-path]")
    $.ajax
      url: scorecard.data("scorecard-path")
      success: (data) ->
        open = scorecard.find("div.hidden-row").css("display") == "block"
        scorecard.replaceWith(data.scorecard)
        $("a.list-handle").click() if open
        removeSignButtons() if contractsRemaining() < 0

  $(".sign-buttons a.confirm").live "click", () ->
    id = $(this).closest("[data-entry-id]").data("entry-id")
    link = $("a#sign_entry_" + id)
    link.prev("a.follow-btn:not(.following)").click()
    link.addClass("signed")
    $.colorbox.close()

  $(".sign-buttons a.btn-grey").live "click", () ->
    $.colorbox.close()
    return false

  $(".sign-buttons a.confirm").live "ajax:success", () ->
    updateScorecard()

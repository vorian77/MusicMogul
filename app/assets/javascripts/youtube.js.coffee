$ ->
  $("div[data-youtube-id]").each ->
    videoID = $(this).attr("data-youtube-id")
    params = { allowScriptAccess: "always", wmode: "opaque" }
    atts = { id: "ytPlayer" }
    width = "460"
    height = "310"
    url = "http://www.youtube.com/v/" + videoID + "?version=3&enablejsapi=1"
    swfobject.embedSWF(url, $(this).attr("id"), width, height, "8", null, null, params, atts)
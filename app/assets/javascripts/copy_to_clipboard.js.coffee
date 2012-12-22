$ ->
  if $("#referral-button").length
    ZeroClipboard.setMoviePath('swfs/ZeroClipboard.swf')
    clip = new ZeroClipboard.Client("#referral-button")
    clip.on 'complete', (client, args) ->
      alert("Copied to clipboard.")

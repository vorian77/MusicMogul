$ ->
  $('input.upload-field').fileupload
    dataType: 'json'
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
    add: (e, data) ->
      if /(\.|\/)(gif|jpe?g|png)$/i.test data.files[0].name
        if $("img.cover-image").length
          $("img.cover-image").before("<div class='cover-image'></div>")
          $("img.cover-image").remove()
        $("div.cover-image").html("0%")
        data.submit()
      else
        alert "You must upload a JPG, PNG, or GIF file."
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      if progress == 100
        $("div.cover-image").addClass("processing")
        $("div.cover-image").html("processing&hellip;")
      else
        $("div.cover-image").html(progress + "%")
    done: (e, data) ->
      $("div.fake-upload > p").html("Change File")
      profile_photo = if data.result.entries && data.result.entries.length
        data.result.entries[0].profile_photo
      else
        data.result.profile_photo
      $("input.upload-value").val(profile_photo.url.split("/").pop())
      url = profile_photo.medium.url
      if $("div.cover-image").length
        $("div.cover-image").after("<img class='cover-image' src='" + url + "'/>")
        $("div.cover-image").remove()
      else
        $("img.cover-image").attr("src", url)
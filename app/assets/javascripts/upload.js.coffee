$ ->
  $('input#entry_profile_photo').fileupload
    dataType: 'json'
    add: (e, data) ->
      if $("img.cover-image").length
        $("img.cover-image").before("<div class='cover-image'></div>")
        $("img.cover-image").remove()
      $("div.cover-image").html("0%")
      data.submit()
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      if progress == 100
        $("div.cover-image").addClass("processing")
        $("div.cover-image").html("processing&hellip;")
      else
        $("div.cover-image").html(progress + "%")
    done: (e, data) ->
      $("div.fake-upload > p").html("Change File")
      $("input.upload-value").val(data.result.profile_photo.url.split("/").pop())
      url = data.result.profile_photo.medium.url
      if $("div.cover-image").length
        $("div.cover-image").after("<img class='cover-image' src='" + url + "'/>")
        $("div.cover-image").remove()
      else
        $("img.cover-image").attr("src", url)
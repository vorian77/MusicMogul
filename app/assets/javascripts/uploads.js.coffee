jQuery ->

  uploaderHost = "http://fanhelp.mvp.s3.amazonaws.com"

  xhrUploadProgressSupported = () ->
    xhr = new XMLHttpRequest()
    xhr && ('upload' of xhr) && ('onprogress' of xhr.upload)


  # Can only track progress if size property is present on files.
  progressSupported = xhrUploadProgressSupported()


  $('.uploading_files').on 'click', '.uploading_file .remove_link', (e) ->
    uuid = $(this).parent().data('uuid')
    $(this).parent().remove()
    $('.uploader:visible iframe')[0].contentWindow.postMessage(JSON.stringify({ eventType: 'abort upload', uuid: uuid }), uploaderHost);

  $(window).on "message", (event) ->

    event = event.originalEvent

    if event.origin != uploaderHost
      return

    data = JSON.parse(event.data)

    eventType = data.eventType
    delete data.eventType

    switch eventType

      when 'add upload'
        $uploader = $(data.uploader_id)
        $uploader = $('div.no-file').filter(':first') unless $uploader
        $uploader.removeClass('no-file')
        
        if progressSupported
          $uploader.addClass('uploading-with-progress')
        else
          $uploader.addClass('uploading-with-spinner')

      when 'upload progress'
        if progressSupported
          $('.file-uploading .progress').css('width', (data.progress / 100) * 270)

      when 'upload done'
        $uploader = $('.uploading-with-progress, .uploading-with-spinner')
        $uploader.removeClass('uploading-with-progress').addClass('uploaded-file')

        if video = $uploader.find('video')[0]
          video.src = "https://s3.amazonaws.com/fanhelp.mvp/#{data.s3_key}"
          video.load()
        if $box = $uploader.find('.profile-photo-box')
          $img = $('<img>').attr('src',"https://s3.amazonaws.com/fanhelp.mvp/#{data.s3_key}").attr('width',240).attr('height',240).addClass('profile-photo_square')
          $box.html($img).append('<a href="#edit-thumbnail" class="lightbox crop">Click to crop photo</a>')

        $.ajax $uploader.find('iframe').data('create-resource-url'),
          type: 'POST',
          data: data


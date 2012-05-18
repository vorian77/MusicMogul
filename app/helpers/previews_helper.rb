module PreviewsHelper
  def parse_youtube url
    return url if url.include?('embed')
    regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
    "http://www.youtube.com/embed/#{url.match(regex)[1]}"
  end
end
module ApplicationHelper
  def type_from_path(path)
    ext = File.extname(path)
    case
    when %w(.ogg .ogv).include?(ext)
      "video/ogg"
    when %w(.mov).include?(ext)
      "video/mov"
    when %w(.flv).include?(ext)
      "video/flv"
    else
      "video/mp4"
    end
  end

  def percentage_evaluated(user)
    number_to_percentage((user.evaluations.count / Entry.count.to_f) * 100, precision: 0)
  end
end

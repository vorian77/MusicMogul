module ApplicationHelper
  def contestant_count_for_user(user)
    user.show_explicit_videos? ? Entry.count : Entry.unexplicit.count
  end

  def percentage_evaluated(user)
    number_to_percentage((user.evaluations.count / contestant_count_for_user(user).to_f) * 100, precision: 0)
  end

  def should_show_explicit_content_warning?(entry)
    user_signed_in? && entry.has_explicit_content? && !current_user.show_explicit_videos?
  end

  def show_social?(entry)
    entry.facebook? || entry.twitter? || entry.pinterest? || entry.youtube? || entry.website?
  end

  def contest_started?
    Time.now > contest_start_date
  end

  def contest_pending?
    Time.now < contest_start_date
  end

  def contest_start_date
    Date.parse("12/30/2012")
  end
end

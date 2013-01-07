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

  def contest_pending?
    !contest_started?
  end

  def contest_started?
    Time.now >= Time.zone.parse(Contest::FIRST_START_DATE)
  end
end

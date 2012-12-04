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

  def birth_date_value(user)
    if @user.birth_date?
      @user.birth_date.strftime("%m/%d/%Y")
    else
      "        /         /"
    end
  end
end

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
    !contest_running?
  end

  def contest_running?
    Contest.active.present?
  end

  def evaluation_datetime(created_at)
    date = if created_at.to_date == Date.today
             "Today"
           elsif created_at.to_date == Date.yesterday
             "Yesterday"
           else
             created_at.strftime("%b %d, %Y")
           end
    time = created_at.strftime("%I:%M%p")
    [date, time].join(", ")
  end

  def signee_width_percentage
    %w(0% 18% 39% 59% 80% 100%)[current_user.contracts.count]
  end

  def contract_confirm_attributes(entry)
    {id: entry.id,
     create_contract_path: entry_contracts_path(entry),
     contracts_remaining: User::CONTRACT_LIMIT - current_user.contracts.count - 1,
     photo_url: entry.profile_photo.medium.url,
     stage_name: entry.stage_name,
     genre: entry.genre,
     hometown: entry.hometown,
     evaluation: number_with_precision(current_user.evaluation_for(entry).try(:overall_score), precision: 1)
    }.to_json
  end

  def contest_timer_attributes
    {"data-end-date" => Contest.count > 0 ? (contest_pending? ? Contest.first.start_date.to_i : Contest.first.end_date.to_i) : "0", "data-now" => Time.now.to_i, "data-seconds" => Time.now.strftime("%S")}
  end

  def contest_date_text
    if contest_pending?
      "Judging Starts #{Contest.count > 0 ? Contest.first.start_date.strftime("%m/%d/%y at %l%p %Z") : "---"}"
    else
      "Judging Ends #{Contest.count > 0 ? Contest.first.end_date.strftime("%m/%d/%y at %l%p %Z") : "---"}"
    end
  end
end

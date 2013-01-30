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
     photo_url: entry.profile_photo.url(:medium),
     stage_name: entry.stage_name,
     genre: entry.genre,
     hometown: entry.hometown,
     evaluation: number_with_precision(current_user.evaluation_for(entry).try(:overall_score), precision: 1)
    }.to_json
  end
end

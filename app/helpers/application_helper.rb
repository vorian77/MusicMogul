module ApplicationHelper
  def contest_pending?
    Contest.pending.present? && Contest.running.empty?
  end

  def contest_running?
    Contest.running.present?
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
    data_end_date = if contest_pending?
                      Contest.pending.first.try(:start_date)
                    elsif contest_running?
                      Contest.running.first.try(:end_date)
                    else
                      SiteConfiguration.next_contest_start_date
                    end
    {"data-end-date" => data_end_date.try(:to_i) || "0", "data-now" => Time.now.to_i, "data-seconds" => Time.now.strftime("%S")}
  end

  def contest_date_text
    if contest_pending?
      "Judging Starts #{Contest.count > 0 ? Contest.first.start_date.strftime("%m/%d/%y at %l%p %Z") : "---"}"
    elsif contest_running?
      "Judging Ends #{Contest.count > 0 ? Contest.first.end_date.strftime("%m/%d/%y at %l%p %Z") : "---"}"
    else
      "Next Contest Begins #{SiteConfiguration.next_contest_start_date.present? ? SiteConfiguration.next_contest_start_date.strftime("%m/%d/%y at %l%p %Z") : "---"}"
    end
  end

  def show_my_evaluations_tab?(user)
    user && (user.fan? || user.entries.with_contest.present?)
  end
end

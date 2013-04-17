class SiteConfiguration < ActiveRecord::Base
  attr_accessible :fan_welcome_email_id, :musician_welcome_email_id, :contest_rules, :next_contest_start_date,
                  :leaderboard_max_contestant_rank, :leaderboard_max_mogul_rank

  belongs_to :fan_welcome_email, class_name: "Email"
  belongs_to :musician_welcome_email, class_name: "Email"

  validate :ensure_only_one_record

  class << self
    [:contest_rules,
     :fan_welcome_email,
     :musician_welcome_email,
     :next_contest_start_date,
     :leaderboard_max_contestant_rank,
     :leaderboard_max_mogul_rank].each do |method|
      define_method method do
        first.try(method)
      end
    end
  end

  private

  def ensure_only_one_record
    errors.add(:base, "can only be one") if self.new_record? && self.class.count > 0
  end
end

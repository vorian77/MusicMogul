class SiteConfiguration < ActiveRecord::Base
  attr_accessible :fan_welcome_email_id, :musician_welcome_email_id, :contest_rules

  belongs_to :fan_welcome_email, class_name: "Email"
  belongs_to :musician_welcome_email, class_name: "Email"

  validate :ensure_only_one_record

  class << self
    def contest_rules
      first.try(:contest_rules)
    end

    def fan_welcome_email
      first.try(:fan_welcome_email)
    end

    def musician_welcome_email
      first.try(:musician_welcome_email)
    end
  end

  private

  def ensure_only_one_record
    errors.add(:base, "can only be one") if self.new_record? && self.class.count > 0
  end
end

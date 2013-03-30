class Contest < ActiveRecord::Base
  FIRST_START_DATE = "2/3/13 12:00PM"

  attr_accessible :start_date, :end_date, :show_contestants

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :ensure_end_date_is_after_start_date
  #validate :ensure_contests_are_not_overlapping

  class << self
    def active
      where("start_date <= :now and end_date >= :now", now: Time.now).first
    end

    def next
      where("start_date >= ?", Time.now).order("start_date").first
    end
  end

  private

  def ensure_end_date_is_after_start_date
    return unless start_date? && end_date?
    errors.add(:end_date, "must be after start date") if end_date < start_date
  end
  #
  #def ensure_contests_are_not_overlapping
  #  last_contest = Contest.order("start_date").last
  #  return unless start_date? && last_contest
  #  errors.add(:start_date, "cannot overlap with existing contests") if start_date < last_contest.end_date
  #end
end
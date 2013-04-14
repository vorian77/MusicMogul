class Contest < ActiveRecord::Base
  LEADERBOARD_DISPLAY_OPTIONS = %w(Hide Anonymous Full)

  attr_accessible :start_date, :end_date, :show_contestants, :leaderboard_display, :artist_sign_up_end_date

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :leaderboard_display, inclusion: {in: LEADERBOARD_DISPLAY_OPTIONS, allow_blank: true}
  validate :ensure_end_date_is_after_start_date
  #validate :ensure_contests_are_not_overlapping

  scope :open, lambda { where("artist_sign_up_end_date >= ?", Time.now) }
  scope :pending, lambda { where("start_date > ?", Time.now) }
  scope :running, lambda { where("start_date <= :now and end_date >= :now", now: Time.now) }

  class << self
    def active
      running.first
    end

    def next
      where("start_date >= ?", Time.now).order("start_date").first
    end
  end

  def show_anonymous_leaderboard?
    self.leaderboard_display == "Anonymous"
  end

  def show_full_leaderboard?
    self.leaderboard_display == "Full"
  end

  def show_leaderboard_nav?
    %w(Anonymous Full).include? self.leaderboard_display
  end

  def running?
    start_date <= Time.now and end_date >= Time.now
  end

  def started?
    start_date <= Time.now
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
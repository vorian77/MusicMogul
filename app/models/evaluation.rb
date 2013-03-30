class Evaluation < ActiveRecord::Base
  POINT_VALUE = 250
  COMMENT_PROMPT = "Write something encouraging or constructive to the contestant..."

  belongs_to :entry
  belongs_to :user, include: :evaluations

  attr_accessible :music_score, :vocals_score, :presentation_score, :comment, :entry_id

  validates :entry, presence: true
  validates :user, presence: true

  validates :music_score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_nil: true}
  validates :vocals_score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_nil: true}
  validates :presentation_score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
  validates :overall_score, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
  #validate :ensure_invited_user
  validate :ensure_fan

  before_validation :calculate_overall_score, :nullify_blank_comments
  after_save :cache_points
  after_destroy :cache_points

  private

  def calculate_overall_score
    return unless entry.present? && presentation_score.present?
    self.overall_score = ((music_score || 0) + (vocals_score || 0) + presentation_score) / entry.component_count.to_f
  end

  def cache_points
    self.entry.cache_points!
    self.user.cache_points!
  end

  def ensure_fan
    return unless user.present?
    errors.add(:user, "cannot be a contestant") if user.musician?
  end

  def ensure_invited_user
    return unless user.present?
    errors.add(:user, "must be invited") if user.uninvited?
  end

  def nullify_blank_comments
    self.comment = nil if comment == COMMENT_PROMPT
  end
end

class Evaluation < ActiveRecord::Base
  POINT_VALUE = 1000

  belongs_to :entry
  belongs_to :user, include: :evaluations

  attr_accessible :music_score, :vocals_score, :presentation_score, :comment, :entry_id

  validates :entry, presence: true
  validates :user, presence: true

  validates :music_score, numericality: {greater_than: 0, less_than: 11, allow_nil: true}
  validates :vocals_score, numericality: {greater_than: 0, less_than: 11, allow_nil: true}
  validates :presentation_score, numericality: {greater_than: 0, less_than: 11}
  validates :overall_score, numericality: {greater_than: 0, less_than: 11}
  #validate :ensure_invited_user

  before_validation :calculate_overall_score
  after_save :calculate_entry_points

  private

  def calculate_overall_score
    return unless presentation_score?
    self.overall_score = ((music_score || 0) + (vocals_score || 0) + presentation_score) / entry.component_count.to_f
  end

  def calculate_entry_points
    self.entry.update_attribute(:points, entry.evaluations.sum(:overall_score))
  end

  def ensure_invited_user
    return unless user.present?
    errors.add(:user, "must be invited") if user.uninvited?
  end
end

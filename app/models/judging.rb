class Judging < ActiveRecord::Base
  belongs_to :contest
  belongs_to :entry
  belongs_to :user

  attr_accessible :active, :genres_array, :music_score, :vocals_score, :presentation_score, :comment, :entry_id

  validates :entry, presence: true
  validates :user, presence: true

  validates :music_score, numericality: {only_integer: true, greater_than: 0, less_than: 11}
  validates :vocals_score, numericality: {only_integer: true, greater_than: 0, less_than: 11}
  validates :presentation_score, numericality: {only_integer: true, greater_than: 0, less_than: 11}
  validates :overall_score, numericality: {only_integer: true, greater_than: 0, less_than: 11}

  before_validation :calculate_overall_score
  after_save :calculate_entry_points

  def genres_array=(g)
    self.genres = g.join(', ')
  end

  def genres_array
    self.genres.to_s.split(/,\s?/)
  end

  private

  def calculate_overall_score
    return unless music_score? && vocals_score? && presentation_score?
    self.overall_score = (music_score + vocals_score + presentation_score) / 3
  end

  def calculate_entry_points
    self.entry.update_attribute(:points, entry.judgings.sum(:overall_score))
  end
end

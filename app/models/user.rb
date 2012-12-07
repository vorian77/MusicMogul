class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :player_name, :hometown,:gender,
    :birth_date, :show_explicit_videos, :receive_email_updates, :profile_photo, :confirmed_at, :admin

  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :entries, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :evaluations, dependent: :destroy

  has_many :followed_entries, through: :follows, source: :entry

  validates :hometown, presence: true
  validates :player_name, presence: true
  validate :ensure_birth_date_is_at_13_years_ago

  def average_evaluation_score
    return 0 unless evaluations.present?
    evaluations.sum(:overall_score) / evaluations.count.to_f
  end

  def display_name
    self.player_name.presence || self.email
  end

  def evaluation_for(entry)
    evaluations.where(entry_id: entry.id).first
  end

  def follows?(entry)
    follows.where(entry_id: entry.id).count > 0
  end

  def has_evaluated?(entry)
    evaluation_for(entry).present?
  end

  def profile_complete?
    player_name? && hometown? && birth_date? && gender? && profile_photo?
  end

  protected

  def ensure_birth_date_is_at_13_years_ago
    return unless birth_date?
    if birth_date.to_date > 13.years.ago.to_date
      errors.add(:birth_date, "must be at least 13 years old")
    end
  end
end

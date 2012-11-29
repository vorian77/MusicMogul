class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,
         :omniauthable

  # Set up accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name, :first_name, :last_name, :zip, :country, :birth_year,
    :interview_status, :profile_name, :hometown, :genre, :bio, :facebook,
    :twitter, :phone, :profile_photo_square, :profile_photo_landscape,
    :remove_profile_photo_square, :remove_profile_photo_landscape, :thumb_x,
    :thumb_y, :thumb_w, :account_type, :evaluations_attributes, :source,
    :genre, :youtube, :current_tab, :gender,
    :remove_profile_video, :thumb_x, :thumb_y, :thumb_w, :youtube_url,
    :confirmed_at, :birth_date, :show_explicit_videos, :receive_email_updates,
    :profile_photo

  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :entries, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :evaluations, dependent: :destroy

  has_many :followed_entries, through: :follows, source: :entry

  validates :hometown, presence: true
  validates :profile_name, presence: true
  validate :ensure_birth_date_is_at_13_years_ago

  def average_evaluation_score
    return 0 unless evaluations.present?
    evaluations.sum(:overall_score) / evaluations.count.to_f
  end

  def display_name
    self.profile_name.presence || self.email
  end

  def follows?(entry)
    follows.where(entry_id: entry.id).count > 0
  end

  def has_evaluated?(entry)
    evaluations.where(entry_id: entry.id).count > 0
  end

  protected

  def ensure_birth_date_is_at_13_years_ago
    return unless birth_date?
    if birth_date.to_date > 13.years.ago.to_date
      errors.add(:birth_date, "must be at least 13 years old")
    end
  end
end

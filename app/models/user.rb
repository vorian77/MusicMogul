class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :username, :hometown,:gender,
    :birth_date, :show_explicit_videos, :receive_email_updates, :profile_photo, :confirmed_at, :admin,
    :musician

  mount_uploader :profile_photo, ProfilePhotoUploader

  attr_accessor :invitation_token

  belongs_to :inviter, class_name: "User"
  has_many :entries, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :invited_users, class_name: "User", foreign_key: "inviter_id"

  has_many :followed_entries, through: :follows, source: :entry

  validates :username, presence: true, uniqueness: true
  validates :referral_token, presence: true, uniqueness: true
  validate :ensure_birth_date_is_at_13_years_ago

  before_validation :set_referral_token, :shorten_referral_link
  before_create :set_inviter

  scope :invited, where("inviter_id is not null")

  def average_evaluation_score
    return 0 unless evaluations.present?
    evaluations.sum(:overall_score) / evaluations.count.to_f
  end

  def display_name
    self.username.presence || self.email
  end

  def evaluation_for(entry)
    evaluations.where(entry_id: entry.id).first
  end

  def fan?
    !musician?
  end

  def follows?(entry)
    follows.where(entry_id: entry.id).count > 0
  end

  def has_evaluated?(entry)
    evaluation_for(entry).present?
  end

  def profile_complete?
    username? && hometown? && birth_date? && gender? && profile_photo?
  end

  def referral_link
    "http://#{ActionMailer::Base.default_url_options[:host]}/?referral_token=#{referral_token}"
  end

  def uninvited?
    !inviter.present?
  end

  protected

  def ensure_birth_date_is_at_13_years_ago
    return unless birth_date?
    if birth_date.to_date > 13.years.ago.to_date
      errors.add(:birth_date, "must be at least 13 years old")
    end
  end

  def set_inviter
    self.inviter = User.find_by_referral_token(invitation_token) if invitation_token.present?
  end

  def set_referral_token
    self.referral_token = Digest::SHA1.hexdigest([Time.now, rand].join) unless self.referral_token.present?
  end

  def shorten_referral_link
    return unless Rails.env.production? || self.shortened_referral_link?
    Bitly.use_api_version_3
    bitly = Bitly.new("mrhaddad", "R_83dd8224bba6e587008fb1e785793416")
    self.shortened_referral_link = bitly.shorten(self.referral_link).short_url
  end
end

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :username, :hometown, :show_explicit_videos,
                  :receive_email_updates, :profile_photo, :confirmed_at, :admin, :musician

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

  before_validation :set_referral_token, :shorten_referral_link
  before_create :set_inviter

  scope :invited, where("inviter_id is not null")
  scope :complete, where("username is not null and profile_photo is not null and hometown is not null")
  scope :musician, where("musician = ?", true)

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
    username? && hometown? && profile_photo?
  end

  def referral_link
    "http://#{ActionMailer::Base.default_url_options[:host]}/?referral_token=#{referral_token}"
  end

  def uninvited?
    !inviter.present?
  end

  protected

  def set_inviter
    self.inviter = User.find_by_referral_token(invitation_token) if invitation_token.present?
  end

  def set_referral_token
    self.referral_token = Digest::SHA1.hexdigest([Time.now, rand].join) unless self.referral_token.present?
  end

  def shorten_referral_link
    return if Rails.env.development? || Rails.env.test? || self.shortened_referral_link?
    Bitly.use_api_version_3
    bitly = Bitly.new("mrhaddad", "R_83dd8224bba6e587008fb1e785793416")
    self.shortened_referral_link = bitly.shorten(self.referral_link).short_url
  end
end

class User < ActiveRecord::Base
  CONTRACT_LIMIT = 5
  MUSICIAN_INVITATION_LIMIT = 25
  FAN_INVITATION_LIMIT = 10

  MUSICIAN_INVITED_USER_POINT_VALUE = 30
  FAN_INVITED_USER_POINT_VALUE = 500

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :username, :hometown, :show_explicit_videos,
                  :receive_email_updates, :profile_photo, :confirmed_at, :admin, :musician, :tos, :time_zone,
                  :entries_attributes

  mount_uploader :profile_photo, ProfilePhotoUploader

  attr_accessor :invitation_token

  belongs_to :inviter, class_name: "User"
  has_many :clicks, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :invited_users, class_name: "User", foreign_key: "inviter_id"
  has_many :followed_entries, through: :follows, source: :entry
  has_many :signed_entries, through: :contracts, source: :entry

  accepts_nested_attributes_for :entries, limit: 1

  validates :username, presence: {message: "Username is required"}, uniqueness: {message: "Username has already been registered"}
  validates :email, presence: {message: "Email is required"}, uniqueness: {message: "Email has already been registered"}
  validates :password, on: :create, presence: {message: "Password is required"}
  validates :referral_token, presence: true, uniqueness: true
  validates :tos, acceptance: {accept: true, message: "You must agree to Terms to register", allow_nil: false}
  validates_confirmation_of :password, message: "Passwords do not match"

  before_validation :set_referral_token, :shorten_referral_link
  before_create :set_inviter
  after_create :create_first_entry, if: :musician?
  after_create :cache_inviter_points

  scope :invited, where("inviter_id is not null")
  scope :complete, where("username is not null and profile_photo is not null and hometown is not null")
  scope :fan, where("musician = ?", false)
  scope :musician, where("musician = ?", true)

  def average_evaluation_score
    return 0 unless evaluations.present?
    evaluations.sum(:overall_score) / evaluations.count.to_f
  end

  [:music, :vocals, :presentation].each do |type|
    define_method "average_#{type}_score" do
      return 0 unless evaluations.where("#{type}_score is not null").present?
      evaluations.sum("#{type}_score") / evaluations.where("#{type}_score is not null").count.to_f
    end
  end

  def cache_points!
    update_attribute(:cached_points, points)
  end

  def confirm!
    super
    WelcomeMailer.new_fan(self).deliver if self.fan?
  end

  def contract_points
    signed_entries.sum(:points).round
  end

  def evaluation_for(entry)
    evaluations.where(entry_id: entry.id).first
  end

  def evaluation_points
    evaluations.count * Evaluation::POINT_VALUE
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

  def invitation_limit
    musician? ? MUSICIAN_INVITATION_LIMIT : FAN_INVITATION_LIMIT
  end

  def invitation_points
    invited_users.count * (self.musician? ? MUSICIAN_INVITED_USER_POINT_VALUE : FAN_INVITED_USER_POINT_VALUE)
  end

  def late_adopter?
    inviter && !inviter.invited_users.order("created_at").limit(inviter.invitation_limit).include?(self)
  end

  def observer?
    uninvited? || late_adopter?
  end

  def photo
    return profile_photo if profile_photo?
    return entries.first.profile_photo if entries.present? && entries.first.profile_photo?
    profile_photo
  end

  def points
    if fan?
      evaluation_points + contract_points + invitation_points
    else
      (entries.first.try(:points) || 0) + invitation_points
    end.round
  end

  def rank
    if fan?
      self.class.fan.order("cached_points desc").uniq.pluck(:cached_points).index(self.cached_points) + 1
    else
      self.class.musician.order("cached_points desc").uniq.pluck(:cached_points).index(self.cached_points) + 1
    end
  end

  def referral_link
    "http://#{ActionMailer::Base.default_url_options[:host]}/?referral_token=#{referral_token}"
  end

  def signed?(entry)
    contracts.where(entry_id: entry.id).count > 0
  end

  def uninvited?
    !inviter.present?
  end

  private

  def cache_inviter_points
    self.inviter.cache_points! if inviter.present?
  end

  def create_first_entry
    entries.create
  end

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

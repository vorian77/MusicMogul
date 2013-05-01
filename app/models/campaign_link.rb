class CampaignLink < ActiveRecord::Base
  attr_accessible :description

  has_many :artist_sign_ups, class_name: "User", conditions: "musician = true"
  has_many :fan_sign_ups, class_name: "User", conditions: "musician = false"

  validates :description, presence: true

  before_validation :set_token, :shorten_link

  def link
    "http://#{ActionMailer::Base.default_url_options[:host]}/?campaign_token=#{token}"
  end

  private

  def set_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join) unless self.token.present?
  end

  def shorten_link
    return if Rails.env.development? || Rails.env.test? || self.shortened_link?
    Bitly.use_api_version_3
    bitly = Bitly.new("mrhaddad", "R_83dd8224bba6e587008fb1e785793416")
    self.shortened_link = bitly.shorten(self.link).short_url
  end
end

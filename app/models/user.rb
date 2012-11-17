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
    :thumb_y, :thumb_w, :account_type, :judgings_attributes, :source,
    :genre, :youtube, :current_tab, :gender,
    :remove_profile_video, :thumb_x, :thumb_y, :thumb_w, :youtube_url,
    :changing_password, :confirmed_at, :birth_date, :show_explicit_videos, :receive_email_updates,
    :profile_photo

  attr_accessor :changing_password

  #with_options :on => :create do |u|
  #  u.validates :email, :presence => true, :uniqueness => true
  #  u.validates_presence_of :password
  #end
  #
  #with_options :if => :changing_password? do |u|
  #  u.validates_presence_of :old_password
  #  u.validates_presence_of     :password
  #  u.validates_confirmation_of :password
  #  u.validates_length_of       :password, :minimum => 4, :allow_blank => true
  #end
  #
  #with_options :on => :update, :if => Proc.new { |u| u.current_tab == 'details' || u.current_tab.blank? } do |u|
  #  u.validates_presence_of :email
  #end
  #
  #with_options :on => :update, :if => Proc.new { |u| u.current_tab == 'profile' || u.current_tab.blank? } do |u|
  #  u.validates_presence_of :profile_name, :message => "User or Band Name is required."
  #  u.validates_presence_of :hometown, :message => "Hometown is required."
  #end

  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :entries, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :judgings, dependent: :destroy

  has_many :followed_entries, through: :follows, source: :entry

  validates :hometown, presence: true
  validates :profile_name, presence: true
  validate :ensure_birth_date_is_at_13_years_ago

  def average_judging_score
    return 0 unless judgings.present?
    judgings.sum(:overall_score) / judgings.count.to_f
  end

  def changing_password?
    self.changing_password.present?
  end

  def display_name
    self.profile_name.presence || self.email
  end

  def follows?(entry)
    follows.where(entry_id: entry.id).count > 0
  end

  def has_evaluated?(entry)
    judgings.where(entry_id: entry.id).count > 0
  end

  protected

  def ensure_birth_date_is_at_13_years_ago
    return unless birth_date?
    if birth_date.to_date > 13.years.ago.to_date
      errors.add(:birth_date, "must be at least 13 years old")
    end
  end
end

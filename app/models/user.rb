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
    :entries_attributes, :genre, :youtube, :current_tab, :gender,
    :remove_profile_video, :thumb_x, :thumb_y, :thumb_w, :youtube_url,
    :changing_password

  attr_accessor :account_type, :current_tab
  attr_accessor :remove_profile_video
  attr_accessor :old_password
  attr_accessor :source
  attr_accessor :changing_password

  with_options :on => :create do |u|
    u.validates :email, :presence => true, :uniqueness => true
    u.validates_presence_of :password
  end

  with_options :if => :changing_password? do |u|
    u.validates_presence_of :old_password
    u.validates_presence_of     :password
    u.validates_confirmation_of :password
    u.validates_length_of       :password, :minimum => 4, :allow_blank => true
  end

  with_options :on => :update, :if => Proc.new { |u| u.current_tab == 'details' || u.current_tab.blank? } do |u|
    u.validates_presence_of :email
    u.validates_presence_of :birth_year, :message => 'Birth year is required'
    u.validates_numericality_of :birth_year, :less_than => 12.years.ago.year, :message => 'Must be at least 13 years old'
  end
  
  with_options :on => :update, :if => Proc.new { |u| u.current_tab == 'profile' || u.current_tab.blank? } do |u|
    u.validates_presence_of :profile_name, :message => "User or Band Name is required."
    u.validates_presence_of :hometown, :message => "Hometown is required."
  end

  mount_uploader :profile_photo_square, SquareProfilePhotoUploader

  has_many :entries
  has_many :judgings

  accepts_nested_attributes_for :entries, :judgings

  before_save :parse_account_type, :if => :account_type
  
  scope :has_photo, where("users.profile_photo_square IS NOT ? AND users.profile_photo_square != ?", nil, "")
  scope :has_entry, includes(:entries).where("entries.id is not ?", nil)
  scope :genre, lambda { |genre| includes(:entries).where("entries.genre = ?", genre) }
  scope :next, lambda { |p| {:conditions => ["users.id > ?", p.id], :limit => 1, :order => "users.id"} }
  
  def display_name
    self.profile_name.presence || self.email
  end
 
  def name
    [first_name, last_name].join(' ')
  end

  def profile_video?
    self.profile_video.present?
  end

  def remove_profile_video=(remove)
    self.profile_video = nil
  end

  def profile_video_status
    if profile_video.present?
      'uploaded-file'
    elsif youtube_url.present?
      'youtube-url'
    else
      'no-file'
    end
  end

  def source
    if profile_video.present?
      'Upload'
    elsif youtube_url.present?
      'Youtube'
    end
  end

  # Temporary hack until we need more than one judging
  def judging
    self.judgings.first || self.judgings.new
  end

  # Temporary hack until we need more than one entry
  def entry
    self.entries.first || self.entries.new
  end

  def cropping?
    [thumb_x,thumb_y,thumb_w].all?(&:present?)
  end

  def self.find_for_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else
      self.create!(:email => data.email || "temp_#{Time.now.to_i}@example.com", :password => Devise.friendly_token[0,20]) 
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def changing_password?
    self.changing_password.present?
  end

  protected

  def parse_account_type
    types = account_type.to_s.split(/,\s?/)
    self.judging.update_attribute(:active,true) if types.include? 'judge'
    self.entry.update_attribute(:active,true) if types.include? 'compete'
  end

  # Callback to overwrite if confirmation is required or not.
  def confirmation_required?
    !confirmed? && !facebook? && !twitter?
  end

end

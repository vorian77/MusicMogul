class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Set up accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name, :first_name, :last_name, :zip, :country, :birthdate,
    :interview_status, :profile_name, :hometown, :genre, :bio, :facebook,
    :twitter, :phone, :profile_photo_square, :profile_photo_landscape,
    :remove_profile_photo_square, :remove_profile_photo_landscape, :thumb_x,
    :thumb_y, :thumb_w, :account_type, :judgings_attributes,
    :entries_attributes, :genre, :youtube

  attr_accessor :thumb_x, :thumb_y, :thumb_w
  attr_accessor :account_type

  with_options :on => :update do |u|
    u.validates_presence_of :first_name, :message => "First Name is required."
    u.validates_presence_of :last_name, :message => "Last Name is required."
    u.validates_presence_of :birthdate, :message => "Birthdate is required. Must be at least 13 years old."
    u.validates_presence_of :profile_name, :message => "User or Band Name is required."
    u.validates_presence_of :hometown, :message => "Hometown is required."
  end
  
  mount_uploader :profile_photo_square, SquareProfilePhotoUploader
  mount_uploader :profile_photo_landscape, LandscapeProfilePhotoUploader

  has_many :entries
  has_many :judgings

  accepts_nested_attributes_for :entries, :judgings

  before_save :parse_account_type, :if => :account_type

  def display_name
    self.profile_name.presence || self.email
  end
 
  def name
    [first_name, last_name].join(' ')
  end

  def parse_account_type
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

end

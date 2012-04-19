class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :first_name, :last_name, :zip, :country, :birthdate,
    :interview_status, :profile_name, :hometown, :genre, :bio, :facebook,
    :twitter, :phone, :profile_photo_square, :profile_photo_rectangle,
    :remove_profile_photo_square, :remove_profile_photo_rectangle
  
  attr_accessor :thumb_x, :thumb_y, :thumb_w
  
  with_options :on => :update do |u|
    u.validates_presence_of :first_name, :message => "First Name is required."
    u.validates_presence_of :last_name, :message => "Last Name is required."
    u.validates_presence_of :birthdate, :message => "Birthdate is required. Must be at least 13 years old."
    u.validates_presence_of :profile_name, :message => "User or Band Name is required."
    u.validates_presence_of :hometown, :message => "Hometown is required."
  end
  
  mount_uploader :profile_photo_square, ProfilePhotoUploader
  mount_uploader :profile_photo_rectangle, ProfilePhotoUploader
  
  def display_name
    self.profile_name.presence || self.email
  end
  
end

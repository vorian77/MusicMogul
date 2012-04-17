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
  
  validates_presence_of :first_name, :message => "First name is required"
  validates_presence_of :last_name
  
  mount_uploader :profile_photo_square, ProfilePhotoUploader
  mount_uploader :profile_photo_rectangle, ProfilePhotoUploader
  
  def display_name
    self.profile_name.presence || self.email
  end
  
end

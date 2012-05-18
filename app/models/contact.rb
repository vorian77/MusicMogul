class Contact < ActiveRecord::Base
  attr_accessible :email, :message, :name, :subject, :copy_sender

  validates_presence_of :email, :message, :name, :subject

  def copy_sender?
    copy_sender.present?
  end

end

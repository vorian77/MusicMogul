class Email < ActiveRecord::Base
  attr_accessible :name, :subject, :body

  validates :name, presence: true, uniqueness: true
  validates :subject, presence: true
  validates :body, presence: true
end

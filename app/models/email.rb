class Email < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :subject, presence: true
  validates :body, presence: true
end

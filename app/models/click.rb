class Click < ActiveRecord::Base
  attr_accessible :entry_id, :object

  belongs_to :user
  belongs_to :entry

  validates :user, presence: true
  validates :entry, presence: true
  validates :object, presence: true
end

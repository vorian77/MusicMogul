class Contract < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  validates :user, presence: true
  validates :entry, presence: true
  validates :entry_id, uniqueness: { scope: :user_id }

  attr_accessible :entry_id
end

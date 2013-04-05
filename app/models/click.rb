class Click < ActiveRecord::Base
  attr_accessible :entry_id, :object

  belongs_to :user
  belongs_to :entry

  OBJECTS = %w(Entry Facebook Twitter Youtube Pinterest Website Track Video)

  validates :user, presence: true
  validates :entry, presence: true
  validates :object, presence: true, inclusion: { in: OBJECTS }
end

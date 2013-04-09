class Click < ActiveRecord::Base
  attr_accessible :entry_id, :object

  belongs_to :user
  belongs_to :entry

  OBJECTS = %w(Entry Facebook Twitter Youtube Pinterest Website Track Video)

  validates :user, presence: true
  validates :entry, presence: true
  validates :object, presence: true, inclusion: { in: OBJECTS }
  validates :user_id, uniqueness: { scope: [:entry_id, :object] }

  OBJECTS.each do |object|
    scope object.downcase.to_sym, where(object: object)
  end
end

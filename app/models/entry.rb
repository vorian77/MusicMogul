class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  # attr_accessible :title, :body
end

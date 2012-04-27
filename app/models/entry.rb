class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  attr_accessible :active, :artist_type, :genre, :community_name, :audition_type,
    :song_title, :written_by, :gift_name, :gift_description, :gift_value,
    :kickstarter, :pledgemusic
  
  ARTIST_TYPES = %w{Group Singer}
  ENTRY_TYPES = %w{Original Cover}

  validates_presence_of :artist_type, :genre, :community_name, :audition_type, :song_title, :written_by

end

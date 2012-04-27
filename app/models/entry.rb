class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  attr_accessible :active, :artist_type, :genre, :community_name, :audition_type,
    :song_title, :written_by
  
  ARTIST_TYPES = %w{Group Singer}

  validates_presence_of :artist_type, :genre, :community_name, :audition_type, :song_title, :written_by

end

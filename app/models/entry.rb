class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  attr_accessible :active, :artist_type, :genres_array, :community_name, :audition_type,
    :song_title, :written_by, :gift_name, :gift_description, :gift_value,
    :kickstarter, :pledgemusic
  
  ARTIST_TYPES = %w{Group Singer}
  ENTRY_TYPES = %w{Original Cover}

  validates_presence_of :artist_type, :genres, :community_name, :audition_type, :song_title, :written_by

  def genres_array=(g)
    self.genres = g.join(', ')
  end

  def genres_array
    self.genres.to_s.split(/,\s?/)
  end

end

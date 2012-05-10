class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  attr_accessor :remove_performance_video

  attr_accessible :active, :artist_type, :genres_array, :community_name, :audition_type,
    :song_title, :written_by, :gift_name, :gift_description, :gift_value,
    :kickstarter, :pledgemusic, :remove_performance_video, :youtube_url
  
  ARTIST_TYPES = %w{Group Singer}
  ENTRY_TYPES = %w{Original Cover}

  with_options :if => :active? do |u|
    u.validates_presence_of :artist_type
    u.validates_presence_of :genres_array
    u.validates_presence_of :audition_type
    u.validates_presence_of :song_title
    u.validates_presence_of :written_by
  end

  def genres_array=(g)
    self.genres = g.join(', ')
  end

  def genres_array
    self.genres.to_s.split(/,\s?/)
  end

  def performance_video?
    self.performance_video.present?
  end

  def remove_performance_video=(remove)
    self.performance_video = nil
  end


end

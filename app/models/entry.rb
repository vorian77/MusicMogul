class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  
  attr_accessor :remove_performance_video

  attr_accessible :active, :artist_type, :genre, :community_name, :audition_type,
    :song_title, :written_by, :gift_name, :gift_description, :gift_value,
    :kickstarter, :pledgemusic, :remove_performance_video, :youtube_url, :source
  
  ARTIST_TYPES = %w{Group Singer}
  ENTRY_TYPES = %w{Original Cover}

  with_options :if => :active? do |u|
    u.validates_presence_of :artist_type
    u.validates_presence_of :genre
    u.validates_presence_of :audition_type
    u.validates_presence_of :song_title
  end

  def performance_video?
    self.performance_video.present?
  end

  def remove_performance_video=(remove)
    self.performance_video = nil
    self.youtube_url = nil
    self.save(:validate => false)
  end

  def performance_video_status
    if performance_video?
      'uploaded-file'
    elsif youtube_url?
      'youtube-url'
    else
      'no-file'
    end
  end

end

class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  has_many :judgings, dependent: :destroy

  validates :points, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  attr_accessor :remove_performance_video

  attr_accessible :active, :artist_type, :genre, :community_name, :audition_type,
                  :song_title, :written_by, :gift_name, :gift_description, :gift_value,
                  :kickstarter, :pledgemusic, :remove_performance_video, :youtube_url, :source,
                  :hometown, :bio, :facebook, :youtube, :twitter, :pinterest, :website

  ARTIST_TYPES = %w{Group Singer}
  ENTRY_TYPES = %w{Original Cover}

  mount_uploader :profile_photo, ProfilePhotoUploader

  scope :unevaluated_by, lambda { |user|
    joins("LEFT OUTER JOIN judgings on entries.id = judgings.entry_id AND judgings.user_id = #{user.id}").
        where("judgings.entry_id IS NULL", user.id)
  }

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

  def overall_music_score
    judgings.sum(:music_score) / judgings.count.to_f
  end

  def overall_vocals_score
    judgings.sum(:vocals_score) / judgings.count.to_f
  end

  def overall_presentation_score
    judgings.sum(:presentation_score) / judgings.count.to_f
  end

  def rank
    self.class.uniq.order("points desc").pluck(:points).index(self.points) + 1
  end

  def source
    if audition_type == 'Cover'
      'Youtube'
    elsif performance_video?
      'Upload'
    elsif youtube_url?
      'Youtube'
    end
  end

  def youtube_id
    return unless youtube_url?
    youtube_url.scan(/[\?|&]v=(.*)/).flatten.first
  end
end

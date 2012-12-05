class Entry < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :follows, dependent: :destroy

  validates :user, presence: true
  validates :community_name, presence: true
  validates :genre, presence: true, inclusion: { in: Contest::GENRES }
  validates :hometown, presence: true
  validates :song_title, presence: true
  validates :youtube_url, presence: true
  validates :points, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validate :ensure_youtube_url_is_valid

  attr_accessible :genre, :community_name, :song_title, :youtube_url, :hometown, :bio,
                  :facebook, :youtube, :twitter, :pinterest, :website,
                  :has_music, :has_vocals, :has_explicit_content, :user

  mount_uploader :profile_photo, ProfilePhotoUploader

  scope :unexplicit, where(has_explicit_content: false)
  scope :unevaluated_by, lambda { |user|
    joins("LEFT OUTER JOIN evaluations on entries.id = evaluations.entry_id AND evaluations.user_id = #{user.id}").
        where("evaluations.entry_id IS NULL", user.id)
  }

  def component_count
    (has_music? ? 1 : 0) + (has_vocals? ? 1 : 0) + 1
  end

  def overall_score
    evaluations.sum(:overall_score) / evaluations.count.to_f
  end

  def overall_music_score
    evaluations.sum(:music_score) / evaluations.count.to_f
  end

  def overall_vocals_score
    evaluations.sum(:vocals_score) / evaluations.count.to_f
  end

  def overall_presentation_score
    evaluations.sum(:presentation_score) / evaluations.count.to_f
  end

  def rank
    self.class.uniq.order("points desc").pluck(:points).index(self.points) + 1
  end

  def youtube_id
    return unless youtube_url?
    if youtube_url =~ /youtu\.be\/([^&|?]+)/
      youtube_url.scan(/youtu\.be\/([^&|?]+)/).flatten.first
    elsif youtube_url =~ /youtube\.com\/v\/([^&|?]+)/
      youtube_url.scan(/youtube\.com\/v\/([^&|?]+)/).flatten.first
    else
      youtube_url.scan(/[\?|&]v=([^&]+)/).flatten.first
    end
  end

  private

  def ensure_youtube_url_is_valid
    return unless youtube_url?
    errors.add(:youtube_url, "is not valid") unless youtube_id.present?
  end
end

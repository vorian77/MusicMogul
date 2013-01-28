class Entry < ActiveRecord::Base
  GENRES = ['Alternative', 'Country', 'Electronic', 'Gospel', 'Hip Hop', 'Pop', 'R&B', 'Rock', 'Other']

  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user
  has_many :contracts, dependent: :destroy
  has_many :signers, through: :contracts, source: :user

  validates :user, presence: true
  validates :stage_name, presence: {on: :update}
  validates :genre, presence: {on: :update}, inclusion: {in: Entry::GENRES, on: :update}
  validates :hometown, presence: {on: :update}
  validates :profile_photo, presence: {on: :update}
  validates :title, presence: {on: :update}
  validates :youtube_url, presence: {on: :update, message: "YouTube URL is required"}
  validates :points, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :facebook, format: {with: /^#{Entry.columns_hash["facebook"].default}/}
  validates :twitter, format: {with: /^#{Entry.columns_hash["twitter"].default}/}
  validates :youtube, format: {with: /^#{Entry.columns_hash["youtube"].default}/}
  validates :pinterest, format: {with: /^#{Entry.columns_hash["pinterest"].default}/}
  validates :website, format: {with: URI::regexp(%w(http https))}
  validate :ensure_youtube_url_is_valid

  attr_accessible :genre, :stage_name, :title, :youtube_url, :hometown, :bio,
                  :facebook, :youtube, :twitter, :pinterest, :website,
                  :has_music, :has_vocals, :has_explicit_content, :user, :profile_photo

  mount_uploader :profile_photo, ProfilePhotoUploader

  before_save :cache_masonry_width_and_height

  scope :finished, where("stage_name <> '' and genre <> '' and hometown <> '' and profile_photo <> '' and title <> '' and youtube_url <> ''")
  scope :unexplicit, where(has_explicit_content: false)
  scope :unevaluated_by, lambda { |user|
    joins("LEFT OUTER JOIN evaluations on entries.id = evaluations.entry_id AND evaluations.user_id = #{user.id}").
        where("evaluations.entry_id IS NULL", user.id)
  }

  def component_count
    (has_music? ? 1 : 0) + (has_vocals? ? 1 : 0) + 1
  end

  def finished?
    [:user_id, :stage_name, :genre, :hometown, :profile_photo, :title, :youtube_url].all? do |attribute|
      send("#{attribute}?")
    end
  end

  def overall_score
    evaluations.count > 0 ? evaluations.sum(:overall_score) / evaluations.count.to_f : 0
  end

  def overall_music_score
    evaluations.count > 0 ? evaluations.sum(:music_score) / evaluations.count.to_f : 0
  end

  def overall_vocals_score
    evaluations.count > 0 ? evaluations.sum(:vocals_score) / evaluations.count.to_f : 0
  end

  def overall_presentation_score
    evaluations.count > 0 ? evaluations.sum(:presentation_score) / evaluations.count.to_f : 0
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

  def cache_masonry_width_and_height
    if profile_photo_changed?
      self.masonry_width = profile_photo.masonry.width
      self.masonry_height = profile_photo.masonry.height
    end
  end

  def ensure_youtube_url_is_valid
    return unless youtube_url?
    errors.add(:youtube_url, "is not a valid YouTube URL") unless youtube_id.present?
  end
end

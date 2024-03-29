class Entry < ActiveRecord::Base
  GENRES = ['Alternative', 'Country', 'Electronic', 'Gospel', 'Hip Hop', 'Pop', 'R&B', 'Rock', 'Other']
  FROZEN_FIELDS = [:title, :youtube_url, :has_music, :has_vocals, :has_explicit_content]

  belongs_to :contest
  belongs_to :user
  has_many :clicks, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :shared_email_users, through: :evaluations, source: :user, conditions: ["evaluations.share_email = ?", true]
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user
  has_many :contracts, dependent: :destroy
  has_many :signers, through: :contracts, source: :user

  validates :user, presence: true
  validates :stage_name, presence: {on: :update}
  validates :genre, presence: {on: :update}, inclusion: {in: Entry::GENRES, on: :update}
  validates :hometown, presence: {on: :update}
  validates :profile_photo, presence: {on: :update, message: "Album cover photo is required"}
  validates :title, presence: {on: :update}
  validates :youtube_url, presence: {on: :update, message: "YouTube URL is required"}
  validates :points, numericality: {greater_than_or_equal_to: 0}
  validates :facebook, format: {with: /^#{Entry.columns_hash["facebook"].default}/}
  validates :twitter, format: {with: /^#{Entry.columns_hash["twitter"].default}/}
  validates :youtube, format: {with: /^#{Entry.columns_hash["youtube"].default}/}
  validates :pinterest, format: {with: /^#{Entry.columns_hash["pinterest"].default}/}
  validates :website, format: {with: URI::regexp(%w(http https))}
  validate :ensure_youtube_url_is_valid
  validate :ensure_unstarted_contest, on: :update

  attr_accessible :genre, :stage_name, :title, :youtube_url, :hometown, :bio,
                  :facebook, :youtube, :twitter, :pinterest, :website,
                  :has_music, :has_vocals, :has_explicit_content, :user, :profile_photo, :free_download_link, :finishing

  attr_accessor :finishing
  mount_uploader :profile_photo, ProfilePhotoUploader

  after_save :cache_user_points, if: :points_changed?
  after_destroy :cache_user_points
  before_create :set_contest
  before_save :cache_masonry_width_and_height

  scope :with_contest, where("contest_id is not null")
  scope :finished, where("stage_name <> '' and genre <> '' and hometown <> '' and profile_photo <> '' and title <> '' and youtube_url <> ''")
  scope :unexplicit, where(has_explicit_content: false)
  scope :unevaluated_by, lambda { |user|
    joins("LEFT OUTER JOIN evaluations on entries.id = evaluations.entry_id AND evaluations.user_id = #{user.id}").
        where("evaluations.entry_id IS NULL", user.id)
  }

  def cache_points!
    update_attribute(:points, evaluations.sum(:overall_score))
  end

  def component_count
    (has_music? ? 1 : 0) + (has_vocals? ? 1 : 0) + 1
  end

  def contest_started?
    contest.present? && contest.started?
  end

  def finished?
    [:user_id, :stage_name, :genre, :hometown, :profile_photo, :title, :youtube_url].all? do |attribute|
      send("#{attribute}?")
    end
  end

  def open_for_judging?
    contest.present? && contest.running?
  end
  alias_method :open_for_signing?, :open_for_judging?

  def overall_score(user_ids = nil)
    selected_evaluations = user_ids.present? ? evaluations.where("user_id in (?)", user_ids) : evaluations
    selected_evaluations.count > 0 ? selected_evaluations.sum(:overall_score) / selected_evaluations.count.to_f : 0
  end

  def overall_music_score(user_ids = nil)
    selected_evaluations = user_ids.present? ? evaluations.where("user_id in (?)", user_ids) : evaluations
    selected_evaluations.count > 0 ? selected_evaluations.sum(:music_score) / selected_evaluations.count.to_f : 0
  end

  def overall_vocals_score(user_ids = nil)
    selected_evaluations = user_ids.present? ? evaluations.where("user_id in (?)", user_ids) : evaluations
    selected_evaluations.count > 0 ? selected_evaluations.sum(:vocals_score) / selected_evaluations.count.to_f : 0
  end

  def overall_presentation_score(user_ids = nil)
    selected_evaluations = user_ids.present? ? evaluations.where("user_id in (?)", user_ids) : evaluations
    selected_evaluations.count > 0 ? selected_evaluations.sum(:presentation_score) / selected_evaluations.count.to_f : 0
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

  def cache_user_points
    self.user.cache_points!
  end

  def ensure_unstarted_contest
    if contest_started? && !finishing
      FROZEN_FIELDS.each do |attr|
        if send("#{attr}_changed?")
          errors.add(attr, "cannot change after judging begins")
        end
      end
    end
  end

  def ensure_youtube_url_is_valid
    return unless youtube_url?
    errors.add(:youtube_url, "is not a valid YouTube URL") unless youtube_id.present?
  end

  def set_contest
    unless contest.present?
      self.contest = Contest.open.order("start_date").first
    end
  end
end

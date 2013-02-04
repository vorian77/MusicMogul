class Contract < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  validates :user, presence: true
  validates :entry, presence: true
  validates :entry_id, uniqueness: { scope: :user_id }
  validate :ensure_user_has_contracts_remaining

  attr_accessible :entry_id

  after_save :cache_user_points
  after_destroy :cache_user_points

  private

  def cache_user_points
    self.user.cache_points! if user.present?
  end

  def ensure_user_has_contracts_remaining
    return unless user.present?
    errors.add(:base, "over contract limit") if user.contracts.count >= User::CONTRACT_LIMIT
  end
end

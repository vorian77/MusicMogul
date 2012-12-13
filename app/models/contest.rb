class Contest < ActiveRecord::Base
  has_many :entries, dependent: :nullify

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  class << self
    def active
      where("start_date <= :now and end_date >= :now", now: Time.now).first
    end

    def next
      where("start_date >= ?", Time.now).order("start_date").first
    end
  end
end
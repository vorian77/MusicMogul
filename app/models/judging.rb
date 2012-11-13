class Judging < ActiveRecord::Base
  belongs_to :contest
  belongs_to :entry
  belongs_to :user

  attr_accessible :active, :genres_array

  def genres_array=(g)
    self.genres = g.join(', ')
  end

  def genres_array
    self.genres.to_s.split(/,\s?/)
  end

end

class Contest < ActiveRecord::Base
  attr_accessible :date, :name

  GENRES = ['Country','Electronic','Hip Hop','Pop','R&B','Rock']

end

FactoryGirl.define do
  factory :contest do
    start_date { Date.today + 1.day }
    artist_sign_up_end_date { Date.today + 4.days }
    end_date { Date.today + 8.days }
  end
end
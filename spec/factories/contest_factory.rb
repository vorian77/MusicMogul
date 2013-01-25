FactoryGirl.define do
  factory :contest do
    start_date { Date.today + 1.day }
    end_date { Date.today + 8.days }
  end
end
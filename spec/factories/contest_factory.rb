FactoryGirl.define do
  factory :contest do
    name { "My New Contest" }
    start_date { Date.today + 1.day }
    end_date { Date.today + 8.days }
  end
end
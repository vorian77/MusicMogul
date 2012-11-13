FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
  end

  factory :confirmed_user, parent: :user do
    confirmed_at { Date.yesterday }
  end
end
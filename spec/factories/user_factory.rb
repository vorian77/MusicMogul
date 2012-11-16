FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    profile_name { Faker::Internet.user_name }
    hometown { Faker::Address.city }
  end

  factory :confirmed_user, parent: :user do
    confirmed_at { Date.yesterday }
  end
end
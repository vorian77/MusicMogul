FactoryGirl.define do
  factory :entry do
    community_name { Faker::HipsterIpsum.words.join(" ").titleize }
    genre { Contest::GENRES.sample }
    hometown { Faker::Address.city }
    bio { Faker::HipsterIpsum.paragraph }
  end
end
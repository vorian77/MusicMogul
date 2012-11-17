FactoryGirl.define do
  factory :entry do
    user
    community_name { Faker::HipsterIpsum.words.join(" ").titleize }
    song_title { Faker::HipsterIpsum.words.join(" ").titleize }
    youtube_url { "http://youtu.be/sGE4HMvDe-Q" }
    genre { Contest::GENRES.sample }
    hometown { Faker::Address.city }
    bio { Faker::HipsterIpsum.paragraph }
  end
end
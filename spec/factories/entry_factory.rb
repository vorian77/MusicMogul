FactoryGirl.define do
  factory :entry do
    user
    stage_name { Faker::HipsterIpsum.words.join(" ").titleize }
    title { Faker::HipsterIpsum.words.join(" ").titleize }
    youtube_url { "http://youtu.be/sGE4HMvDe-Q" }
    genre { Entry::GENRES.sample }
    hometown { Faker::Address.city }
    bio { Faker::HipsterIpsum.paragraph }
    profile_photo { File.open("public/images/aretha.jpg") }
  end
end
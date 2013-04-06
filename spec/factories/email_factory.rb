# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    name { Faker::HipsterIpsum.words.join(" ").titleize }
    subject { Faker::HipsterIpsum.words.join(" ").titleize }
    body { Faker::HipsterIpsum.paragraph }
  end
end

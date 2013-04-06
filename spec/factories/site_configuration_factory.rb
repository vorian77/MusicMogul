# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_configuration do
    fan_welcome_email { FactoryGirl.build(:email) }
    musician_welcome_email { FactoryGirl.build(:email) }
  end
end

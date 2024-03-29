FactoryGirl.define do
  factory :evaluation do
    user { FactoryGirl.build(:user, inviter: FactoryGirl.build(:user)) }
    entry
    music_score { (1..10).to_a.sample }
    vocals_score { (1..10).to_a.sample }
    presentation_score { (1..10).to_a.sample }
  end
end
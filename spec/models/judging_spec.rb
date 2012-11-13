require "spec_helper"

describe Judging do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :entry }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of :entry }
    it { should validate_presence_of :user }

    it { should validate_numericality_of(:music_score).only_integer }
    it { should validate_numericality_of(:vocals_score).only_integer }
    it { should validate_numericality_of(:presentation_score).only_integer }
    it { should validate_numericality_of(:overall_score).only_integer }
  end

  describe "callbacks" do
    describe "before_validation" do
      it "should set overall score" do
        judging = FactoryGirl.build(:judging)
        judging.overall_score.should be_nil
        judging.save
        judging.overall_score.should be_present
      end
    end

    describe "after_save" do
      it "should update the entry's points" do
        entry = FactoryGirl.create(:entry)
        lambda {
          FactoryGirl.create(:judging, entry: entry)
        }.should change { entry.points }.from(0)
      end
    end
  end
end
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
    it { should validate_numericality_of(:overall_score) }

    it { should have_valid(:music_score).when(nil) }
    it { should have_valid(:music_score).when("") }
  end

  describe "callbacks" do
    describe "before_validation" do
      it "should set overall score when all components are present" do
        judging = FactoryGirl.build(:judging)
        judging.overall_score.should be_nil
        judging.save
        judging.overall_score.should be_present
      end

      it "should set overall score when a component is nil" do
        judging = FactoryGirl.build(:judging, vocals_score: nil)
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
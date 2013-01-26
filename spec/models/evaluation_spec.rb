require "spec_helper"

describe Evaluation do
  describe "associations" do
    it { should belong_to :entry }
    it { should belong_to :user }
  end

  describe "validations" do
    it { should validate_presence_of(:entry).with_message("Entry is required") }
    it { should validate_presence_of(:user).with_message("User is required") }

    it { should validate_numericality_of(:music_score) }
    it { should validate_numericality_of(:vocals_score) }
    it { should validate_numericality_of(:presentation_score) }
    it { should validate_numericality_of(:overall_score) }

    it { should have_valid(:music_score).when(nil) }
    it { should have_valid(:music_score).when("") }
  end

  describe "callbacks" do
    describe "before_validation" do
      it "should set overall score when all components are present" do
        evaluation = FactoryGirl.build(:evaluation)
        evaluation.overall_score.should be_nil
        evaluation.save
        evaluation.overall_score.should be_present
      end

      it "should set overall score when a component is nil" do
        evaluation = FactoryGirl.build(:evaluation, vocals_score: nil)
        evaluation.overall_score.should be_nil
        evaluation.save
        evaluation.overall_score.should be_present
      end
    end

    describe "after_save" do
      it "should update the entry's points" do
        entry = FactoryGirl.create(:entry)
        lambda {
          FactoryGirl.create(:evaluation, entry: entry)
        }.should change { entry.points }.from(0)
      end
    end
  end
end
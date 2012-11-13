require "spec_helper"

describe Entry do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :user }
    it { should have_many(:judgings).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_numericality_of(:points).only_integer }
  end

  describe "scopes" do
    describe ".unevaluated_by" do
      subject { Entry.unevaluated_by(user) }
      let(:user) { FactoryGirl.create(:user) }

      context "when there are no evaluations" do
        before { Judging.destroy_all }
        it { should =~ Entry.all }
      end

      context "when there is an evaluation for the given user" do
        let!(:judging) { FactoryGirl.create(:judging, user: user) }
        it { should_not == Entry.all }
        it { should_not include judging.entry }
      end

      context "when there is an evaluation for a different user" do
        before { FactoryGirl.create(:judging) }
        it { should =~ Entry.all }
      end
    end
  end
end
require "spec_helper"

describe User do
  describe "associations" do
    it { should have_many(:entries).dependent(:destroy) }
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:judgings).dependent(:destroy) }
    it { should have_many(:followed_entries).through(:follows) }
  end

  describe "validations" do
    it { should validate_presence_of :hometown }
    it { should validate_presence_of :profile_name }

    describe "birth date" do
      context "when it is nil" do
        it "should be valid" do
          FactoryGirl.build(:user, birth_date: nil).should be_valid
        end
      end

      context "when it is present" do
        context "and at least 13 years ago"
        it "should be valid" do
          FactoryGirl.build(:user, birth_date: 13.years.ago).should be_valid
        end

        context "and less than the 13 years ago" do
          it "should be valid" do
            FactoryGirl.build(:user, birth_date: 12.years.ago).should_not be_valid
          end
        end
      end
    end
  end

  describe "#average_judging_score" do
    subject { user.average_judging_score }
    let(:user) { User.first }

    context "when the user has no judgings" do
      before { user.judgings.destroy_all }
      it { should == 0 }
    end
  end

  describe "#has_evaluated?" do
    subject { user.has_evaluated?(entry) }
    let(:user) { User.first }
    let(:entry) { Entry.first }

    context "when the user has evaluated the entry" do
      before { FactoryGirl.create(:judging, user: user, entry: entry) }
      it { should be_true }
    end

    context "when the user has not evaluated the entry" do
      before { Judging.destroy_all }
      it { should be_false }
    end
  end
end
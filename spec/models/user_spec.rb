require "spec_helper"

describe User do
  describe "associations" do
    it { should belong_to(:inviter).class_name("User") }
    it { should have_many(:entries).dependent(:destroy) }
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:evaluations).dependent(:destroy) }
    it { should have_many(:followed_entries).through(:follows) }
    it { should have_many(:invited_users).class_name("User") }
  end

  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
  end

  describe "before_validation" do
    it "should set referral token" do
      user = FactoryGirl.build(:user, referral_token: nil)
      lambda {
        user.save
      }.should change { user.referral_token }.from(nil)
    end
  end

  describe "#average_evaluation_score" do
    subject { user.average_evaluation_score }
    let(:user) { User.first }

    context "when the user has no evaluations" do
      before { user.evaluations.destroy_all }
      it { should == 0 }
    end
  end

  describe "#has_evaluated?" do
    subject { user.has_evaluated?(entry) }
    let(:user) { User.invited.first }
    let(:entry) { Entry.first }

    context "when the user has evaluated the entry" do
      before { FactoryGirl.create(:evaluation, user: user, entry: entry) }
      it { should be_true }
    end

    context "when the user has not evaluated the entry" do
      before { Evaluation.destroy_all }
      it { should be_false }
    end
  end

  describe "#referral_link" do
    subject { user.referral_link }
    let(:user) { User.first }
    it { should == "http://localhost/?referral_token=#{user.referral_token}"}
  end
end
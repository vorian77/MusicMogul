require "spec_helper"

describe User do
  describe "associations" do
    it { should belong_to(:inviter).class_name("User") }
    it { should belong_to(:campaign_link) }
    it { should have_many(:contracts).dependent(:destroy) }
    it { should have_many(:entries).dependent(:destroy) }
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:evaluations).dependent(:destroy) }
    it { should have_many(:followed_entries).through(:follows) }
    it { should have_many(:signed_entries).through(:contracts) }
    it { should have_many(:invited_users).class_name("User") }
  end

  describe "validations" do
    it { should validate_presence_of(:username).with_message("Username is required") }
    it { should validate_uniqueness_of(:username).with_message("Username has already been registered") }
  end

  describe "before_validation" do
    it "should set referral token" do
      user = FactoryGirl.build(:user, referral_token: nil)
      lambda {
        user.save
      }.should change { user.referral_token }.from(nil)
    end
  end

  describe "after_create" do
    context "when the user is a fan" do
      it "should not create an entry" do
        lambda {
          FactoryGirl.create(:user, musician: false)
        }.should_not change { Entry.count }
      end
    end

    context "when the user is a musician" do
      it "should create an entry" do
        lambda {
          FactoryGirl.create(:user, musician: true)
        }.should change { Entry.count }.by(1)
      end
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

  describe "#late_adopter?" do
    subject { user.late_adopter? }

    context "when they are uninvited" do
      let(:user) { FactoryGirl.create(:user, inviter: nil) }
      it { should be_false }
    end

    context "when they adopted early" do
      let(:inviter) { FactoryGirl.create(:user) }
      let(:user) { FactoryGirl.create(:user, inviter: inviter) }
      before do
        (inviter.invitation_limit - 1).times { FactoryGirl.create(:user, inviter: inviter) }
      end
      it { should be_false }
    end

    context "when they adopted late" do
      let(:inviter) { FactoryGirl.create(:user) }
      let(:user) { FactoryGirl.create(:user, inviter: inviter) }
      before do
        (inviter.invitation_limit).times { FactoryGirl.create(:user, inviter: inviter) }
      end
      it { should be_true }
    end
  end

  describe "#referral_link" do
    subject { user.referral_link }
    let(:user) { User.first }
    it { should == "http://localhost/?referral_token=#{user.referral_token}"}
  end
end
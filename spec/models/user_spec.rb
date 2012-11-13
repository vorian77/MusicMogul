require "spec_helper"

describe User do
  describe "associations" do
    it { should have_many :entries }
    it { should have_many(:judgings).dependent(:destroy) }
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
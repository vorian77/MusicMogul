require "spec_helper"

describe Entry do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :user }
    it { should have_many(:judgings).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_numericality_of(:points).only_integer }
    it { should have_valid(:youtube_url).when("http://youtu.be/sGE4HMvDe-Q") }
    it { should have_valid(:youtube_url).when("http://www.youtube.com/watch?v=sGE4HMvDe-Q&feature=relmfu") }
    it { should have_valid(:youtube_url).when("http://www.youtube.com/v/sGE4HMvDe-Q?version=3&autohide=1") }
    it { should_not have_valid(:youtube_url).when("http://youtu.be/") }
    it { should_not have_valid(:youtube_url).when("http://www.bootynonstop.com") }
    it { should_not have_valid(:youtube_url).when("http://www.youtube.com/watch?feature=relmfu") }
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

  describe "#youtube_id" do
    subject { entry.youtube_id }
    let(:entry) { FactoryGirl.build(:entry, youtube_url: youtube_url) }

    context "when the url is http://youtu.be/sGE4HMvDe-Q" do
      let(:youtube_url) { "http://youtu.be/sGE4HMvDe-Q" }
      it { should == "sGE4HMvDe-Q" }
    end

    context "when the url is http://www.youtube.com/watch?v=sGE4HMvDe-Q&feature=relmfu" do
      let(:youtube_url) { "http://www.youtube.com/watch?v=sGE4HMvDe-Q&feature=relmfu" }
      it { should == "sGE4HMvDe-Q" }
    end

    context "when the url is http://www.youtube.com/watch?feature=relmfu&v=sGE4HMvDe-Q" do
      let(:youtube_url) { "http://www.youtube.com/watch?feature=relmfu&v=sGE4HMvDe-Q" }
      it { should == "sGE4HMvDe-Q" }
    end

    context "when the url is http://www.youtube.com/v/sGE4HMvDe-Q?version=3&autohide=1" do
      let(:youtube_url) { "http://www.youtube.com/v/sGE4HMvDe-Q?version=3&autohide=1" }
      it { should == "sGE4HMvDe-Q" }
    end
  end
end
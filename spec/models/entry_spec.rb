require "spec_helper"

describe Entry do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :user }
    it { should have_many(:evaluations).dependent(:destroy) }
    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:users).through(:follows) }
  end

  describe "validations" do
    it { should validate_presence_of(:user).with_message("User is required") }
    #it { should validate_presence_of(:stage_name).with_message("Stage name is required") }
    #it { should validate_presence_of(:title).with_message("Title is required") }
    #it { should validate_presence_of(:youtube_url).with_message("YouTube URL is required") }
    #it { should validate_presence_of(:genre).with_message("Genre is required") }
    #it { should validate_presence_of(:hometown).with_message("Hometown is required") }
    #it { should validate_presence_of(:profile_photo).with_message("Profile photo is required") }
    it { should validate_numericality_of(:points).only_integer }
    #it { should ensure_inclusion_of(:genre).in_array(Entry::GENRES) }
    it { should have_valid(:youtube_url).when("http://youtu.be/sGE4HMvDe-Q") }
    it { should have_valid(:youtube_url).when("http://www.youtube.com/watch?v=sGE4HMvDe-Q&feature=relmfu") }
    it { should have_valid(:youtube_url).when("http://www.youtube.com/v/sGE4HMvDe-Q?version=3&autohide=1") }
    it { should_not have_valid(:youtube_url).when("http://youtu.be/") }
    it { should_not have_valid(:youtube_url).when("http://www.bootynonstop.com") }
    it { should_not have_valid(:youtube_url).when("http://www.youtube.com/watch?feature=relmfu") }
    it { should have_valid(:facebook).when("http://www.facebook.com/") }
    it { should have_valid(:facebook).when("http://www.facebook.com/zuck") }
    it { should_not have_valid(:facebook).when("http://www.acebook.com/zuck") }
  end

  describe "scopes" do
    describe ".unevaluated_by" do
      subject { Entry.unevaluated_by(user) }
      let(:user) { FactoryGirl.create(:user, inviter: FactoryGirl.build(:user)) }

      context "when there are no evaluations" do
        before { Evaluation.destroy_all }
        it { should =~ Entry.all }
      end

      context "when there is an evaluation for the given user" do
        let!(:evaluation) { FactoryGirl.create(:evaluation, user: user) }
        it { should_not == Entry.all }
        it { should_not include evaluation.entry }
      end

      context "when there is an evaluation for a different user" do
        before { FactoryGirl.create(:evaluation) }
        it { should =~ Entry.all }
      end
    end
  end

  describe "#component_count" do
    subject { entry.component_count }
    let(:entry) { FactoryGirl.build(:entry, has_music: has_music, has_vocals: has_vocals) }

    context "when both are false" do
      let(:has_music) { false }
      let(:has_vocals) { false }
      it { should == 1 }
    end

    context "when one is true" do
      let(:has_music) { true }
      let(:has_vocals) { false }
      it { should == 2 }
    end

    context "when both are true" do
      let(:has_music) { true }
      let(:has_vocals) { true }
      it { should == 3 }
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
require "spec_helper"

describe Contest do
  describe "associations" do
    it { should have_many(:entries).dependent(:nullify) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }

    describe "#start_date" do
      before do
        Contest.destroy_all
        FactoryGirl.create(:contest, start_date: Date.yesterday, end_date: Date.tomorrow)
      end

      it { should have_valid(:start_date).when(Date.tomorrow + 1.day) }
      it { should_not have_valid(:start_date).when(Date.today) }
    end

    describe "#end_date" do
      before { subject.start_date = Date.today }
      it { should have_valid(:end_date).when(Date.tomorrow) }
      it { should_not have_valid(:end_date).when(Date.yesterday) }
    end
  end

  describe ".active" do
    subject { Contest.active }
    before { Contest.destroy_all }

    context "when there are no contests" do
      it { should be_nil }
    end

    context "when there is no active contest" do
      before do
        FactoryGirl.create(:contest, start_date: 2.weeks.ago, end_date: 1.week.ago)
        FactoryGirl.create(:contest, start_date: 1.weeks.from_now, end_date: 2.weeks.from_now)
      end
      it { should be_nil }
    end

    context "when there is an active contest" do
      let!(:contest) { FactoryGirl.create(:contest, start_date: Date.yesterday, end_date: Date.tomorrow) }
      it { should == contest }
    end
  end

  describe ".next" do
    subject { Contest.next }
    before { Contest.destroy_all }

    context "when there are no contests" do
      it { should be_nil }
    end

    context "when there is no next contest" do
      before do
        FactoryGirl.create(:contest, start_date: 2.weeks.ago, end_date: 1.week.ago)
      end
      it { should be_nil }
    end

    context "when there is a next contest" do
      let!(:contest) { FactoryGirl.create(:contest, start_date: Date.tomorrow, end_date: Date.tomorrow + 7.days) }
      it { should == contest }
    end
  end
end
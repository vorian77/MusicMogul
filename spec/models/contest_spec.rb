require "spec_helper"

describe Contest do
  describe "associations" do
    it { should have_many(:entries).dependent(:nullify) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end

  describe ".active" do
    subject { Contest.active }

    context "when there are no contests" do
      before { Contest.destroy_all }
      it { should be_nil }
    end

    context "when there is no active contest" do
      before do
        Contest.destroy_all
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
end
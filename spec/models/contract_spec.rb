require 'spec_helper'

describe Contract do
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :entry }
  end

  describe "validations" do
    it { should validate_presence_of(:user).with_message("User is required") }
    it { should validate_presence_of(:entry).with_message("Entry is required") }
    it { should validate_uniqueness_of(:entry_id).scoped_to(:user_id) }

    describe "user limit" do
      let(:user) { FactoryGirl.create(:user) }

      context "when the user reaches the limit" do
        before { FactoryGirl.create_list(:contract, User::CONTRACT_LIMIT - 1, user: user) }
        it "should be valid" do
          FactoryGirl.build(:contract, user: user).should be_valid
        end
      end

      context "when the user is over the limit" do
        before { FactoryGirl.create_list(:contract, User::CONTRACT_LIMIT, user: user) }
        it "should be invalid" do
          FactoryGirl.build(:contract, user: user).should_not be_valid
        end
      end
    end
  end
end

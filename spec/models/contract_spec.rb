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
  end
end

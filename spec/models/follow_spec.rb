require 'spec_helper'

describe Follow do
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :entry }
  end

  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :entry }
    it { should validate_uniqueness_of(:entry_id).scoped_to(:user_id) }
  end
end

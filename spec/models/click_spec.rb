require 'spec_helper'

describe Click do
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :entry }
  end

  describe "validations" do
    it { should validate_presence_of(:user).with_message("User is required") }
    it { should validate_presence_of(:entry).with_message("Entry is required") }
    it { should ensure_inclusion_of(:object).in_array(Click::OBJECTS) }
  end
end

require "spec_helper"

describe Entry do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :user }
    it { should have_many(:judgings).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_numericality_of(:points).only_integer }
  end
end
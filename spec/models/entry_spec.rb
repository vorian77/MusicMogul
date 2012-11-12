require "spec_helper"

describe Entry do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :user }
  end
end
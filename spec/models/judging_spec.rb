require "spec_helper"

describe Judging do
  describe "associations" do
    it { should belong_to :contest }
    it { should belong_to :entry }
    it { should belong_to :user }
  end
end
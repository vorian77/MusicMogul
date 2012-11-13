require "spec_helper"

describe User do
  describe "associations" do
    it { should have_many :entries }
    it { should have_many(:judgings).dependent(:destroy) }
  end
end
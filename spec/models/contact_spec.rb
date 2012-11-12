require "spec_helper"

describe Contact do
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :message }
    it { should validate_presence_of :name }
    it { should validate_presence_of :subject }
  end
end
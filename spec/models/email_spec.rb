require 'spec_helper'

describe Email do
  describe "validations" do
    it { should validate_presence_of(:name).with_message("Name is required") }
    it { should validate_presence_of(:subject).with_message("Subject is required") }
    it { should validate_presence_of(:body).with_message("Body is required") }
    it { should validate_uniqueness_of :name }
  end
end

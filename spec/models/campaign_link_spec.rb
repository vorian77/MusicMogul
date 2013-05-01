require 'spec_helper'

describe CampaignLink do
  describe "validations" do
    it { should validate_presence_of(:description).with_message("Description is required") }
  end
end

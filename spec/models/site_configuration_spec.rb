require 'spec_helper'

describe SiteConfiguration do
  describe "associations" do
    it { should belong_to :fan_welcome_email }
    it { should belong_to :musician_welcome_email }
  end

  describe "validations" do
    it "should only allow one" do
      first_configuration = SiteConfiguration.first
      second_configuration = FactoryGirl.build(:site_configuration)
      second_configuration.should be_invalid
      first_configuration.should be_valid
    end
  end
end

require 'spec_helper'

describe WelcomeMailer do
  describe "#new_artist" do
    let(:user) { Entry.first.user }
    let(:email) { WelcomeMailer.new_artist(user) }

    subject { email }

    its(:to) { should == [user.email] }
    its(:from) { should == ["musicmogul-noreply@musicmogul.com"] }
    its(:subject) { should == SiteConfiguration.musician_welcome_email.subject }
    its(:body) { should include(%{Hi #{user.username}}) }
    its(:body) { should include(SiteConfiguration.musician_welcome_email.body) }
  end

  describe "#new_fan" do
    let(:user) { User.fan.first }
    let(:email) { WelcomeMailer.new_fan(user) }

    subject { email }

    its(:to) { should == [user.email] }
    its(:from) { should == ["musicmogul-noreply@musicmogul.com"] }
    its(:subject) { should == SiteConfiguration.fan_welcome_email.subject }
    its(:body) { should include(%{Hi #{user.username}}) }
    its(:body) { should include(SiteConfiguration.fan_welcome_email.body) }
  end
end
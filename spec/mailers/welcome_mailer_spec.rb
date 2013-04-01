require 'spec_helper'

describe WelcomeMailer do
  describe "#new_artist" do
    let(:user) { Entry.first.user }
    let(:email) { WelcomeMailer.new_artist(user).deliver }

    subject { email }

    its(:to) { should == [user.email] }
    its(:from) { should == ["musicmogul-noreply@musicmogul.com"] }
    its(:subject) { should == "Welcome to Music Mogul!" }
    its(:body) { should include(%{Hi #{user.username}}) }
  end

  describe "#new_fan" do
    let(:user) { User.fan.first }
    let(:email) { WelcomeMailer.new_fan(user).deliver }

    subject { email }

    its(:to) { should == [user.email] }
    its(:from) { should == ["musicmogul-noreply@musicmogul.com"] }
    its(:subject) { should == "Welcome to Music Mogul!" }
    its(:body) { should include(%{Hi #{user.username}}) }
  end
end
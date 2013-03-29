require "spec_helper"

describe ContactMailer do
  describe "#deliver_contact" do
    let(:params) { {name: name, email: from, subject: subj, message: message} }
    let(:name) { Faker::Name.name }
    let(:from) { Faker::Internet.email }
    let(:subj) { Faker::HipsterIpsum.sentence }
    let(:message) { Faker::HipsterIpsum.paragraph }

    subject { ContactMailer.contact(params).deliver }

    its(:to) { should == ["contact@MusicMogul.com"] }
    its(:cc) { should be_nil }
    its(:from) { should == [from] }
    its(:subject) { should == "Contact Us: #{subj}" }
    its(:body) { should include(name) }
    its(:body) { should include(from) }
    its(:body) { should include(subj) }
    its(:body) { should include(message) }

    context "when the user wants a copy" do
      let(:params) { {name: name, email: from, subject: subj, message: message, send_me_a_copy: "1"} }
      its(:cc) { should == [from] }
    end
  end
end

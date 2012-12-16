require "spec_helper"

feature "sign up" do
  scenario "musician signs up" do
    inviter = User.first
    visit root_path(referral_token: inviter.referral_token)

    within(".btn-holder") { click_link "Musician" }
    current_path.should == new_user_registration_path

    fill_in "Username", with: Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"

    lambda {
      click_button "Sign Up"
    }.should change { User.count }.by(1)

    user = User.order("created_at").last
    user.inviter.should == inviter
    user.should be_musician
    current_path.should == verify_email_path
    page.should have_content "Check Your Inbox For Our Verification Email"

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    user_should_be_logged_in user

    current_path.should == new_entry_path
    visit root_path
    current_path.should == new_entry_path

    within "form#new_entry" do
      fill_in "Stage name", with: Faker::HipsterIpsum.words.join(" ")
      fill_in "Hometown", with: Faker::Address.city
      select Entry::GENRES.sample, from: "entry[genre]"
      fill_in "Bio", with: Faker::HipsterIpsum.paragraph
      fill_in "YouTube URL", with: "http://youtu.be/sGE4HMvDe-Q"
      fill_in "Title", with: Faker::HipsterIpsum.words.join(" ")
      check "Has Music"
      check "Has Vocals"
      check "Has Explicit Content"
      attach_file "entry_profile_photo", "public/images/aretha.jpg"
      lambda {
        click_button "Save"
      }.should change { Entry.count }.by(1)
    end

    current_path.should == root_path
    user_should_be_logged_in user
  end

  scenario "fan signs up" do
    inviter = User.first
    visit root_path(referral_token: inviter.referral_token)

    within(".btn-holder") { click_link "Fan" }
    current_path.should == new_user_registration_path

    fill_in "Username", with: Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"

    lambda {
      click_button "Sign Up"
    }.should change { User.count }.by(1)

    user = User.order("created_at").last
    user.inviter.should == inviter
    user.should be_fan
    current_path.should == verify_email_path
    page.should have_content "Check Your Inbox For Our Verification Email"

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    current_path.should == root_path
    user_should_be_logged_in user
  end
end
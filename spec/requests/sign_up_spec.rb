require "spec_helper"

feature "sign up" do
  scenario "musician signs up" do
    inviter = User.first
    visit root_path(referral_token: inviter.referral_token)
    page.should have_content "Invited by #{inviter.username}"

    within("div.buttons") { click_link "Musician" }
    current_path.should == new_user_registration_path
    page.should have_content "Reserve your place as a contestant"

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
    page.should have_content "Reserve your place as a contestant"
    page.should have_content "Almost there! Check your inbox for our verification email."

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    current_path.should == new_entry_path
    page.should have_content "Reserve your place as a contestant"

    visit root_path
    current_path.should == new_entry_path
    page.should have_content "Reserve your place as a contestant"

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
      }.should change { user.entries.count }.by(1)
    end

    current_path.should == root_path
    user_should_be_logged_in user
  end

  scenario "fan signs up" do
    inviter = User.first
    visit root_path(referral_token: inviter.referral_token)
    page.should have_content "Invited by #{inviter.username}"

    within("div.buttons") { click_link "Fan" }
    current_path.should == new_user_registration_path
    page.should have_content "Reserve your place as a contest judge"

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
    page.should have_content "Reserve your place as a contest judge"
    page.should have_content "Almost there! Check your inbox for our verification email."

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    current_path.should == root_path
    user_should_be_logged_in user
  end
end
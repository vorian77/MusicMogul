require "spec_helper"

feature "sign up" do
  before { Contest.destroy_all }

  scenario "musician signs up" do
    inviter = User.first
    visit root_path(referral_token: inviter.referral_token)
    page.should have_content "Invited by ( #{inviter.username} )"

    within("div.sign-up-options") { click_link "Artist" }
    current_path.should == new_user_registration_path
    page.should have_content "Reserve Your Place As A Contestant"

    fill_in "Username", with: Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"
    fill_in "Confirm password", with: "password"
    check "I agree"

    lambda {
      click_button "Next"
    }.should change { User.count }.by(1)

    user = User.order("created_at").last
    user.inviter.should == inviter
    user.should be_musician
    current_path.should == verify_email_path
    page.should have_content "Reserve Your Place As A Contestant"
    page.should have_content "Check Your Inbox"
    page.should have_no_css "div.notice"

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    current_path.should == finish_entry_path
    page.should have_content "Reserve Your Place As A Contestant"

    visit root_path
    current_path.should == finish_entry_path
    page.should have_content "Reserve Your Place As A Contestant"

    within "form.edit_entry" do
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
        click_button "Sign Up"
      }.should change { user.entries.finished.count }.by(1)
    end

    current_path.should == root_path
    user_should_be_logged_in user
    page.should have_content "Increase your chance of winning the $500 first prize!"
    page.should have_content "0/25"
  end

  scenario "fan signs up" do
    inviter = User.first
    visit root_path(referral_token: inviter.referral_token)
    page.should have_content "Invited by ( #{inviter.username} )"

    within("div.sign-up-options") { click_link "Fan" }
    current_path.should == new_user_registration_path
    page.should have_content "Reserve Your Place As A Contest Judge"

    fill_in "Username", with: Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"
    fill_in "Confirm password", with: "password"
    check "I agree"

    lambda {
      click_button "Next"
    }.should change { User.count }.by(1)

    user = User.order("created_at").last
    user.inviter.should == inviter
    user.should be_fan
    current_path.should == verify_email_path
    page.should have_content "Reserve Your Place As A Contest Judge"
    page.should have_content "Check Your Inbox"
    page.should have_no_css "div.notice"

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    current_path.should == root_path
    user_should_be_logged_in user
    page.should have_content "Make the contest better!"
    page.should have_content "0/5"
  end
end
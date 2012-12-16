require "spec_helper"

feature "sign up" do
  scenario "user signs up" do
    visit root_path

    click_link "Sign Up"
    current_path.should == new_user_registration_path

    username = Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"
    fill_in "Username", with: username
    fill_in "Hometown", with: Faker::Address.city

    lambda {
      click_button "Sign Up"
    }.should change { User.count }.by(1)
    current_path.should == root_path

    page.should have_content "A message with a confirmation link has been sent to your email address."
    visit user_confirmation_path(confirmation_token: User.last.confirmation_token)

    current_path.should == root_path
    user_should_be_logged_in User.last
  end

  scenario "user signs up with referral token" do
    user = User.first
    visit root_path(referral_token: user.referral_token)

    click_link "Sign Up"
    current_path.should == new_user_registration_path

    username = Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"
    fill_in "Username", with: username
    fill_in "Hometown", with: Faker::Address.city

    lambda {
      click_button "Sign Up"
    }.should change { User.count }.by(1)
    current_path.should == root_path

    User.order("created_at").last.inviter.should == user
  end
end
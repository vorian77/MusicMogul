require "spec_helper"

feature "sign up" do
  scenario "user signs up" do
    visit root_path

    click_link "Sign up"
    current_path.should == new_user_registration_path

    player_name = Faker::Internet.user_name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "password"
    fill_in "Player name", with: player_name
    fill_in "Hometown", with: Faker::Address.city

    click_button "Sign up"
    current_path.should == root_path

    page.should have_content "A message with a confirmation link has been sent to your email address."
    visit user_confirmation_path(confirmation_token: User.last.confirmation_token)

    current_path.should == root_path
    within("div.display-name") { page.should have_content player_name }
  end
end
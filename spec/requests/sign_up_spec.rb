require "spec_helper"

feature "sign up" do
  scenario "mogul signs up" do
    visit root_path

    click_link "Sign up"
    current_path.should == new_user_registration_path

    email = Faker::Internet.email
    fill_in "Email", with: email
    fill_in "Password", with: "password"

    click_button "Sign up"
    current_path.should == root_path

    page.should have_content "A message with a confirmation link has been sent to your email address."
    visit user_confirmation_path(confirmation_token: User.last.confirmation_token)

    current_path.should == root_path
    within("div.display-name") { page.should have_content email }
  end
end
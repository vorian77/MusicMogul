require "spec_helper"

feature "log in" do
  scenario "user logs in" do
    user = users(:confirmed_user)

    visit root_path

    within "div.btn-holder" do
      click_link "Sign In"
    end

    current_path.should == new_user_session_path

    within "form#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
    end

    click_button "Log in"

    current_path.should == root_path

    page.should have_content "Signed in successfully"
    user_should_be_logged_in user
  end
end
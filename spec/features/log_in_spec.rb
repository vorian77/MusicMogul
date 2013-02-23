require "spec_helper"

feature "log in" do
  scenario "user logs in" do
    user = users(:confirmed_user)
    visit root_path
    click_link "Sign In"
    current_path.should == new_user_session_path

    within "form#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
    end

    click_button "Sign In"
    current_path.should == root_path

    page.should have_content "Signed in successfully"
    user_should_be_logged_in user
  end

  scenario "user logs in unsuccessfully" do
    user = users(:confirmed_user)
    visit root_path
    click_link "Sign In"
    current_path.should == new_user_session_path

    within "form#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password1"
    end

    click_button "Sign In"
    current_path.should == new_user_session_path
    page.should have_content "Incorrect email or password"
  end
end
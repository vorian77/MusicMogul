require "spec_helper"

feature "passwords" do
  scenario "user resets password with errors" do
    visit new_user_session_path
    click_link "Forgot password?"
    current_path.should == new_user_password_path
    fill_in "Email", with: "foobar@barbaz.com"
    click_button "Send Password Reset Instructions"
    current_path.should == user_password_path
    page.should have_content "Email not found. Try a different email."
  end
end
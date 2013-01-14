require "spec_helper"

feature "passwords" do
  scenario "user reset password" do
    user = users(:confirmed_user)
    visit new_user_session_path
    click_link "Forgot password?"
    current_path.should == new_user_password_path
    fill_in "Email", with: user.email
    click_button "Send Password Reset Instructions"
    current_path.should == password_reset_path
    page.should have_content "Check your email for a link"
  end

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
require "spec_helper"

feature "log out" do
  scenario "user logs out" do
    user = users(:confirmed_user)
    sign_in_as user
    user_should_be_logged_in user
    page.should_not have_content user.email

    click_link "Sign Out"
    current_path.should == root_path
    page.should_not have_content user.email
  end
end
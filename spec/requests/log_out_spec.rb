require "spec_helper"

feature "log out" do
  scenario "user logs out" do
    user = users(:confirmed_user)
    sign_in_as user
    within("div.display-name") { page.should have_content user.email }

    click_link "Log out"
    current_path.should == root_path
    page.should_not have_content user.email
  end
end
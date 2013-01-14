require "spec_helper"

feature "profile" do
  scenario "user updates profile" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "My Personal Profile"
    current_path.should == edit_user_path(user)

    within "form.edit_user" do
      fill_in "Username", with: Faker::Internet.user_name
      fill_in "Email", with: Faker::Internet.email
      fill_in "Hometown", with: "Detroit"
      uncheck "Show videos with explicit content"
      uncheck "Send me contest updates via email"
      fill_in "Password", with: "password1"
      fill_in "Confirm password", with: "password1"
      click_button "Save"
    end

    current_path.should == edit_user_path(user)
    visit edit_user_path(user)

    within "form.edit_user" do
      find_field("user[show_explicit_videos]").should_not be_checked
      find_field("user[receive_email_updates]").should_not be_checked
    end

    click_link "Sign Out"
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    current_path.should == root_path
    user_should_be_logged_in user.reload
  end
end
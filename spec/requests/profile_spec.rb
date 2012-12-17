require "spec_helper"

feature "profile" do
  scenario "user updates profile" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "My Account"
    current_path.should == account_path

    within "form.edit_user" do
      fill_in "Username", with: Faker::Internet.user_name
      fill_in "Email", with: Faker::Internet.email
      fill_in "Hometown", with: "Detroit"
      select "Male", from: "Gender"
      uncheck "Show videos with explicit content"
      uncheck "Send me contest updates via email"
      click_button "Save"
    end

    current_path.should == account_path
    visit account_path

    within "form.edit_user" do
      #find_field("user_gender_male").should be_checked
      find_field("user[show_explicit_videos]").should_not be_checked
      find_field("user[receive_email_updates]").should_not be_checked
    end
  end
end
require "spec_helper"

feature "profile" do
  scenario "user updates profile" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link user.profile_name
    current_path.should == account_path

    within "form.edit_user" do
      fill_in "Player name", with: Faker::Internet.user_name
      fill_in "Email", with: Faker::Internet.email
      fill_in "Hometown", with: "Detroit"
      choose "Male"
      uncheck "Show explicit videos"
      uncheck "Receive email updates"
      click_button "Save"
    end

    current_path.should == account_path
    visit account_path
    find_field("user_gender_male").should be_checked
    find_field("user[show_explicit_videos]").should_not be_checked
    find_field("user[receive_email_updates]").should_not be_checked
  end
end
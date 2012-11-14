require "spec_helper"

feature "profile" do
  scenario "user updates profile" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link user.email
    current_path.should == account_path

    fill_in "Email", with: Faker::Internet.email
    choose "Male"
    uncheck "Show explicit videos"
    uncheck "Receive email updates"
    click_button "Save"
    current_path.should == account_path

    visit account_path
    find_field("user_gender_male").should be_checked
    find_field("user[show_explicit_videos]").should_not be_checked
    find_field("user[receive_email_updates]").should_not be_checked
  end
end
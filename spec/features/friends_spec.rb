require "spec_helper"

feature "friends" do
  scenario "user views my friends" do
    user = users(:confirmed_user)
    friend = FactoryGirl.create(:user, inviter: user)
    login_as user, scope: :user

    visit root_path
    click_link "My Friends"

    current_path.should == friends_path
    page.should have_content friend.username
  end
end
require "spec_helper"

feature "follows" do
  scenario "user follows and unfollows from the list view", js: true, driver: :selenium do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit leaderboard_path

    entry = Entry.first
    within("li#entry_#{entry.id}") do
      click_button "Follow"
      within "form.follow" do
        page.should have_css "input[type=submit][value=Following]"
        page.should have_no_css "input[type=submit][value=Follow]"
      end
    end

    visit leaderboard_path

    within("li#entry_#{entry.id}") do
      within "form.follow" do
        page.should have_css "input[type=submit][value=Following]"
        page.should have_no_css "input[type=submit][value=Follow]"
      end

      click_button "Following"

      within "form.follow" do
        page.should have_css "input[type=submit][value=Follow]"
        page.should have_no_css "input[type=submit][value=Following]"
      end
    end

    visit leaderboard_path

    within("li#entry_#{entry.id}") do
      within "form.follow" do
        page.should have_css "input[type=submit][value=Follow]"
        page.should have_no_css "input[type=submit][value=Following]"
      end
    end
  end

  scenario "user views follows" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "Following"
    current_path.should == follows_path

    Entry.find_each do |entry|
      page.should have_no_content entry.community_name
    end

    entry = Entry.first
    FactoryGirl.create(:follow, user: user, entry: entry)

    visit follows_path
    page.should have_content entry.community_name
  end
end
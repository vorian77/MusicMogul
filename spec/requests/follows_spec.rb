require "spec_helper"

feature "follows" do
  scenario "user follows and unfollows from the list view", js: true, driver: :selenium do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit leaderboard_path

    entry = user.evaluations.first.entry
    within("div#entry_#{entry.id}") do
      click_link "Follow"
      page.should have_css "a", text: "Following"
    end

    visit leaderboard_path

    within("div#entry_#{entry.id}") do
      page.should have_css "a", text: "Following"
      click_link "Following"
      page.should have_css "a", text: "Follow"
    end

    visit leaderboard_path

    within("div#entry_#{entry.id}") do
      page.should have_css "a", text: "Follow"
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
require "spec_helper"

feature "leaderboard" do
  scenario "user views leaderboard" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "Leader Board"
    current_path.should == leaderboard_path

    Entry.count.should > 0
    Entry.find_each do |entry|
      within "div#entry_#{entry.id}" do
        page.should have_content entry.community_name
        within("div#rank") { page.should have_content "#{entry.rank}" }
        within("div#points") { page.should have_content "#{entry.points}" }
      end
    end
  end
end
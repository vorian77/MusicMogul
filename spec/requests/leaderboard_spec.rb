require "spec_helper"

feature "leaderboard" do
  scenario "user views leaderboard" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    FactoryGirl.create(:evaluation, entry: Entry.all.sample)

    visit root_path

    click_link "Leader Board"
    current_path.should == leaderboard_path

    Entry.count.should > 0
    User.musician.find_each do |user|
      entry = user.entries.first
      within "div#entry_#{entry.id}" do
        page.should have_content entry.stage_name if user.has_evaluated? entry
        within("strong.rank") { page.should have_content "#{user.rank}" }
        within("strong.points") { page.should have_content "#{user.cached_points}" }
      end
    end
  end
end
require "spec_helper"

feature "leaderboard" do
  scenario "user views leaderboard" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    FactoryGirl.create(:evaluation, entry: Entry.all.sample)

    visit root_path
    pending "contest start flow"

    click_link "Leader Board"
    current_path.should == leaderboard_path

    Entry.count.should > 0
    Entry.find_each do |entry|
      if entry.points > 0
        within "div#entry_#{entry.id}" do
          page.should have_content entry.stage_name if user.has_evaluated? entry
          within("span.place") { page.should have_content "#{entry.rank}" }
          within("span.points") { page.should have_content "#{entry.points}" }
        end
      else
        page.should have_no_css "div#entry_#{entry.id}"
      end
    end
  end
end
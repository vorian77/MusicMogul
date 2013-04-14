require "spec_helper"

feature "homepage" do
  scenario "guest views homepage" do
    visit root_path

    Entry.count.should > 0
    Entry.find_each do |entry|
      page.should have_content entry.stage_name
      page.should have_content entry.hometown
      page.should have_content entry.bio
    end
  end

  scenario "user views homepage" do
    user = users(:confirmed_user)

    sign_in_as user

    Entry.unevaluated_by(user).count.should > 0
    Entry.unevaluated_by(user).find_each do |entry|
      page.should have_content entry.stage_name
    end

    page.should have_no_css "form.follow"
  end

  scenario "timer shows next contest when there is no contest pending or running" do
    Contest.running.destroy_all
    Contest.pending.destroy_all
    SiteConfiguration.first.update_attribute(:next_contest_start_date, 1.week.from_now)
    visit root_path
    current_path.should == root_path
    page.should have_content "Next Contest Begins #{1.week.from_now.strftime("%m/%d/%y at %l%p %Z")}"
  end
end

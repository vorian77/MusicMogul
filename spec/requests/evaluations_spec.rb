require "spec_helper"

feature "evaluations" do
  scenario "user creates an evaluation", js: true do
    user = users(:confirmed_user)
    sign_in_as user

    entry = Entry.first
    click_link entry.community_name
    current_path.should == entry_path(entry)

    comment = Faker::HipsterIpsum.paragraph

    within "form#new_judging" do
      fill_in "Comment", with: comment
      click_button "Create Judging"
    end

    current_path.should == entry_path(entry)

    page.should have_no_css "form#new_judging"

    within("div#rank") { page.should have_content entry.reload.rank }
    within("div#points") { page.should have_content entry.reload.points }
    within("table#evaluations") do
      page.should have_content "1"
    end

    within("ul.evaluations") do
      page.should have_content user.name
      page.should have_content comment
    end
  end
end
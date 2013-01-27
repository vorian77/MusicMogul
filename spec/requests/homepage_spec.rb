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
end

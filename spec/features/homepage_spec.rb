require "spec_helper"

feature "homepage" do
  scenario "guest views homepage" do
    visit root_path
    page.should have_content "Music Mogul is the new fantasy music game"
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

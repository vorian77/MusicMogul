require "spec_helper"

feature "follows" do
  scenario "user follows and unfollows from the list view", js: true, driver: :selenium do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path

    entry = Entry.first
    within("li#entry_#{entry.id}") do
      click_button "Follow"
      within "form.follow" do
        page.should have_css "input[type=submit][value=Following]"
        page.should have_no_css "input[type=submit][value=Follow]"
      end
    end

    visit root_path

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

    visit root_path

    within("li#entry_#{entry.id}") do
      within "form.follow" do
        page.should have_css "input[type=submit][value=Follow]"
        page.should have_no_css "input[type=submit][value=Following]"
      end
    end
  end
end
require "spec_helper"

feature "homepage" do
  scenario "guest views homepage" do
    visit root_path

    Entry.count.should > 0
    within("ul.entries") do
      Entry.find_each do |entry|
        page.should have_content entry.community_name
        page.should have_content entry.genre
        page.should have_content entry.hometown
        page.should have_content entry.bio
      end
    end
  end

  scenario "user views homepage", js: true do
    user = users(:confirmed_user)

    sign_in_as user

    Entry.count.should > 0
    Entry.find_each do |entry|
      page.should have_content entry.community_name
    end
  end

  scenario "user views audition progress bar" do
    user = users(:confirmed_user)

    login_as(user, scope: :user)

    visit root_path

    within "div.audition_progress" do
      page.should have_content "Contestants 3"
      page.should have_content "# Evaluated 0"
      page.should have_content "% Evaluated 0"
    end

    FactoryGirl.create(:judging, entry: Entry.first, user: user)

    visit root_path

    within "div.audition_progress" do
      page.should have_content "Contestants 3"
      page.should have_content "# Evaluated 1"
      page.should have_content "% Evaluated 33"
    end
  end
end
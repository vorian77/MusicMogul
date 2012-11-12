require "spec_helper"

feature "homepage" do
  scenario "guest views homepage" do
    entries = FactoryGirl.create_list(:entry, 3)

    visit root_path

    within("ul.entries") do
      entries.each do |entry|
        page.should have_content entry.community_name
        page.should have_content entry.genre
        page.should have_content entry.hometown
        page.should have_content entry.bio
      end
    end
  end
end
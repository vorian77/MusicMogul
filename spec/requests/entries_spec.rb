require "spec_helper"

feature "entries" do
  scenario "user creates an entry" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "My Player Profile"
    current_path.should == account_path

    within "form#new_entry" do
      fill_in "Stage name", with: Faker::HipsterIpsum.words.join(" ")
      select Contest::GENRES.sample, from: "Genre"
      fill_in "Hometown", with: Faker::Address.city
      fill_in "Bio", with: Faker::HipsterIpsum.paragraph
      fill_in "Youtube URL", with: "http://youtu.be/sGE4HMvDe-Q"
      fill_in "Song title", with: Faker::HipsterIpsum.words.join(" ")
      check "Has music"
      check "Has vocals"
      check "Has explicit content"
      fill_in "Facebook", with: ""
      fill_in "Twitter", with: ""
      fill_in "Youtube", with: ""
      fill_in "Pinterest", with: ""
      fill_in "Website", with: ""
      click_button "Save"
    end

    current_path.should == account_path

    within "form.edit_entry" do
      click_button "Save"
    end

    current_path.should == account_path
  end
end
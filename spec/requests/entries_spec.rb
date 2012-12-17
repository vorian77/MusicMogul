require "spec_helper"

feature "entries" do
  scenario "user edits an entry" do
    user = users(:confirmed_user)
    entry = FactoryGirl.create(:entry, user: user)
    login_as user, scope: :user

    visit root_path
    click_link "My Video Submission"
    current_path.should == edit_entry_path(entry)

    new_stage_name = Faker::HipsterIpsum.words.join(" ")
    within "form.edit_entry" do
      fill_in "Stage name", with: new_stage_name
      select Entry::GENRES.sample, from: "Genre"
      fill_in "Hometown", with: Faker::Address.city
      fill_in "Bio", with: Faker::HipsterIpsum.paragraph
      fill_in "YouTube URL", with: "http://youtu.be/sGE4HMvDe-Q"
      fill_in "Title", with: Faker::HipsterIpsum.words.join(" ")
      check "Has Music"
      check "Has Vocals"
      check "Has Explicit Content"
      attach_file "entry_profile_photo", "public/images/aretha.jpg"
      click_button "Save"
    end

    current_path.should == edit_entry_path(entry)
  end
end
require "spec_helper"

feature "entries" do
  scenario "user creates an entry" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "Submit A Video"
    current_path.should == new_entry_path

    within "form#new_entry" do
      fill_in "Stage name", with: Faker::HipsterIpsum.words.join(" ")
      select Entry::GENRES.sample, from: "Genre"
      fill_in "Hometown", with: Faker::Address.city
      fill_in "Bio", with: Faker::HipsterIpsum.paragraph
      fill_in "YouTube URL", with: "http://youtu.be/sGE4HMvDe-Q"
      fill_in "Title", with: Faker::HipsterIpsum.words.join(" ")
      check "Has Music"
      check "Has Vocals"
      check "Has Explicit Content"
      attach_file "entry_profile_photo", "public/images/aretha.jpg"
      lambda {
        click_button "Save"
      }.should change { Entry.count }.by(1)
    end

    current_path.should == root_path
  end
end
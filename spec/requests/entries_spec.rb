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
      fill_in "Facebook", with: ""
      fill_in "Twitter", with: ""
      fill_in "YouTube", with: ""
      fill_in "Pinterest", with: ""
      fill_in "Website", with: ""
      lambda {
        click_button "Save"
      }.should change { Entry.count }.by(1)
    end

    entry = Entry.order("created_at").last
    current_path.should == edit_entry_path(entry)

    within "form.edit_entry" do
      click_button "Save"
    end

    current_path.should == edit_entry_path(entry)
  end
end
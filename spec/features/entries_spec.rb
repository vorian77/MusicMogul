require "spec_helper"

feature "entries" do
  scenario "user edits an entry" do
    user = FactoryGirl.create(:confirmed_user, musician: true)
    entry = user.entries.first
    entry.contest.update_attribute(:start_date, Date.tomorrow)
    entry.update_attributes(stage_name: Faker::HipsterIpsum.words.join(" "),
                            hometown: Faker::Address.city,
                            title: Faker::HipsterIpsum.words.join(" "),
                            youtube_url: "http://youtu.be/sGE4HMvDe-Q",
                            profile_photo: File.open("public/images/aretha.jpg"),
                            genre: Entry::GENRES.sample)
    login_as user, scope: :user

    visit root_path
    click_link "My Profile"
    current_path.should == edit_user_path(user)

    new_stage_name = Faker::HipsterIpsum.words.join(" ")
    within "form.edit_user" do
      fill_in "Stage name", with: new_stage_name
      select Entry::GENRES.sample, from: "Genre"
      fill_in "user_entries_attributes_0_hometown", with: Faker::Address.city
      fill_in "Bio", with: Faker::HipsterIpsum.paragraph
      fill_in "YouTube URL", with: "http://youtu.be/sGE4HMvDe-Q"
      fill_in "Title", with: Faker::HipsterIpsum.words.join(" ")
      check "Has Music"
      check "Has Vocals"
      check "Has Explicit Content"
      attach_file "user[entries_attributes][0][profile_photo]", "public/images/aretha.jpg"
      within ".social-section" do
        fill_in "Facebook", with: "http://www.facebook.com/foobar"
        fill_in "Pinterest", with: "http://www.pinterest.com/foobar"
        fill_in "Twitter", with: "http://www.twitter.com/foobar"
        fill_in "YouTube", with: "http://www.youtube.com/foobar"
        fill_in "Website", with: "http://www.foobar.com"
      end

      lambda {
        click_button "Save Profile"
      }.should change { entry.reload.stage_name }.to(new_stage_name)
    end

    current_path.should == edit_user_path(user)
  end
end
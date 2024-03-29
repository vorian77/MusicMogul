require "spec_helper"

feature "evaluations" do
  scenario "user creates an evaluation", js: true do
    user = users(:confirmed_user)
    sign_in_as user

    entry = Entry.first
    visit entry_path(entry)
    comment = Faker::HipsterIpsum.paragraph

    within "form#new_evaluation" do
      fill_in "evaluation[comment]", with: comment
      click_button "Submit"
    end

    current_path.should == entry_path(entry)

    page.should have_no_css "form#new_evaluation"
    page.should have_content comment.first(150)
  end

  scenario "fan views their evaluations" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    evaluation = FactoryGirl.create(:evaluation, user: user)

    visit root_path
    click_link "My Evaluations"
    current_path.should == evaluations_path

    within("div#evaluation_#{evaluation.id}") do
      page.should have_content evaluation.entry.stage_name
    end
  end

  scenario "contestant views their evaluations" do
    user = User.musician.first
    login_as user, scope: :user

    entry = user.entries.first
    FactoryGirl.create(:evaluation, entry: entry)

    visit root_path
    click_link "My Evaluations"
    current_path.should == evaluations_path

    entry.evaluations.each do |evaluation|
      within("div#evaluation_#{evaluation.id}") do
        page.should have_content evaluation.user.username
      end
    end
  end
end
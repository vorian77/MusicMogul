require "spec_helper"

feature "evaluations" do
  scenario "user creates an evaluation", js: true do
    user = users(:confirmed_user)
    sign_in_as user

    entry = Entry.first
    click_link entry.community_name
    current_path.should == entry_path(entry)

    comment = Faker::HipsterIpsum.paragraph

    within "form#new_evaluation" do
      fill_in "evaluation_comment", with: comment
      click_button "Submit"
    end

    current_path.should == entry_path(entry)

    page.should have_no_css "form#new_evaluation"

    within("div#rank") { page.should have_content entry.reload.rank }
    within("div#points") { page.should have_content entry.reload.points }
    within("table#evaluations") do
      page.should have_content "1"
    end

    within("ul.evaluations") do
      page.should have_content user.name
      page.should have_content comment
    end
  end

  scenario "user views their evaluations" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    evaluation = FactoryGirl.create(:evaluation, user: user)

    visit root_path
    click_link "My Evaluations"
    current_path.should == evaluations_path

    within("ul.evaluations") do
      page.should have_content evaluation.entry.community_name
    end
  end
end
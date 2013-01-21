require "spec_helper"

feature "evaluations" do
  before { pending "contest start flow" }

  scenario "user creates an evaluation", js: true do
    user = users(:confirmed_user)
    sign_in_as user

    entry = Entry.first
    click_link entry.stage_name
    current_path.should == entry_path(entry)

    comment = Faker::HipsterIpsum.paragraph

    within "form#new_evaluation" do
      fill_in "evaluation_comment", with: comment
      click_button "Submit"
    end

    current_path.should == entry_path(entry)

    page.should have_no_css "form#new_evaluation"

    within("span.number#rank") { page.should have_content entry.reload.rank }
    within("span.number#points") { page.should have_content entry.reload.points }
    within("div.stats div.right-part table") do
      page.should have_content "1"
    end

    within("div.bottom-list > ul") do
      page.should have_content user.name
      page.should have_content comment.first(150)
    end
  end

  scenario "uninvited user cannot create an evaluation" do
    user = FactoryGirl.create(:confirmed_user, inviter: nil)
    sign_in_as user

    entry = Entry.first
    click_link entry.stage_name
    current_path.should == entry_path(entry)

    page.should have_no_css "form#new_evaluation"
    page.should have_css "span.number#rank"
    page.should have_css "span.number#points"
  end

  scenario "user views their evaluations" do
    user = users(:confirmed_user)
    login_as user, scope: :user

    evaluation = FactoryGirl.create(:evaluation, user: user)

    visit root_path
    click_link "My Evaluations"
    current_path.should == evaluations_path

    within("div.box") do
      page.should have_content evaluation.entry.stage_name
    end
  end
end
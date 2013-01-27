require "spec_helper"

feature "follows" do
  scenario "user follows and unfollows from My Evaluations", js: true, driver: :selenium do
    user = users(:confirmed_user)
    login_as user, scope: :user

    visit root_path
    click_link "My Evaluations"
    current_path.should == evaluations_path

    evaluation = user.evaluations.first
    within("div#evaluation_#{evaluation.id}") do
      click_link "Follow"
      page.should have_css "a", text: "Following"
    end

    visit evaluations_path

    within("div#evaluation_#{evaluation.id}") do
      page.should have_css "a", text: "Following"
      click_link "Following"
      page.should have_css "a", text: "Follow"
    end

    visit evaluations_path

    within("div#evaluation_#{evaluation.id}") do
      page.should have_css "a", text: "Follow"
    end
  end
end
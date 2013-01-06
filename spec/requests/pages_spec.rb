require "spec_helper"

feature "pages" do
  scenario "user visits about us", js: true, driver: :selenium do
    visit root_path
    within("div.footer") { click_link "About Us" }
    page.should have_content "Our mission is to help unheralded singers and bands to advance their career in professional music."
    current_path.should == notices_path
  end

  scenario "user visits contact us", js: true, driver: :selenium do
    visit root_path
    within("div.footer") { click_link "Contact Us" }
    page.should have_content "Have a question? Drop us a line!"
    current_path.should == notices_path
  end

  scenario "user visits terms", js: true, driver: :selenium do
    visit root_path
    within("div.footer") { click_link "Terms" }
    page.should have_content "The Website may change these Terms of Use"
    current_path.should == notices_path
  end

  scenario "user visits privacy", js: true, driver: :selenium do
    visit root_path
    within("div.footer") { click_link "Privacy" }
    page.should have_content "This privacy policy sets out"
    current_path.should == notices_path
  end

  scenario "user visis learn more" do
    visit root_path
    visit learn_more_path
    current_path.should == learn_more_path
    page.should have_content "Learn More"
  end
end
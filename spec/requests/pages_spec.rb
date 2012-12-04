require "spec_helper"

feature "pages" do
  scenario "user visits about us", js: true do
    visit root_path
    click_link "About Us"
    current_path.should == notices_path
    page.should have_content "Our mission is to help unheralded singers and bands to advance their career in professional music."
  end

  scenario "user visits contact us", js: true do
    visit root_path
    click_link "Contact Us"
    current_path.should == notices_path
    page.should have_content "Have a question? Drop us a line!"
  end
end
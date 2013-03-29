require "spec_helper"

feature "pages" do
  scenario "user visits about us" do
    visit root_path
    within("div.footer") { click_link "About Us" }
    current_path.should == about_us_path
    page.should have_content "Our mission is to help unheralded singers and bands to advance their career in professional music."
  end

  scenario "user visits contact us" do
    visit root_path
    within("div.footer") { click_link "Contact Us" }

    current_path.should == contact_us_path
    page.should have_content "Have a question? Send us a note!"

    fill_in "Name", with: Faker::Name.name
    fill_in "Email", with: Faker::Internet.email
    fill_in "Subject", with: Faker::HipsterIpsum.sentence
    fill_in "Message", with: Faker::HipsterIpsum.paragraph
    click_button "Send"

    page.should have_content "Your message was sent, thanks!"
    current_path.should == contact_us_path
  end

  scenario "user visits terms" do
    visit root_path
    within("div.footer") { click_link "Terms" }
    page.should have_content "Agreement between user and MusicMogul.com"
    current_path.should == terms_path
  end

  scenario "user visits privacy" do
    visit root_path
    within("div.footer") { click_link "Privacy" }
    page.should have_content "Privacy"
    current_path.should == privacy_path
  end

  scenario "user visis contest rules" do
    visit root_path
    click_link "Contest Rules"
    current_path.should == contest_rules_path
    page.should have_content "Contest Rules"
  end
end
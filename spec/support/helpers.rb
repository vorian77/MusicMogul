module HelperMethods
  def sign_in_as(user)
    visit root_path

    within "ul.log-in-nav" do
      click_link "Log in"
    end

    within "div#popup-2" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
    end

    click_button "Log in"

    page.should have_content "Signed in successfully"
    within "div.display-name" do
      page.should have_content user.email
    end
  end
end

RSpec.configuration.include HelperMethods, type: :request
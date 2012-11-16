module HelperMethods
  def sign_in_as(user)
    visit root_path

    within "ul.log-in-nav" do
      click_link "Log in"
    end

    current_path.should == new_user_session_path

    within "form#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
    end

    click_button "Log in"

    current_path.should == root_path

    page.should have_content "Signed in successfully"
    within("div.display-name") { page.should have_content user.email }
  end
end

RSpec.configuration.include HelperMethods, type: :request
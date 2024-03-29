module HelperMethods
  def sign_in_as(user)
    visit root_path

    click_link "Sign In"

    current_path.should == new_user_session_path

    within "form#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
    end

    click_button "Sign In"

    current_path.should == root_path

    page.should have_content "Signed in successfully"
    user_should_be_logged_in user
  end

  def user_should_be_logged_in(user)
    within("div.account") do
      page.should have_content user.username? ? user.username : user.email
    end
  end
end

RSpec.configuration.include HelperMethods, type: :feature
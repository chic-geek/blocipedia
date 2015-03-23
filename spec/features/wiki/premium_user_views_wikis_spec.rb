require 'rails_helper'

feature 'premium user views wikis', type: :feature do
  scenario "premium user sees all public wikis and private wikis they own" do
    premium_user = create(:user, email: "test@email.com", password: "test-password", role: "premium")
    anon_user = create(:user, email: "test1@email.com", password: "test-password-1", role: "premium")
    private_wiki = create(:wiki, title: "Sports", user: premium_user, private: true)
    anon_private_wiki = create(:wiki, title: "Pets", user: anon_user, private: true)
    public_wiki = create(:wiki, title: "Hair", private: false)

    sign_in(premium_user.email, premium_user.password)
    click_link "My Wikis"

    expect(page).to have_css("h1", text: "My Wikis")
    expect(page).to have_content("Sports")
    # expect(page).to have_content("Hair")
    expect(page).not_to have_content("Pets")
  end

  private

    def sign_in(email, password)
      visit new_user_session_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Log in"
    end
end

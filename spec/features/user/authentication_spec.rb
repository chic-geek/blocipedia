require 'rails_helper'

feature "User Authentication", :type => :feature do

  context 'with valid details' do
    scenario "user logs in / out" do
      create(:user, email: "test@email.com", password: "test-password")

      visit "/"
      click_link "Sign in"

      expect(current_path).to eq(new_user_session_path)

      fill_in "Email", with: "test@email.com"
      fill_in "Password", with: "test-password"
      click_button "Log in"

      expect(current_path).to eq(wikis_path)
      expect(page).to have_content("Hey test@email.com")
      expect(page).to have_css(".user-info", text: "Account details")
      click_link "Sign out"

      expect(current_path).to eq("/")
      expect(page).to have_content("Signed out successfully.")
      expect(page).not_to have_content("Hey test@email.com")

    end
  end

  scenario "user has forgotten password" do
    create(:user, email: "test@email.com", password: "test-password")

    visit "/"
    click_link "Sign in"

    expect(current_path).to eq(new_user_session_path)
    click_link "Forgot your password?"

    expect(current_path).to eq(new_user_password_path)
    fill_in "Email", with: "test@email.com"
    click_button "Resend"

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")

    open_email "test@email.com", with_subject: "Reset password instructions"
    visit_in_email "Change my password"

    expect(current_path).to eq(edit_user_password_path)
    fill_in "New password", with: "new-password"
    fill_in "Confirm new password", with: "new-password"
    click_button "Update"

    expect(current_path).to eq(wikis_path)
    expect(page).to have_content("Your password has been changed successfully. You are now signed in.")
    expect(page).to have_content("Hey test@email.com")
  end
end

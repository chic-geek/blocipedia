require 'rails_helper'

feature 'User Collaboration', :type => :feature do

  scenario 'add a collaborator' do
    owner = create(:user, email: "test@email.com", password: "test-password")
    collaborator = create(:user, email: "collaborator@email.com", password: "test-password")
    wiki = create(:wiki, title: "Sports", body: "Sports content for all your sporting needs.", user: owner, private: true)

    sign_in(owner.email, owner.password)
    visit wiki_path(wiki)
    click_link "Collaborate"
    expect(page).to have_css("h1", text: "Wiki collaboration")
    fill_in "Email", with: collaborator.email
    click_button "Collaborate"
    expect(current_path).to eq(wiki_path(wiki))
    expect(page).to have_content(collaborator.email)
  end

  scenario 'delete a collaborator' do
    owner = create(:user, email: "test@email.com", password: "test-password")
    collaborator = create(:user, email: "collaborator@email.com", password: "test-password")
    wiki = create(:wiki, title: "Sports", body: "Sports content for all your sporting needs.", user: owner, private: true)

    sign_in(owner.email, owner.password)
    visit wiki_path(wiki)
    click_link "Collaborate"
    expect(page).to have_css("h1", text: "Wiki collaboration")
    fill_in "Email", with: collaborator.email
    click_button "Collaborate"
    expect(current_path).to eq(wiki_path(wiki))
    expect(page).to have_content(collaborator.email)

    click_link "Delete collaborator"
    expect(current_path).to eq(wiki_path(wiki))
    expect(page).to have_content("No longer collaborting with #{collaborator.email}")
  end

  private

    def sign_in(email, password)
      visit new_user_session_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Log in"
    end

end

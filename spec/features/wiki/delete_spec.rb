require 'rails_helper'

feature "wiki", :type => :feature do
  scenario "delete a wiki entry" do

    # a little standard setup
    user = create(:user, email: "test@email.com", password: "test-password")
    wiki = create(:wiki, title: "Sports", body: "Sports content for all your sporting needs.", user_id: user.id )

    # localhost:3000/users/sign_in
    visit new_user_session_path
    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "test-password"
    click_button "Log in"

    # localhost:3000/wikis
    expect(page).to have_content(wiki.title)
    expect(current_path).to eq(wikis_path)
    find('a[title="delete-item"]').click

    expect(page).not_to have_content(wiki.title)
    expect(current_path).to eq(wikis_path)
    expect(page).to have_content("Your wiki has been deleted.")
  end
end

require 'rails_helper'

feature 'Wiki edit/update', type: :feature do

  scenario "edit/update wiki entry" do

    # test data creation
    create(:user, email: "test@email.com", password: "test-password")
    create(:wiki, title: "Sports", body: "Sports content for all your sporting needs.")

    wiki = Wiki.last

    # localhost:3000/users/sign_in
    visit new_user_session_path
    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "test-password"
    click_button "Log in"

    # localhost:3000/wikis
    expect(page).to have_content(wiki.title)
    expect(current_path).to eq(wikis_path)
    find('a[title="edit-item"]').click

    # localhost:3000/wikis/1/edit
    expect(page).to have_css("h1", "Edit wiki")
    expect(current_path).to eq(edit_wiki_path(wiki))
    fill_in "Title", with: "Dogs"
    fill_in "Body", with: "Dogs are a wonderful pet, they require lots of attention and exercise!"
    click_button "Update"

    # localhost:3000/wikis/1
    expect(page).to have_content("Dogs")
    expect(page).to have_content("Dogs are a wonderful pet, they require lots of attention and exercise!")

  end

end

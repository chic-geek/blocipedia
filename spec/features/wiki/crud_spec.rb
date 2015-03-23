require 'rails_helper'

feature 'wiki', type: :feature do

  scenario "creates a wiki entry" do
    # test data creation
    user = create(:user, email: "test@email.com", password: "test-password")

    # localhost:3000/users/sign_in
    sign_in(user.email, user.password)

    # localhost/wikis/new  wikis#index
    expect(page).to have_content("Hey test@email.com")
    expect(current_path).to eq(wikis_path)
    click_link "Create a wiki"

    # localhost/wikis/new  wikis#new controller#action pair
    expect(page).to have_css("h1", text: "Create new wiki")
    expect(current_path).to eq(new_wiki_path)
    fill_in "Title", with: "Sports"
    fill_in "Body", with: "Sports content for all your sporting needs."
    click_button "Create wiki"

    # localhost/wikis/show  wikis#show
    expect(page).to have_css("h1", text: "Sports")
    expect(page).to have_content("Sports content for all your sporting needs.")
    expect(current_path).to eq(wiki_path(Wiki.last))
  end

  scenario "updates a wiki entry" do

    # test data creation
    user = create(:user, email: "test@email.com", password: "test-password")
    wiki = create(:wiki, title: "Sports", body: "Sports content for all your sporting needs.", user_id: user.id )

    # localhost:3000/users/sign_in
    sign_in(user.email, user.password)

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

  scenario "deletes a wiki entry" do

    # a little standard setup
    user = create(:user, email: "test@email.com", password: "test-password")
    wiki = create(:wiki, title: "Sports", body: "Sports content for all your sporting needs.", user_id: user.id )

    # localhost:3000/users/sign_in
    sign_in(user.email, user.password)

    # localhost:3000/wikis
    expect(page).to have_content(wiki.title)
    expect(current_path).to eq(wikis_path)
    find('a[title="delete-item"]').click

    expect(page).not_to have_content(wiki.title)
    expect(current_path).to eq(wikis_path)
    expect(page).to have_content("Your wiki has been deleted.")
  end

  private

    def sign_in(email, password)
      visit new_user_session_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Log in"
    end
end

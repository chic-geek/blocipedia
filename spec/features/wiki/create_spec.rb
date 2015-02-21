require 'rails_helper'

feature 'Wiki creation', type: :feature do

  scenario "create wiki" do
    # test data creation
    create(:user, email: "test@email.com", password: "test-password")

    # localhost:3000/users/sign_in
    visit new_user_session_path
    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "test-password"
    click_button "Log in"

    # localhost/wikis/new  wikis#index
    expect(page).to have_content("Hello test@email.com")
    expect(current_path).to eq(wikis_path)
    click_link "New wiki"

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

  ## Anonymous user unable to create wiki

end

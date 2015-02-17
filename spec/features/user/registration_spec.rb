require 'rails_helper'

feature 'User registration', :type => :feature do

  scenario 'with valid details' do

    visit '/'
    click_link 'Sign up'

    fill_out_form('memberone@example.com', 'memberone', 'memberone')

    expect(current_path).to eq('/')
    expect(page).to have_content(
      'A message with a confirmation link has been sent to
      your email address. Please follow the link to activate your account.'
    )

    open_email 'memberone@example.com', with_subject: 'Confirmation instructions'
    visit_in_email 'Confirm my account'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content 'Your email address has been successfully confirmed.'

  end

  context 'with invalid details' do

    before do
      visit new_user_registration_path
    end

  end

  private

  def fill_out_form(email, password, password_confirmation)
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password_confirmation
    click_button "Sign up"
  end

end

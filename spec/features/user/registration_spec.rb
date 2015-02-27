require 'rails_helper'

feature 'User registration', :type => :feature do

  scenario 'with valid details' do
    visit '/'
    click_link 'Sign up'

    fill_out_form('test@email.com', 'test-password', 'test-password')

    expect(current_path).to eq('/')
    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')

    open_email 'test@email.com', with_subject: 'Confirmation instructions'
    visit_in_email 'Confirm my account'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content 'Your email address has been successfully confirmed.'
  end

  context 'with invalid details' do
    before do
      visit new_user_registration_path
    end

    scenario 'has blank fields' do
      expect_blank_fields
      click_button 'Sign up'
      expect_error_msgs "Email can't be blank", "Password can't be blank"
    end

    scenario 'has invalid email address' do
      fill_out_form('invalid-email', 'password', 'password')
      expect_error_msgs "Email is invalid"
    end

    scenario 'has a pre-existing email address' do
      create(:user, email: "test2@email.com")
      fill_out_form('test2@email.com', 'test-password', 'test-password')
      expect_error_msgs "Email has already been taken"
    end

    scenario 'has incorrect password confirmation' do
      fill_out_form('test@email.com', 'test-password', 'wrong-test-password')
      expect_error_msgs "Password confirmation doesn't match Password"
    end

    scenario "password too short" do
      min_password_length = 8
      too_shorter_password = 'a' * (min_password_length - 1)
      fill_out_form("test@email.com", too_shorter_password, too_shorter_password)
      expect_error_msgs "Password is too short (minimum is 8 characters)"
    end
  end

  private

  ## Private methods to DRY up tests
  ## =========================================================================

  def fill_out_form(email, password, password_confirmation)
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password_confirmation
    click_button "Sign up"
  end

  def expect_blank_fields
    expect(page).to have_field('Email', with: '', type: 'email')
    expect(find_field("Password", type: "password").value).to be_nil
    expect(find_field("Password confirmation", type: "password").value).to be_nil
  end

  def expect_error_msgs(*messages)
    within '#error_explanation' do
      error_count = messages.size
      expect(page).to have_content "#{error_count} #{'error'.pluralize(error_count)} prohibited this user from being saved"
      within 'ul' do
        expect(page).to have_css 'li', count: error_count
        messages.each do |expected_msg|
          expect(page).to have_selector 'li', text: expected_msg
        end
      end
    end
  end
end

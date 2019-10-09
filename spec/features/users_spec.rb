require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Users", type: :feature do
  context 'create new users' do
    scenario 'should be successful' do
      visit new_user_registration_path
      within('form') do
        fill_in 'First Name', with: 'test'
        fill_in 'Last Name', with: 'test'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'user[password]', with: 'password1'
        fill_in 'Confirm Password', with: 'password1'
      end
      click_button 'Create User'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'should failed' do
      visit new_user_registration_path
      within('form') do
        fill_in 'First Name', with: 'test'
        fill_in 'Last Name', with: 'test'
        fill_in 'Email', with: 'user@example.com'
      end
      click_button 'Create User'
      expect(page).to have_content "Password can't be blank"
    end
  end
end

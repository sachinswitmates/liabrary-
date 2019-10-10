require 'rails_helper'

RSpec.feature "Signins", type: :feature do
  context 'login users' do
    scenario 'should be successful' do
      user = User.create(first_name: 'test', last_name: 'test', email: 'user@example.com',password: 'password1')
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'should failed' do
      user = User.create(first_name: 'test', last_name: 'test', email: 'user@example.com',password: 'password1')
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      click_button 'Login'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end
end

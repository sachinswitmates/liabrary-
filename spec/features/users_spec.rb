require 'rails_helper'


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
      click_link 'Logout'
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
  context 'create booking' do
    scenario 'should be successful'do
     user = User.create(first_name: 'test', last_name: 'test', email: 'user@example.com',password: 'password1',role: 'student')
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      visit '/student/libraries'
      library = Library.create(name: 'testttttttttt', address1: 'fsdf', address2:'gdfgdff',landmark: 'vijay nagar', state: 'madhya pradesh',city: 'indore',open: '24hrs', seats: '300',zip_code: '646555',contact_number: '5443544444')
      click_button 'Book Your Seat'

    end
  end
end

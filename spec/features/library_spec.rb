require 'rails_helper'

RSpec.feature "Libraries", type: :feature do
  context 'create new library' do
    scenario 'should be successful' do
      visit '/users/sign_up?partner=true'
      fill_in 'First Name', with: 'test'
      fill_in 'Last Name', with: 'test'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'user[password]', with: 'password1'
      fill_in 'Confirm Password', with: 'password1'
      click_button 'Create User'
      visit new_library_owner_library_path
      within('form') do
        fill_in 'Name', with: 'testttttttttttttt'
        fill_in 'Address1', with: 'AF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        fill_in 'Zip code', with: '452001'
        fill_in 'Open', with: '24 hrs'
        fill_in 'Seats', with: '200'
        fill_in 'Contact number', with: '8888889878'
      end
      click_button 'Save'
      expect(page).to have_content 'You have Successfully created your library.'
      click_link "testttttttttttttt"
      visit '/library_owner/libraries/1/edit'
      within("form") do
        fill_in 'Name', with: 'testttttttttttttt'
        fill_in 'Address1', with: 'AF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        fill_in 'Zip code', with: '4520041'
        fill_in 'Open', with: '24 hrs'
        fill_in 'Seats', with: '200'
        fill_in 'Contact number', with: '8888889878'
      end
      click_button 'Update'
      expect(page).to have_content 'You have Successfully updated'
    end

    scenario 'should failed' do
      user = User.create(first_name: 'test', last_name: 'test', email: 'user@example.com',password: 'password1',role: 'library_owner')
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      visit new_library_owner_library_path
      within('form') do
        fill_in 'Name', with: 'testttttttttttttt'
        fill_in 'Address1', with: 'AF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        fill_in 'Zip code', with: '452001'
        fill_in 'Open', with: '24 hrs'
        fill_in 'Contact number', with: '8888889878'
      end
      click_button 'Save'
      expect(page).to have_content "Seats can't be blank"
    end
  end
end

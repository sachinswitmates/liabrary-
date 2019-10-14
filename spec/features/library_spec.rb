require 'rails_helper'

RSpec.feature "Libraries", type: :feature do
  context 'create new library' do
    scenario 'should be successful' do
      visit '/users/sign_up?partner=true'
      fill_in 'First Name', with: 'test'
      fill_in 'Last Name', with: 'test'
      fill_in 'Email', with: 'library_owner@example.com'
      fill_in 'user[password]', with: 'password1'
      fill_in 'Confirm Password', with: 'password1'
      click_button 'Create User'
      sleep(2)
      visit new_library_owner_library_path
     
      within('form') do
        fill_in 'Name', with: 'testttttttttttttt'
        fill_in 'Address1', with: 'AF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        select 'Madhya Pradesh', from: 'State'
        fill_in 'Zip code', with: '452001'
        fill_in 'Open', with: '24 hrs'
        select '501', from: 'Seats'
        fill_in 'Contact number', with: '8888889878'
      end
      click_button 'Save'
      expect(page).to have_content 'You have Successfully created your library.'
      sleep(2)
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
        select 'Madhya Pradesh', from: 'State'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        fill_in 'Zip code', with: '452001'
        fill_in 'Open', with: '24 hrs'
        select '', from: 'Seats'
        fill_in 'Contact number', with: '8888889878'
      end
      click_button 'Save'
      expect(page).to have_content "Seats can't be blank"
      sleep(2)
    end
  end
  context 'library update' do 
    scenario 'should be successful' do
      user = User.create(first_name: 'test', last_name: 'test', email: 'library_owner@example.com',password: 'password1',role: 'library_owner')
      library = FactoryBot.create(:library,published: false, user_id: user.id)
      visit '/users/sign_in'
      fill_in 'Email', with: 'library_owner@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      sleep 2
      click_link "#{library.name}"
      sleep 2
      visit "/library_owner/libraries/#{library.id}/edit"
      within("form") do
        fill_in 'Name', with: 'testtindore library'
        fill_in 'Address1', with: 'AF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        select 'Madhya Pradesh', from: 'State'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        fill_in 'Zip code', with: '4520041'
        fill_in 'Open', with: '24 hrs'
        select '501', from: 'Seats'
        fill_in 'Contact number', with: '8286889878'
        sleep(2)
      end
      click_button 'Update'
      expect(page).to have_content 'You have Successfully updated'
      sleep(2)
      visit '/library_owner/libraries'
      sleep 1
      click_link 'Payment Method'
      sleep 2
      visit '/library_owner/bank_accounts/new'
      sleep 2
      within('form') do
        fill_in 'Bank name', with: 'Axis'
        fill_in 'Account number', with: '87899985522222'
        fill_in 'Ifsc code', with: 'AXIS000423'
        fill_in 'Account holder name', with: 'test'
      end
      click_button 'Save'
      expect(page).to have_content 'Payment method added successfully'
      sleep 2
      click_link 'Dashboard'
      sleep 2
      click_link 'Logout'
      sleep 2
      page.driver.browser.switch_to.alert.accept
      expect(page). to have_content 'Signed out successfully.'
      sleep 2
    end
  end
end

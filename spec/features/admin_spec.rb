require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  context 'create library and show all details' do
    scenario 'should be successful'do
      user = User.create(first_name: 'admin', last_name: 'admin', email: 'admin@example.com',password: 'password1',role: 'admin')
      library = FactoryBot.create(:library,published: true)
      visit '/users/sign_in'
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      sleep(1)
      visit '/admin/libraries/new'
      sleep 1
      within('form') do
        fill_in 'Name', with: 'testtttttttttttttt'
        fill_in 'Address1', with: 'AgF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        select 'Madhya Pradesh', from: 'State'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
        fill_in 'Zip code', with: '452001'
        fill_in 'Open', with: '24 hrs'
        select '501', from: 'Seats'
        fill_in 'Contact number', with: '8888889878'
      end
      sleep 1
      click_button 'Save'
      expect(page).to have_content 'You have Successfully created library.'
      sleep 2
      visit "/admin/libraries/#{library.id}/edit"
      sleep 2
      check('Published')
      sleep 2
      visit "/admin/libraries/#{library.id}"
      sleep 2
      user = User.create(first_name: 'test', last_name: 'test', email: 'library_owner1@example.com',password: 'password1',role: 'library_owner')
      click_link 'Library owner details'
      sleep(1)
      user = User.create(first_name: 'test1', last_name: 'test2', email: 'student@example.com',password: 'password1',role: 'student')
      click_link 'Student Details'
      sleep 2
      booking = FactoryBot.create(:booking,user_id: user.id,library_id: library.id)
      click_link 'View All Bookings'
      sleep 2
      click_link 'Libraries List'
      sleep 2
      click_link 'Dashboard'
      sleep(1)
      click_link 'LibraryApp'
      sleep 2
      click_link 'Logout'
      sleep(2)
      #page.driver.browser.switch_to.alert.accept
      expect(page). to have_content 'Signed out successfully.'
      sleep 1
    end
  end
end

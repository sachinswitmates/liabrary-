require 'rails_helper'

RSpec.feature "Students", type: :feature do
  context 'create new users' do
    scenario 'should be successful' do
      visit '/users/sign_up'
      sleep(2)
      within('form') do
        fill_in 'First Name', with: 'test1'
        fill_in 'Last Name', with: 'test1'
        fill_in 'Email', with: 'users@example.com'
        fill_in 'user[password]', with: 'password1'
        fill_in 'Confirm Password', with: 'password1'
      end
      click_button 'Create User'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
      sleep(2)
      click_link 'Logout'
    end

    scenario 'should failed' do
      visit new_user_registration_path
      within('form') do
        fill_in 'First Name', with: 'test1'
        fill_in 'Last Name', with: 'test1'
        fill_in 'Email', with: 'users@example.com'
      end
      click_button 'Create User'
      expect(page).to have_content "Password can't be blank"
      sleep(2)
    end
  end

  context 'create booking' do
    library = FactoryBot.create(:library)
    scenario 'should be failed booking'do
     user = User.create(first_name: 'test1', last_name: 'test1', email: 'users@example.com',password: 'password1',role: 'student')
      visit '/users/sign_in'
      fill_in 'Email', with: 'users@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      visit '/student/libraries'
      sleep 1
      click_link 'My Bookings'
      sleep 2
      visit '/student/libraries'
      sleep 1
      visit "/libraries/#{library.id}/bookings"
      sleep 1
      click_button 'Pay Now'
      expect(page).to have_content 'Please select package.'
      sleep 2
      choose('500-Monthly')
      sleep 2
      click_button 'Pay Now'
      sleep 2
       # page.driver.switch_to_frame.alert.sendKeys(contact)
       # fill_in 'Contact',with: '7894561235'
       # fill_in 'Email', with: 'users@example.com'
      #click_link 'My Bookings'
      sleep 2
    end
  end
end

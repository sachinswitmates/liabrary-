require 'rails_helper'

RSpec.feature "Students", type: :feature do
  context 'create new users' do
    scenario 'should be successful' do
      visit '/users/sign_up'
      sleep(2)
      within('form') do
        fill_in 'First Name', with: 'test1'
        fill_in 'Last Name', with: 'test1'
        fill_in 'Email', with: 'test1@example.com'
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
        fill_in 'Email', with: 'test1@example.com'
        fill_in 'user[password]', with: ''
      end
      click_button 'Create User'
      expect(page).to have_content "Password can't be blank"
      sleep(2)
    end
  end

  context 'create booking' do 
    scenario 'should be successful'do
      user = User.create(first_name: 'test1', last_name: 'test2', email: 'test1@example.com',password: 'password1',role: 'student')
      library = FactoryBot.create(:library)
      visit '/users/sign_in'
      fill_in 'Email', with: 'test1@example.com'
      fill_in 'Password', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Signed in successfully.'
      visit '/student/libraries'
      sleep 1
      click_link 'My Bookings'
      sleep 2
      find('input[type="search"]').click
      sleep 2
      find('input[name="search_city"]').click
      fill_in 'search_city', with: 'Indore'
      sleep 2
      click_button 'Search'
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
      expect(page).to have_css('iframe[class="razorpay-checkout-frame"]')
      razorpay_iframe = all('iframe[class="razorpay-checkout-frame"]').last
      within_frame razorpay_iframe do 
        sleep 1
        find('#contact', :visible => false).click
        fill_in 'contact', with: '7894565544'
        find('#email', :visible => false).click
        fill_in 'email', with: 'users@example.com'
        sleep 2

        #card
        find('span', text: 'Card').click
        sleep 2
        fill_in 'card[number]', with: '424242425434'
        find('#card_expiry', :visible => false).click
        fill_in 'card[expiry]', with: '12/37'
        find('#card_cvv', :visible => false).click
        fill_in 'card[cvv]', with: '132'
        sleep 2
        click_button 'PAY '
        expect(page).to have_content 'Please enter a valid card number'
        fill_in 'card[number]', with: '4242424242424242'
        fill_in 'card[cvv]', with: '12'
        sleep 2 
        click_button 'PAY '
        sleep 2
        fill_in 'card[cvv]', with: '123'
        sleep 3
        click_button 'PAY '
        sleep 2
        find('#otp-sec', :visible => true).click

        #netbanking
        # find('span', text: 'Netbanking').click
        # sleep 1
        # select 'Axis Bank', from: 'bank'
        # sleep 2
        # click_button 'PAY '
        # sleep 2
      end
      page.driver.browser.switch_to.window (page.driver.browser.window_handles.last) do
        click_button 'Failure'
        sleep 2
      end
      expect(page).to have_css('iframe[class="razorpay-checkout-frame"]')
      razorpay_iframe = all('iframe[class="razorpay-checkout-frame"]').last
      within_frame razorpay_iframe do 
        click_button 'Retry'
        sleep 2
        click_button 'PAY '
        sleep 2
      end
      page.driver.browser.switch_to.window (page.driver.browser.window_handles.last) do
        click_button 'Success'
        sleep 2
      end
      visit "/bookings/1"
      sleep 2
      click_link 'Back'
      sleep 2
      click_link 'LibraryApp'
      sleep 2
      click_link 'Logout'
      sleep 1
      page.driver.browser.switch_to.alert.accept
      expect(page). to have_content 'Signed out successfully.'
      sleep 1
    end
  end
end

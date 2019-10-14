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
    scenario 'should be successful'do
      user = User.create(first_name: 'test1', last_name: 'test1', email: 'users@example.com',password: 'password1',role: 'student')
      library = FactoryBot.create(:library,user_id: user.id)
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
      sleep 2
      visit "/libraries/#{library.id}/bookings"
      sleep 1
      click_button 'Pay Now'
      expect(page).to have_content 'Please select package.'
      sleep 2
      choose('500-Monthly')
      sleep 2
      click_button 'Pay Now'
      
      expect(page).to have_css('iframe[class="razorpay-checkout-frame"]')
      sleep 2
      razorpay_iframe = all('iframe[class="razorpay-checkout-frame"]').last
      within_frame razorpay_iframe do 
        sleep 1
        find('#contact', :visible => false).click
        fill_in 'contact', with: '7894565544'
        find('#email', :visible => false).click
        fill_in 'email', with: 'users@example.com'
        sleep 2
        #card
        # find('span', text: 'Card').click
        # sleep 2
        # fill_in 'card[number]', with: '42424242424242424242'
        # fill_in 'card[expiry]', with: '12/37'
        # fill_in 'card[cvv]', with: '123'
        # sleep 2
        # click_button 'PAY '
        # sleep 2 
        # find('#otp-sec', :visible => true).click

        #netbanking
        find('span', text: 'Netbanking').click
        sleep 1
        select 'Axis Bank', from: 'bank'
        sleep 2
        click_button 'PAY '
        sleep 2
      end 
        #click_button 'Success'
        # byebug
        # parent_handle = page.driver.window_handles
        # page.driver.window_handles.each do |handle|
        # page.driver.switch_to_window handle
        # sleep 1
        # #find('#success', visible: false).click  
        # # click_button ('success')
        # #find_button("success" ,visible: false) 
        # find('[class=success]').click
        # sleep 2    
      #end
      #page.driver.browser.switch_to.window
        #expect(page).to have_selector(:button, "Success")
    end
  end
end

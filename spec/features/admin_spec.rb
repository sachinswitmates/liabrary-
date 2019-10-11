require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Admins", type: :feature do
  scenario 'should be successful'do
    user = User.create(first_name: 'admin', last_name: 'admin', email: 'admin@example.com',password: 'password1',role: 'admin')
    visit '/users/sign_in'
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password1'
    click_button 'Login'
    expect(page).to have_content 'Signed in successfully.'
    sleep(1)
    visit '/admin/libraries/new'
    sleep 1
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
    sleep 1
    click_button 'Save'
    expect(page).to have_content 'You have Successfully created library.'
    library = FactoryBot.create(:library)
    sleep 1
    visit "/admin/libraries/#{library.id}/edit"
    sleep 2
    check('Published')
    sleep 2
    visit "/admin/libraries/#{library.id}"
    sleep 2
    click_link 'Library owner details'
    sleep(1)
    click_link 'Student Details'
    sleep(1)
    click_link 'View All Bookings'
    sleep(1)
    click_link 'Libraries List'
    sleep(1)
    click_link 'Dashboard'
    sleep(1)
    click_link 'LibraryApp'
    sleep 2
    click_link 'Logout'
    sleep(2)
    page.driver.browser.switch_to.alert.accept
    expect(page). to have_content 'Signed out successfully.'
    sleep 1
  end
end

require 'rails_helper'

RSpec.feature "Libraries", type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
  end
  context 'create new library' do
    scenario 'should be successful' do
      visit new_library_owner_library_path
      within('form') do
        fill_in 'Name', with: 'testttttttttttttt'
        fill_in 'Open', with: '24 hrs'
        fill_in 'Seats', with: '200'
        fill_in 'Contact Number', with: '8888889878'
        fill_in 'Address1', with: 'AF5'
        fill_in 'Address2', with: 'Agra Bombay road'
        fill_in 'State', with: 'Madhya Pradesh'
        fill_in 'Landmark', with: 'Vijay Nagar'
        fill_in 'City', with: 'Indore'
        fill_in 'Zip Code', with: '452001'
        fill_in 'Monthly', with: '500'
        fill_in 'Yearly', with: '6500'
      end
      click_button 'Save'
      
    end
  end
end

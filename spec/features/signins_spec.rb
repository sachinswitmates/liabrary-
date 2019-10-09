require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature "Signins", type: :feature do
  it "signs me in" do
    visit new_user_session_path
    within('form') do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password1'
    end
    click_button 'Login'
    expect(page).to have_content 'Signed in successfully.'
  end
  scenario 'should failed' do
    visit new_user_session_path
    within('form') do
      fill_in 'Email', with: 'user@example.com'
    end
    click_button 'Login'
    expect(page).to have_content "Invalid Email or password."
  end
end

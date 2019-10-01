require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do

  describe 'omniauth facebook' do
    let(:current_user) { FactoryBot.create(:user,provider: 'facebook',uid: '12345') }
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new
      request.env['devise.mapping'] = Devise.mappings[:user]
      allow(User).to receive(:from_omniauth) { current_user }
    end

    context 'new user' do
      before { get :facebook }
      it 'authenticate user' do
        expect(warden.authenticated?(:user)).to be_truthy
      end
      it 'set current_user' do
        expect(current_user).not_to be_nil
      end
      it 'redirect to student/libraries' do
        expect(response).to redirect_to student_libraries_path
      end
    end
  end

  describe 'omniauth google_oauth2' do
    let(:current_user) { FactoryBot.create(:user,provider: 'google_oauth2',uid: '123452') }

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new
      request.env['devise.mapping'] = Devise.mappings[:user]
      allow(User).to receive(:from_omniauth) { current_user }
    end

    context 'new user' do
      before { get :google_oauth2}

      it 'authenticate user' do
        expect(warden.authenticated?(:user)).to be_truthy
      end

      it 'set current_user' do
        expect(current_user).not_to be_nil
      end

      it 'redirect to student/libraries' do
        expect(response).to redirect_to student_libraries_path
      end
    end
  end
end

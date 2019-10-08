require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'after_sign_in_path' do
    it 'after_sign_in_path_for_admin' do
      user = FactoryBot.create(:user,role: 'admin')
      expect(response.status).to eq 200
    end

    it 'after_sign_in_path_for_library_owner' do
      user = FactoryBot.create(:user,role: 'library_owner')
      expect(response.status).to eq 200
    end

    it 'after_sign_in_path_for_student' do
      user = FactoryBot.create(:user,role: 'student')
      expect(response.status).to eq 200
    end
    
    it 'after_sign_in_path_for_nil' do
      user = FactoryBot.create(:user,role: '')
      expect(response.status).to eq 200
    end
  end
end

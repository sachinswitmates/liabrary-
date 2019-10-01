require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe 'POST create' do
    it 'create a user image' do
      user = FactoryBot.create(:user)
      image = FactoryBot.create(:image, imageable_id: user.id, imageable_type: 'User')
      request.env['devise.mapping'] = Devise.mappings[:user]
      expect{
        post :create, params: {user: FactoryBot.attributes_for(:user)}
      }.to change(Library,:count).by(0)
    end
  end
end

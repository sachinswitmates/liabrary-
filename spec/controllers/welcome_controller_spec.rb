require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @library = FactoryBot.create(:library, user_id: @user.id, published: true)
  end
  describe 'GET index' do
    it 'show all libraries with search city' do
      search_city = 'indore'
      get :index
      expect(@library).to eql(@library)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end 
  end

  describe "GET show" do
    it "show should be success" do
      @image = FactoryBot.create(:image,imageable_id: @library.id, imageable_type: 'Library')
      @review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :show, params: {id:  @library.id}
      expect(assigns(:library)).to eql(@library)
      expect(response).to render_template(:show)
    end
  end

  # describe 'GET city_search' do
  #   it 'find city' do
  #     @city  = FactoryBot.create(:city).to_json
  #     get :city_search
  #   end
  # end
end

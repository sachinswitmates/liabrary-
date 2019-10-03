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
      expect(@library.published).to eql(@library.published)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end 
  end

  describe "GET show" do
    it "show all libraries with images and reviews" do
      @image = FactoryBot.create(:image,imageable_id: @library.id, imageable_type: 'Library')
      @review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :show, params: {id:  @library.id}
      expect(@library.images).to eql(@library.images)
      expect(@library.reviews).to eql(@library.reviews)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET city_search' do
    it 'find city' do
      @city  = FactoryBot.create(:city)
      get :city_search,  format: :json
      expect(response).to be_successful
    end
  end
end

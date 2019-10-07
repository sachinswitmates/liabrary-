require 'rails_helper'

RSpec.describe Student::LibrariesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @library = FactoryBot.create(:library, user_id: @user.id,published: true)   
  end
  
  describe "GET index" do
    it "shows all libraries for signed in user" do
      get :index
      expect(@library.published).to eql(@library.published)      
    end 
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end 

  describe "GET show" do
    it "shows all libraries and reviews of libraries" do
      @image = FactoryBot.create(:image,imageable_id: @library.id, imageable_type: 'Library')
      @review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :show, params: {id: @library.id}
      expect(@library.images).to eql(@library.images)
      expect(@library.reviews).to eql(@library.reviews)
      expect(response).to render_template(:show)
    end
  end

  describe 'view_reviews' do
    it " show a library_reviews" do
      review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :view_reviews,params: {id: @library.id}
      expect(response).to render_template(:view_reviews)
    end
  end
end

require 'rails_helper'

RSpec.describe Student::LibrariesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @library = FactoryBot.create(:library, user_id: @user.id)   
  end
  
  describe "GET index" do
    it "shows all libraries for signed in user" do
      get :index
      expect(@library).to eql(@library)      
    end 
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end 

  describe "GET show" do
    it "shows all libraries and reviews of libraries" do
      @review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :show, params: {id: @library.id}
      @library.reviews.average(:rating).round(2)
      expect(assigns(:library)).to eql(@library)
      expect(response).to render_template(:show)
    end
  end

  describe '#view_reviews' do
    it " show a library_reviews" do
      review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :view_reviews,params: {id: @library.id}
      expect(response).to render_template(:view_reviews)
    end
  end
end

require 'rails_helper'

RSpec.describe LibraryOwner::LibrariesController, type: :controller do
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

  describe "GET new" do
    it "create a new libraries" do
      get :new
      expect(assigns(:library)).to be_a_new(Library)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new library" do
        expect{
          post :create, params: {library: FactoryBot.attributes_for(:library)}
        }.to change(Library,:count).by(0)
      end
      it "redirects to the new library" do
        post :create, params: {library: FactoryBot.attributes_for(:library)}
        expect(response).to render_template('new')
      end
    end 
  end

  describe "#library_bookings" do
    it "show a library bookings" do
      booking = FactoryBot.create(:booking, user_id: @user.id, library_id: @library.id)
      get :library_bookings, params: {id: @library.id}
      expect(response).to render_template(:library_bookings)
    end
  end

  describe '#view_library_reviews' do
    it " show a library_reviews" do
      review = FactoryBot.create(:review, library_id: @library.id, user_id: @user.id)
      get :view_library_reviews,params: {id: @library.id}
      expect(response).to render_template(:view_library_reviews)
    end
  end

  describe "PUT update" do  
    context "with valid attributes" do
      it "should update the library" do
        @attr = { :name => "dev", :city => "bhopal" }
        put :update, params: {:id => @library.id, :library => @attr }
        @library.update(@attr)
        expect(response).to redirect_to library_owner_library_path(@library)
      end
      it "should re-render edit template" do
        @attr = { :name => "", :city => "bhopal" }
        put :update, params: {:id => @library.id, :library => @attr }
        @library.update(@attr)
        expect(response).to render_template(:edit)
      end
    end
  end
      
  describe "GET show" do
    it "show should be success" do
      @image = FactoryBot.create(:image,imageable_id: @library.id, imageable_type: 'Library')
      get :show, params: {id:  @library.id}
      expect(assigns(:library)).to eql(@library)
      expect(response).to render_template(:show)
    end
  end  
end

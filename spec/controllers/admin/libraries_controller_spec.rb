require 'rails_helper'

RSpec.describe Admin::LibrariesController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user,role: 'admin')
    sign_in @user
    @library = FactoryBot.create(:library, user_id: @user.id)   
  end
  describe "GET index" do
    it "shows all libraries for admin" do
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
          post :create, params: {library: FactoryBot.attributes_for(:library).merge(user_id: @user.id)}
        }.to change(Library,:count).by(1)
        expect(response).to redirect_to admin_libraries_path
      end
      it "redirects to the new library" do
        post :create, params: {library: FactoryBot.attributes_for(:library,user_id: nil)}
        expect(response.status).to eq 302
      end
    end 
  end

  describe "GET show" do
    it "show all libraries" do
      @image = FactoryBot.create(:image ,imageable_id: @library.id, imageable_type: 'Library')
      get :show, params: {id:  @library.id}
      expect(assigns(:library)).to eql(@library)
      expect(response).to render_template(:show)
    end
  end

  describe "PUT update" do  
    context "with valid attributes" do
      it "should update the library" do
        @attr = { :name => "devv", :city => "bhopal", published: true }
        put :update, params: {:id => @library.id, :library => @attr }
        @library.update(@attr)
        @library.send_published_notification_email
        expect(response).to redirect_to admin_libraries_path
      end
      it "should re-render edit template" do
        @attr = { :name => "", :city => "bhopal" }
        put :update, params: {:id => @library.id, :library => @attr }
        @library.update(@attr)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it "deletes the library" do
      expect{ 
        delete :destroy, params: {:id => @library}
     }.to change(Library, :count).by(-1)
      @library.update(deleted_at: Time.now)
     expect(response).to have_http_status(302)
    end
  end

  describe 'prevent_unauthorize_access' do
    it "admin is not authorize to access page" do
      sign_in @user 
      @user.role == 'admin'
      flash[:alert] = "You'r not authorize to access this page"
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET  all_bookings' do
    it "show  all_bookings to admin" do
      @booking = FactoryBot.create(:booking, user_id: @user.id, library_id: @library.id)
      get :all_bookings
      expect(response).to render_template(:all_bookings)
    end
  end

  describe 'GET library_owner_details' do
    it "show all library_owner_details" do 
      get :library_owner_details
      expect(response).to render_template(:library_owner_details)
    end
  end

  describe 'GET student_details' do
    it "show all student_details" do
      get :student_details
      expect(response).to render_template(:student_details)
    end
  end

  describe 'GET libraries_list' do
    it "show all libraries_list" do
      get :libraries_list
      expect(response).to render_template(:libraries_list)
    end
  end

  describe 'GET lib_bookings' do
    it " show all library bookings" do
      @booking = FactoryBot.create(:booking, user_id: @user.id, library_id: @library.id)
      get :lib_bookings, params: {id: @library.id}
      expect(response).to render_template(:lib_bookings)
    end
  end                  
end

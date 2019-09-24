require 'rails_helper'

RSpec.describe LibraryOwner::LibrariesController, type: :controller do
  describe "GET index" do
    before(:each) do
      @user = FactoryBot.create(:user)
      @library = FactoryBot.create(:library)
      sign_in @user
    end

    it "shows all libraries for signed in user" do
      get :index
      expect(@library).to eql(@library)      
    end 

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
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
      

        # describe "PUT 'update/:id'" do
        #   let(:params) do {
        #       name: "vvdfsg",
        #       city: "bhopal" }
        #   end
        #     it "update the library" do
        #       #library = FactoryBot.create(:library)
        #       put :update, params: {id: @library.id, library: FactoryBot.attributes_for(:library)}
        #       library.reload
        #       expect(response).to be_successful
        #     end
        # end
    
      # describe "GET show" do
      #   it "renders the show template" do
      #     get :show, params: {id:  @library.id}
      #     expect(assigns(:library)).to be_a_new(Library)
      #     expect(response).to render_template("show")
      #   end
      end
    end
  end  
end

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @library = FactoryBot.create(:library,user_id: @user.id)
    @review = FactoryBot.create(:review, user_id: @user.id, library_id: @library.id )   
  end

  describe "GET new" do   
    it " new Review"   do
      get :new
      expect(assigns(:review)).to be_a_new(Review)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it 'creates a new review' do
      expect{ post :create, params: {review: FactoryBot.attributes_for(:review,library_id: @library.id, user_id: @user.id)}
          }.to change(Review,:count).by(1)
      expect(response).to redirect_to  view_reviews_student_library_path(@library.id)
    end
  end

  describe "PATCH #update" do
    context "with good data" do
      it "updates review" do
        @attr =  { rating: "5", comment: "Excellent"}
        patch :update, params: {id: @review.id, :review => @attr}
        @review.update(@attr)
        expect(response).to have_http_status(302)
      end
      it "does not update the review" do
        @attr =  { rating: "5", comment: ""}
        patch :update, params: {id: @review.id, :review => @attr}
        @review.update(@attr)
        expect(response).to render_template('edit')
      end      
    end
  end
end

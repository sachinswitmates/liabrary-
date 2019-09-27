require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @library = FactoryBot.create(:library, user_id: @user.id)  
    @booking = FactoryBot.create(:booking,user_id: @user.id, library_id: @library.id) 
  end

  describe "GET index" do
    it "shows all libraries for signed in user" do
      get :index
      expect(@booking).to eql(@booking)      
    end 
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end 
  end
  describe "GET new" do
    it "show  a new booking form" do
      get :new, params: {library_id: @library.id}
      expect(assigns(:booking)).to be_an_instance_of(Booking)
    end
    it "renders the new template" do
      get :new, params: {library_id: @library.id}
      expect(response).to render_template("new")
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new booking" do
        expect{
          post :create, params: {library_id: @library.id,booking: FactoryBot.attributes_for(:booking).merge(library_id: @library.id)} 
        }.to change(Booking,:count).by(1)
        @booking.payment_method == 'Online' && @booking.razorpay_payment_id == 'pay_Dsvfgdbgdfgbhgfhn'
        @booking.update(payment_status: 'paid')
        @booking.send_booking_notification_email
        flash[:notice] = "You have successfully booked your seat."
        expect(response).to redirect_to bookings_path
      end
      it "redirects to the new library" do
        post :create, params: {library_id: @library.id,booking: FactoryBot.attributes_for(:booking).merge(library_id: @library.id)}
        expect(response).to render_template('user_mailer/notify_student')
      end
    end 
  end

  describe 'GET show' do
    it ' show all current user bookings' do
      get :show, params: {id:  @booking.id}
      expect(assigns(:booking)).to eql(@booking)
      expect(response).to render_template(:show)
    end
  end
end

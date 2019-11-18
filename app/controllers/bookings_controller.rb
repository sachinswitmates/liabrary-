class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library, only: [:new, :create] 
  
  def index
    @bookings = current_user.bookings.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    #if verify_recaptcha(model: @booking) && @booking.save
    if @booking.save
      if @booking.payment_method == 'Online' && @booking.razorpay_payment_id.present?
        @booking.update(payment_status: 'paid')
      else
        @booking.update(payment_status: 'unpaid')
      end
      @booking.send_booking_notification_email
      flash[:notice] = "You have successfully booked your seat."
      redirect_to bookings_path
    else
      render 'new'
    end
  end

  def show
    @booking =Booking.find(params[:id])
  end

private
  def booking_params
    params.require(:booking).permit(:package, :payment_method, :subscription_length,:token, :library_id,:razorpay_payment_id,:plan_id,:payment_status)
  end

  def set_library
    @library = Library.find(params[:library_id])
  end
end

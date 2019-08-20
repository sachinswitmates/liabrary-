class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library, only: [:new, :create] 
  
  def index
    @bookings = current_user.bookings.order("created_at DESC").paginate(page: params[:page], per_page: 9)
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      current_user.send_booking_notification_email
      flash[:notice] = "You have successfully booked your seat please proceeds for payment"
      redirect_to bookings_path
    else
      render 'new'
    end
  end

  def show
    @booking =Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

private
  def booking_params
    params.require(:booking).permit( :package, :payment, :subscription_length, :library_id)
  end

  def set_library
    @library = Library.find(params[:library_id])
  end

end

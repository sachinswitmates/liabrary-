class BookingsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      flash[:notice] = "You have successfully booked your seat plz proceeds for payment...!!!"
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
    params.require(:booking).permit(:name, :email, :contact_number, :seats, :package)
  end

end

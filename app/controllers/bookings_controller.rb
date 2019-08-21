class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library, only: [:new, :create] 
  
  def index
    @qr = RQRCode::QRCode.new("http://github.com/")
    png = @qr.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 120,
          border_modules: 4,
          module_px_size: 6,
          file: nil # path to write
        )
    File.write('/home/rails/rails_work/test_projects/LibraryApp/public/github-qrcode.txt', @qr.to_s)
    @bookings = current_user.bookings.order("created_at DESC").paginate(page: params[:page], per_page: 9)
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      @booking.send_booking_notification_email
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
    params.require(:booking).permit(:package, :payment, :subscription_length, :library_id)
  end

  def set_library
    @library = Library.find(params[:library_id])
  end

end

class Admin::LibrariesController < ApplicationController
  before_action :authenticate_user!
  before_action :prevent_unauthorize_access?
  before_action :set_library, only: [:show, :edit, :update, :destroy]
  
  def index
    @libraries = Library.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @images = @library.images
  end

  def new
    @library = Library.new
  end

  def edit
  end
 
  def create
    @library = Library.new(library_params)
    if @library.save
      redirect_to admin_libraries_path
    else
      render 'new'
    end
  end

  def update
    if @library.update(library_params)
      flash[:notice] = "Successfully updated"
      @library.send_published_notification_email
      redirect_to admin_libraries_path
    else
      render 'edit'
    end
  end

  def destroy
    @library.update(deleted_at: Time.now)
    redirect_to admin_libraries_path
  end

  def prevent_unauthorize_access?
    unless current_user && current_user.admin?
      flash[:alert] = "You'r not authorize to access this page"
      redirect_to root_path
    end
  end

  def all_bookings
    @bookings = Booking.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def library_owner_details
   @users = User.where(role: "library_owner").order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def student_details
    @users = User.where(role: "student").order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def libraries_list
    @libraries = Library.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end
 
private
  def library_params
    params.require(:library).permit(:name,:address1,:address2,:state,:city,:landmark,:zip_code, :open, :seats,:contact_number,:published)
  end

  def set_library
    @library = Library.find(params[:id])
  end
end

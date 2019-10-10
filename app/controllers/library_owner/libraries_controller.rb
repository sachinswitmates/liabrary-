class LibraryOwner::LibrariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library, only: [:show, :edit, :update]
  before_action :prevent_unauthorize_access?
  
  def index
    @libraries = current_user.owned_libraries.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def new
    @library = current_user.libraries.new
  end

  def create
    @library = current_user.libraries.new(library_params)
    if @library.save
      flash[:notice] = "You have Successfully created your library."
      current_user.send_notification_email
      redirect_to library_owner_libraries_path
    else
      render 'new'
    end
  end

  def show
    @images = @library.images
  end

  def edit
  end

  def update
    if @library.update(library_params)
      flash[:notice] = "You have Successfully updated"
      redirect_to library_owner_library_path
    else
      render 'edit'
    end
  end

  def prevent_unauthorize_access?
    unless current_user && current_user.library_owner?
      flash[:alert] = "You'r not authorize to access this page"
      redirect_to root_path
    end
  end

  def library_bookings
    @library = Library.find(params[:id])
    @bookings = @library.bookings.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end
  
  def view_library_reviews
    @library = Library.find(params[:id])
    @reviews = @library.reviews
  end
  
private
  def library_params
    params.require(:library).permit(:name, :address1,:address2,:state,:city,:landmark,:zip_code, :open, :seats,:contact_number,:user_id,:monthly, :quaterly, :halfyearly, :yearly,:monthly_plan_id,:quaterly_plan_id,:halfyearly_plan_id,:yearly,images_attributes: [:id, :avatar, :_destroy])
  end

  def set_library
    @library = current_user.owned_libraries.find(params[:id])
  end
end

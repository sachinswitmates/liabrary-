class LibraryOwner::LibrariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library, only: [:show, :edit, :update]
  before_action :prevent_unauthorize_access?
  
  def index
    @libraries = current_user.libraries
  end

  def new
    @library = current_user.libraries.new
  end

  def create
    @library = current_user.libraries.new(library_params)
    if @library.save
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

private
  def library_params
    params.require(:library).permit(:name, :address1,:address2,:state,:city,:landmark,:zip_code, :open, :seats, :availability,:contact_number, images_attributes: [:id, :avatar, :_destroy])
  end


  def set_library
    @library = current_user.libraries.find(params[:id])
  end
end

class LibraryOwner::LibrariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_library, only: [:show, :edit, :update]
  
  def index
    @libraries = current_user.libraries
  end

  def new
    @library = current_user.libraries.new
  end

  def create
    @library = current_user.libraries.new(library_params)
    if @library.save
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

private
  def library_params
    params.require(:library).permit(:name, :address, :open, :seats, :availability, images_attributes: [:id, :avatar, :_destroy])
  end


  def set_library
    @library = current_user.libraries.find(params[:id])
  end
end

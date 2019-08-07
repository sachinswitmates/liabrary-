class Admin::LibrariesController < ApplicationController
  before_action :authenticate_user!
  before_action :prevent_unauthorize_access?
  
  def index
    @libraries = Library.all
  end
  
  def show
    @library = Library.find(params[:id])
  end

  def new
    @library = Library.new
  end

  def edit
    @library = Library.find(params[:id])
  end
 
  def create
    @library = Library.new(library_params)
    if @library.save
      redirect_to admin_library_path(@library)
    else
      render 'new'
    end
  end

  def update
    @library = Library.find(params[:id])
    if @library.update(library_params)
      redirect_to admin_library_path
    else
      render 'edit'
    end
  end

  def destroy
    @library = Library.find(params[:id])
    @library.destroy
    redirect_to admin_libraries_path
  end

  def prevent_unauthorize_access?
    unless current_user && current_user.admin?
      flash[:alert] = "You'r not authorize to access this page"
      redirect_to root_path
    end
  end
 
 

private
  def library_params
    params.require(:library).permit(:name, :address, :open, :seats, :availability)
  end
end
  


class Admin::LibrariesController < ApplicationController
  before_action :authenticate_user!
  before_action :prevent_unauthorize_access?
  
  def index
    @libraries = Library.order("created_at DESC").paginate(page: params[:page], per_page: 10)
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
      redirect_to admin_libraries_path
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
    @library.update(deleted_at: Time.now)
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
    params.require(:library).permit(:name,:address1,:address2,:state,:city,:landmark,:zip_code, :open, :seats, :availability,:contact_number,:published)
  end
end
  


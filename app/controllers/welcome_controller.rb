class WelcomeController < ApplicationController
  def index
    if params[:search_city].present?
      @libraries = Library.published.where("lower(city) =(?)", params[:search_city].to_s.downcase).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      if @libraries.empty?
        flash[:notice] = "This city has no libraries."
      elsif @libraries.present?
        flash[:notice] = " This City has #{@libraries.count} libraries."    
      end
    else
      @libraries = Library.published.order("created_at DESC").paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @library = Library.find(params[:id])
    @images = @library.images
  end

  def city_search
    @cities = City.where("lower(name) LIKE ?", "%#{params[:city].to_s.downcase}%")
    respond_to do |format|
      format.json do
        render json: @cities.pluck(:name)
      end
    end
  end
end


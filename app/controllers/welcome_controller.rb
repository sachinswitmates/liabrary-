class WelcomeController < ApplicationController
  def index
    if params[:search].present?
      @libraries = Library.published.where("lower(city) =(?)", params[:search].to_s.downcase).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    else
      @libraries = Library.published.order("created_at DESC").paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @library = Library.find(params[:id])
    @images = @library.images
  end

  def city_search
    @cities = City.where("lower(name) LIKE ?", "%#{params[:search].to_s.downcase}%")
    respond_to do |format|
      format.json do
        render json: @cities.pluck(:name)
      end
    end
  end
end


class WelcomeController < ApplicationController
  def index
  	@libraries = Library.published
  end

  def show
  	@library = Library.find(params[:id])
  	@images = @library.images
  end
end

class WelcomeController < ApplicationController
  def index
  	@libraries = Library.published
  end
end

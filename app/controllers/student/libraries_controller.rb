class Student::LibrariesController < ApplicationController

  def index
    @libraries = Library.published
  end

  def show
    @library = Library.find(params[:id])
  end

end

class Student::LibrariesController < ApplicationController
  def index
    @libraries = Library.published.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def show
    @library = Library.find(params[:id])
  end
end

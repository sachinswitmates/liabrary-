class Student::LibrariesController < ApplicationController
  def index
    @libraries = Library.published.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def show
    @library = Library.find(params[:id])
    @reviews = @library.reviews.to_a
    @avg_rating = if @reviews.blank?
      0
    else
      @library.reviews.average(:rating).round(2)
    end
  end
  def view_reviews
    @library = Library.find(params[:id])
    @reviews = @library.reviews
  end
end

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit,:update,:destroy]
  before_action :set_library, except: [:create,:update]

  def new
    @review = Review.new
  end

  def edit
  end

  def show
  end

  def create
    @library = Library.find_by(id: params[:review][:library_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to  view_reviews_student_library_path(@library)
    else
      render 'new'
    end
  end

  def update
    @library = Library.find_by(id: params[:review][:library_id])
    if @review.update(review_params)
      flash[:notice] = "You have Successfully updated your review"
      redirect_to  view_reviews_student_library_path( @library)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "you have Successfully deleted your review"
    redirect_to view_reviews_student_library_path( @library)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end
  
  def set_library
    @library = Library.find_by(params[:id])
  end

  private
    def review_params
      params.require(:review).permit(:rating, :comment,:user_id,:library_id)
    end
end



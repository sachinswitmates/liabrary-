class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update]
  before_action :set_library, except: [:create]

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
    if @review.update(review_params)
      flash[:notice] = "You have Successfully updated"
      redirect_to view_reviews_student_library_path(@library)
    else
      render 'edit'
    end
  end

  # def destroy
  #   @review.destroy
  #   flash[:notice] = "you have Successfully deleted your review"
  #   redirect_to root_path
  # end

  private
    def set_review
      @review = Review.find(params[:id])
    end
  
  def set_library
    #id = params[:id] || params[:review][:library_id]
    @library = Library.find_by(params[:id])
  end

  private
    def review_params
      params.require(:review).permit(:rating, :comment,:user_id,:library_id)
    end
end



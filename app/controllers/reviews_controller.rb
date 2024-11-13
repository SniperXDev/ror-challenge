class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build(review_params.merge(user: current_user))

    if @review.save
      redirect_to @book, notice: "Review successfully added."
    else
      redirect_to @book, alert: "You can only review a book once."
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end

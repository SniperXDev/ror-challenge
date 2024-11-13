class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build(review_params.merge(user: current_user))

    respond_to do |format|
      if @review.save
        format.html { redirect_to @book, notice: "Review successfully added." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_review_form", partial: "reviews/form", locals: { book: @book, review: @review })
        end
        format.html { redirect_to @book, alert: "You can only review a book once." }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end

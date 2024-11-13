class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_book, only: [ :new, :create ]
  before_action :set_review, only: [ :edit, :update, :destroy ]
  before_action :check_review_owner, only: [ :edit, :update, :destroy ]

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

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to book_path(@review.book), notice: "Review was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to book_path(@review.book), notice: "Review was successfully deleted."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def check_review_owner
    unless @review.user == current_user
      redirect_to book_path(@review.book), alert: "You can only edit or delete your own reviews."
    end
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end

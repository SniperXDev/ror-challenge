class BooksController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    if params[:query].present?
      @books = Book.where("title LIKE ? OR author LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                   .order(sort_params)
                   .page(params[:page])
                   .per(10)
    else
      @books = Book.order(sort_params).page(params[:page]).per(10)
    end
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      respond_to do |format|
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.turbo_stream { redirect_to @book, notice: "Book was successfully created." }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_book_form", partial: "books/form", locals: { book: @book }) }
      end
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :publication_year)
  end

  def sort_params
    # default sorting by title
    sort_column = params[:sort] || "title"
    sort_direction = params[:direction] || "asc"
    { sort_column => sort_direction }
  end
end

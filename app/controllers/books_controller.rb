class BooksController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @books = Book.includes(:reviews).order(created_at: :desc).page(params[:page])
  end

  def show
    @book = Book.includes(:reviews).find(params[:id])
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book successfully added."
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :publication_year, :isbn)
  end
end

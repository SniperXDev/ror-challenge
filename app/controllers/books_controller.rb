class BooksController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    @books = Book.page(params[:page]).per(10)
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
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :publication_year)
  end
end

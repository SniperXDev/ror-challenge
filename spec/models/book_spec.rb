require 'rails_helper'

RSpec.describe Book, type: :model do
  it "is valid with valid attributes" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", publication_year: 1925, isbn: "9780743273565")
    expect(book).to be_valid
  end

  it "is invalid without a title" do
    book = Book.new(title: nil)
    expect(book).to_not be_valid
  end

  it "is invalid without an ISBN number" do
    book = Book.new(isbn: nil)
    expect(book).to_not be_valid
  end

  it "doesn't allow duplicate ISBNs" do
    book1 = Book.create(title: "Book 1", isbn: "12345")
    book2 = Book.new(title: "Book 2", isbn: "12345")
    expect(book2).to_not be_valid
  end

  it "calculates the average rating" do
    book = Book.create(title: "Sample Book", isbn: "12345")
    user = User.create(email: "user@example.com", password: "password")
    Review.create(book: book, user: user, rating: 4, content: "Great book")
    Review.create(book: book, user: user, rating: 5, content: "Loved it")

    expect(book.average_rating).to eq(4.5)
  end
end

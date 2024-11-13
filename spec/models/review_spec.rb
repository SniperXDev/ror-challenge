require 'rails_helper'

RSpec.describe Review, type: :model do
  it "is valid with valid attributes" do
    book = Book.create(title: "Test Book", author: "Author", isbn: "12345")
    user = User.create(email: "user@example.com", password: "password")
    review = Review.new(rating: 5, content: "Amazing book!", book: book, user: user)
    expect(review).to be_valid
  end

  it "is invalid without a rating" do
    review = Review.new(rating: nil)
    expect(review).to_not be_valid
  end

  it "is invalid if a user has already reviewed the book" do
    book = Book.create(title: "Test Book", author: "Author", isbn: "12345")
    user = User.create(email: "user@example.com", password: "password")
    Review.create(rating: 4, content: "Great read", book: book, user: user)
    review = Review.new(rating: 5, content: "Loved it!", book: book, user: user)
    expect(review).to_not be_valid
  end
end

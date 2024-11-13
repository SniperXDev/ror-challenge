class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :title, :author, :publication_year, :isbn, presence: true
  validates :isbn, uniqueness: true
  # validate :valid_isbn

  # Update average rating whenever a review is added, updated, or destroyed
  after_save :update_average_rating
  after_destroy :update_average_rating

  def update_average_rating
    new_avg = reviews.average(:rating)&.round(2) || 0
    update_column(:average_rating, new_avg)
  end

  private

  # Custom validation method to check for a valid ISBN-10 or ISBN-13
  def valid_isbn
    return if isbn.nil? || isbn.blank?

    isbn = isbn.to_s.gsub(/[^0-9X]/i, "")

    if isbn.length == 10
      validate_isbn10(isbn)
    elsif isbn.length == 13
      validate_isbn13(isbn)
    else
      errors.add(:isbn, "must be a valid ISBN-10 or ISBN-13")
    end
  end

  # ISBN-10 checksum validation
  def validate_isbn10(isbn)
    check_digit = isbn[-1]
    sum = 0
    9.times { |i| sum += (10 - i) * isbn[i].to_i }
    checksum = (11 - (sum % 11)) % 11
    checksum = "X" if checksum == 10

    unless check_digit.upcase == checksum
      errors.add(:isbn, "is not a valid ISBN-10")
    end
  end

  # ISBN-13 checksum validation
  def validate_isbn13(isbn)
    sum = 0
    isbn.chars.each_with_index do |digit, index|
      sum += digit.to_i * (index.even? ? 1 : 3)
    end

    unless sum % 10 == 0
      errors.add(:isbn, "is not a valid ISBN-13")
    end
  end
end

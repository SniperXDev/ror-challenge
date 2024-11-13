class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :title, :author, :publication_year, :isbn, presence: true
  validates :isbn, uniqueness: true

  # Update average rating whenever a review is added, updated, or destroyed
  after_save :update_average_rating
  after_destroy :update_average_rating

  def update_average_rating
    new_avg = reviews.average(:rating)&.round(2) || 0
    update_column(:average_rating, new_avg)
  end
end

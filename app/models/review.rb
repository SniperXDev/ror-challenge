class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :book_id, message: "can only review a book once" }
end
